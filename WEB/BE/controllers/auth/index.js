const authService = require('@services/auth');
const userService = require('@services/user');
const { comparePassword } = require('@utils/bcrypt');
const { encryptWithAES256 } = require('@utils/crypto');
const createError = require('http-errors');
const JWT = require('jsonwebtoken');

const JWT_TIME_LIMIT = '10m';

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

      /** @TOTO 세션 생성하고 세션ID 전달? */

      res.json({ id: user.id });
    } catch (e) {
      next(createError(e));
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

      const token = JWT.sign({ id, action: 'PW_EMAIL' }, process.env.ENCRYPTIONKEY, {
        expiresIn: JWT_TIME_LIMIT,
      });

      res.json({
        message: 'OTP를 입력해 주세요',
        passwordToken: token,
      });
    } catch (e) {
      next(createError(e));
    }
  },
};

module.exports = authController;
