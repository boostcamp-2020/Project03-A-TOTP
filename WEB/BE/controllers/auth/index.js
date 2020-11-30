const authService = require('@services/auth');
const { comparePassword } = require('@utils/bcrypt');
const createError = require('http-errors');

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
    const { id, password } = req.body;
    try {
      const user = await authService.getAuthById({ id });

      if (!user) {
        return next(createError(400, '존재하지 않는 유저입니다.'));
      }

      const isValidPassword = await comparePassword(password, user.password);

      if (!isValidPassword) {
        return next(createError(400, '비밀번호가 일치하지 않습니다.'));
      }

      /** @TOTO 세션 생성하고 세션ID 전달? */

      res.json({ id: user.id });
    } catch (e) {
      next(createError(e));
    }
  },
};

module.exports = authController;
