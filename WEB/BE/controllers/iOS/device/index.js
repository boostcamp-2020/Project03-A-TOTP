const deviceService = require('@services/iOS/device');
const createError = require('http-errors');

const deviceController = {
  async getDevice(req, res, next, udid) {
    try {
      const device = await deviceService.getDeviceByUdid({ udid });

      if (!device) {
        return next(createError(400, 'invalid udid'));
      }

      req.device = device;
      next();
    } catch (e) {
      throw new Error(e);
    }
  },

  async updateBackup(req, res) {
    const { device } = req;
    const { backup } = req.body;

    await device.update({ backup }, { returning: true });

    res.json({ message: 'OK' });
  },

  async updateName(req, res) {
    const { device } = req;
    const { name } = req.body;

    await device.update({ name }, { returning: true });

    res.json({ message: 'OK' });
  },

  async deleteDevice(req, res) {
    const { device } = req;

    await device.destroy();

    res.json({ message: 'OK' });
  },
};

module.exports = deviceController;
