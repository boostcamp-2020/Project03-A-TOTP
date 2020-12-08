const logService = require('@services/log');

const authController = {
  async get(req, res) {
    const id = req.session.user;
    const num = Number(req.params.num);
    const result = await logService.getlogsByid({ id, num });
    res.json({ result });
  },
};

module.exports = authController;
