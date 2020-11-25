const authsModel = require('@models/sequelizeWEB.js').auths;
const authService = {
  async check({ id, next }) {
    const query = {};
    query.where = { id };
    try {
      const result = await authsModel.findAll(query);
      return result.length === 0;
    } catch (e) {
      next(e);
    }
  },
  async insert({ idx, id, password, state, secretKey, next }) {
    const query = { id, password, state, secret_key: secretKey, user_idx: idx };
    try {
      const result = await authsModel.create(query);
      return result;
    } catch (e) {
      next(e);
    }
  },
};

module.exports = authService;
