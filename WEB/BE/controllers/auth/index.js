const authService = require('@services/auth');
const { getEncryptedPassword } = require('@utils/bcrypt');
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
      const encryptedPassword = await getEncryptedPassword(password);
      const auth = await authService.checkAuth({ id, password: encryptedPassword });

      if (!auth) {
        return next(createError(400, '존재하지 않는 유저입니다.'));
      }

      /** @TOTO 세션 생성하고 세션ID 전달? */

      res.json({ auth });
    } catch (e) {
      next(createError(e));
    }
  },
};

module.exports = authController;
