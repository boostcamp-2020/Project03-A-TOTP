const usersModel = require('@models/sequelizeWEB.js').users;
const { auths } = require('@models/sequelizeWEB.js');

const userService = {
  async check({ email }) {
    const query = {};
    query.where = { email };
    const result = await usersModel.findAll(query);
    return result.length === 0;
  },

  async insert({ userInfo }) {
    const query = {
      email: userInfo.email,
      name: userInfo.name,
      birth: userInfo.birth,
      phone: userInfo.phone,
    };
    const result = await usersModel.create(query);
    return result;
  },

  async findAuthByUser({ userInfo }) {
    const query = {
      attributes: [],
      include: [
        {
          model: auths,
          attributes: ['id'],
        },
      ],
      where: {
        email: userInfo.email,
        name: userInfo.name,
        birth: userInfo.birth,
      },
    };

    const result = await usersModel.findOne(query);
    return result;
  },

  async getUserByIdx({ idx }) {
    const result = await usersModel.findOne({ where: { idx } });
    return result;
  },
};
module.exports = userService;
