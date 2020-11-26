const authService = require('@services/auth');

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
  async logIn(req, res) {},
};

module.exports = authController;
