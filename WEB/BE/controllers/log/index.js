const logService = require('@services/log');
const redis = require('@models/redis');

const logController = {
  delSession(req, res, next) {
    const { sid } = req.body;

    const client = redis.client();
    client.del(sid);
    logService.update({ sid, isLoggedOut: true });
    res.json({ result: true });
  },
};
module.exports = logController;
