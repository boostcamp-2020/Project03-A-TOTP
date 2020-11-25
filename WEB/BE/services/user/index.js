const usersModel = require('@models/sequelizeWEB.js').users;
const userService = {
  async check({ email, next }) {
    const query = {};
    query.where = { email };
    try {
      const result = await usersModel.findAll(query);
      return result.length === 0;
    } catch (e) {
      next(e);
    }
  },
  async insert({ userInfo, next }) {
    const query = {
      email: userInfo.email,
      name: userInfo.name,
      birth: userInfo.birth,
      phone: userInfo.phone,
    };
    try {
      const result = await usersModel.create(query);
      return result;
    } catch (e) {
      next(e);
    }
  },
};
module.exports = userService;
