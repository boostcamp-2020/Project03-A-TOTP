const { devices: Device } = require('@models/sequelizeIOS');

const deviceService = {
  async addDevice(params) {
    const device = await Device.create(params);
    return device;
  },

  async getDeviceByUdid({ udid }) {
    const device = await Device.findOne({ where: { udid } });
    return device;
  },
};

module.exports = deviceService;
