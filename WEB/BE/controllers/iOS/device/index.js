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

    const updatedDevice = await device.update({ backup }, { returning: true });

    res.json({ backup: updatedDevice.backup });
  },

  async updateName(req, res) {
    const { device } = req;
    const { name } = req.body;

    const updatedDevice = await device.update({ name }, { returning: true });

    res.json({ name: updatedDevice.name });
  },

  async deleteDevice(req, res) {
    const { device } = req;

    const deletedDevice = await device.destroy();

    res.json({ udid: deletedDevice.udid });
  },
};

module.exports = deviceController;
