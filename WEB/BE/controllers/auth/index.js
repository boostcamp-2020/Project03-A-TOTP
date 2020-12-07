const totp = require('@/utils/totp');
const authService = require('@services/auth');
const userService = require('@services/user');
const { comparePassword, getEncryptedPassword } = require('@utils/bcrypt');
const { encryptWithAES256, decryptWithAES256 } = require('@utils/crypto');
const { emailSender } = require('@/utils/emailSender');
const createError = require('http-errors');
const JWT = require('jsonwebtoken');

const TEN_MINUTES = '10m';
const ACIONS = {
  FIND_PW: 'FIND_PW',
  LOGIN: 'LOGIN',
};

const authController = {
  async dupId(req, res, next) {
    const { id } = req.body;
    try {
      const result = await authService.check({ id, next });
      res.json({ result });
    } catch (e) {
      next(e);
    }
  },

  async logIn(req, res, next) {
    try {
      const { id, password } = req.body;
      const user = await authService.getAuthById({ id });

      if (!user) return next(createError(400, '존재하지 않는 유저입니다.'));

      const isValidPassword = await comparePassword(password, user.password);

      if (!isValidPassword) return next(createError(400, '비밀번호가 일치하지 않습니다.'));

      const token = JWT.sign({ id, action: ACIONS.LOGIN }, process.env.ENCRYPTIONKEY, {
        expiresIn: TEN_MINUTES,
      });

      res.json({ id: user.id, authToken: token });
    } catch (e) {
      next(createError(e));
    }
  },

  async logInSuccess(req, res, next) {
    const { action, id } = req.body;
    if (action !== ACIONS.LOGIN) return next(createError(401, '잘못된 요청입니다'));
    try {
      req.session.key = id;
      /**
       * @TODO Log 에 저장하기
       * `session:${session.id}`
       */
      res.json({ result: true });
    } catch (e) {
      next(e);
    }
  },

  async sendPasswordToken(req, res, next) {
    try {
      const { id, name, birth } = req.body;
      const auth = await authService.getAuth({ id });

      if (!auth) return next(createError(400, '존재하지 않는 아이디입니다.'));

      const user = await userService.getUserByIdx({ idx: auth.user_idx });

      if (!user) return next(createError(500, '유저정보가 존재하지 않습니다.'));
      if (
        encryptWithAES256({ Text: name }) !== user.name ||
        encryptWithAES256({ Text: birth }) !== user.birth
      ) {
        return next(createError(400, '입력한 정보가 일치하지 않습니다.'));
      }

      const token = JWT.sign({ id, action: ACIONS.FIND_PW }, process.env.ENCRYPTIONKEY, {
        expiresIn: TEN_MINUTES,
      });

      res.json({
        message: 'OTP를 입력해 주세요',
        authToken: token,
      });
    } catch (e) {
      next(createError(e));
    }
  },

  async sendPasswordEmail(req, res, next) {
    try {
      const { id, action } = req.body;

      if (action !== ACIONS.FIND_PW) return next(createError(401, '잘못된 요청입니다'));

      /** @TOTO 이메일 전송 */
      // 토큰이 있다는건 아이디가 있다는 것을 전제하고 구현
      const user = await authService.getUserById({ id });
      const userInfo = {
        email: decryptWithAES256({ encryptedText: user.user.email }),
        name: decryptWithAES256({ encryptedText: user.user.name }),
        id,
      };
      emailSender.sendPassword(userInfo);

      res.send('ok');
    } catch (e) {
      next(createError(e));
    }
  },

  async changePassword(req, res, next) {
    try {
      const { password } = req.body;
      const { user } = req.query;
      const userdata = decryptWithAES256({ encryptedText: user }).split(' ');
      const id = userdata[0];
      const time = userdata[1];
      if (time < Date.now()) {
        res.status(400).json({ message: '요청이 만료되었습니다.' });
        return;
      }
      const encryptPassword = await getEncryptedPassword(password);
      await authService.updatePassword(encryptPassword, id);
      res.json({ message: '변경 완료' });
    } catch (e) {
      next(createError(e));
    }
  },

  async sendSecretKeyEmail(req, res) {
    // 이전에 id와 secretKey를 저장했다고 가정
    const { id, secretKey } = req.body;
    const { user } = await authService.getUserById({ id });

    await emailSender.sendSecretKey({
      id,
      email: decryptWithAES256({ encryptedText: user.email }),
      name: decryptWithAES256({ encryptedText: user.name }),
      totpURL: totp.makeURL({ secretKey, email: user.email }),
    });

    res.json({ message: 'ok' });
  },
};

module.exports = authController;
