const logService = require('@services/log');

const redis = require('@models/redis');

const logController = {
  async delSession(req, res, next) {
    const { sid } = req.body;
    const client = redis.client();
    client.del(`session:${sid}`);
    await logService.update({ sid, isLoggedOut: true });
    res.json({ result: true });
  },
  async get(req, res) {
    const id = req.session.user;
    const num = Number(req.params.num);
    const result = await logService.getlogsByid({ id, num });
    res.json({ result });
  },
};
module.exports = logController;
