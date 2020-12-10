const { users: User } = require('@models/sequelizeIOS');
const { devices: Device } = require('@models/sequelizeIOS');
const { tokens: Token } = require('@models/sequelizeIOS');

const userService = {
  async addUser(params) {
    const user = await User.create(params);
    return user;
  },

  async getUserByEmail({ email }) {
    const user = await User.findOne({
      include: [{ model: Device }, { model: Token }],
      where: { email },
    });
    return user;
  },

  async getUserByIdx({ idx }) {
    const user = await User.findByPk(idx, {
      include: [{ model: Device }, { model: Token }],
    });
    return user;
  },

  async updateDateTimeByNow({ idx }) {
    await User.update({ last_update: Date.now() }, { where: { idx } });
  },
};

module.exports = userService;
