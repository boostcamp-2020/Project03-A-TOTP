const totp = require('@/utils/totp');
const authService = require('@services/auth');
const userService = require('@services/user');
const logService = require('@services/log');
const { comparePassword, getEncryptedPassword } = require('@utils/bcrypt');
const { encryptWithAES256, decryptWithAES256 } = require('@utils/crypto');
const { emailSender } = require('@/utils/emailSender');
const createError = require('http-errors');
const JWT = require('jsonwebtoken');
const { makeRandom } = require('@utils/random');
const UAParser = require('ua-parser-js');
const axios = require('axios');

const TEN_MINUTES = '10m';
const ACIONS = {
  FIND_PW: 'FIND_PW',
  LOGIN: 'LOGIN',
};

const authController = {
  async dupId(req, res) {
    const { id } = req.body;
    const result = await authService.check({ id });
    res.json({ result });
  },

  async logIn(req, res, next) {
    const { id, password } = req.body;
    const user = await authService.getAuthById({ id });

    if (!user) return next(createError(400, '존재하지 않는 유저입니다.'));

    const isValidPassword = await comparePassword(password, user.password);

    if (!isValidPassword) return next(createError(400, '비밀번호가 일치하지 않습니다.'));

    const token = JWT.sign({ id, action: ACIONS.LOGIN }, process.env.ENCRYPTIONKEY, {
      expiresIn: TEN_MINUTES,
    });

    res.json({ authToken: token });
  },

  async logInSuccess(req, res, next) {
    const { action, id } = req.body;

    if (action !== ACIONS.LOGIN) return next(createError(401, '잘못된 요청입니다'));

    const csrfToken = makeRandom();

    req.session.user = id;
    req.session.CSRF_TOKEN = csrfToken;
    const userAgent = UAParser(req.headers['user-agent']);
    const { ip } = req;
    const params = await makeLogData({ ip, userAgent, id, sid: req.session.id });
    await logService.insert({ params });

    res.cookie('csrfToken', csrfToken, {
      maxAge: 2 * 60 * 60 * 1000,
    });
    res.json({ result: true, csrfToken });
  },

  async sendPasswordToken(req, res, next) {
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
  },

  async sendPasswordEmail(req, res, next) {
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
  },

  async changePassword(req, res) {
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
  },

  async sendSecretKeyEmail(req, res) {
    const { authToken } = req.body;
    const { id } = JWT.verify(authToken, process.env.ENCRYPTIONKEY);
    const { user } = await authService.getUserById({ id });
    const secretKey = totp.makeSecretKey();

    await authService.reissueSecretKey({ id, secretKey });
    await emailSender.sendSecretKey({
      id,
      email: decryptWithAES256({ encryptedText: user.email }),
      name: decryptWithAES256({ encryptedText: user.name }),
      totpURL: totp.makeURL({ secretKey, email: user.email }),
    });

    res.json({ message: 'ok' });
  },

  async checkPassword(req, res, next) {
    const { password } = req.body;
    const id = req.session.user;
    const user = await authService.getAuthById({ id });

    if (!user) return next(createError(400, '존재하지 않는 유저입니다.'));

    const isValidPassword = await comparePassword(password, user.password);

    if (!isValidPassword) return next(createError(400, '비밀번호가 일치하지 않습니다.'));

    res.json({ result: true });
  },
};

const makeLogData = async ({ ip, userAgent, id, sid }) => {
  const device = userAgent.device.model
    ? `${userAgent.device.model} ${userAgent.os.name}`
    : `${userAgent.os.name} ${userAgent.browser.name}`;
  // let location = await axios(`http://ip-api.com/json/${'221.141.23.33'}`);
  // location = location.data.status === 'fail' ? '알 수 없는 지역' : location.regionName;
  const location = 'seoul';
  return {
    access_time: new Date(),
    status: 0,
    ip_address: ip.substring(7),
    device,
    location,
    auth_id: id,
    sid,
  };
};

module.exports = authController;
