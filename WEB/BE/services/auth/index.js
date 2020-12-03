const authsModel = require('@models/sequelizeWEB.js').auths;
const { users } = require('@models/sequelizeWEB.js');

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

  async update({ info, next }) {
    const query = {
      state: info.state,
    };
    const where = {
      user_idx: info.idx,
    };
    try {
      const result = await authsModel.update(query, { where });

      return result;
    } catch (e) {
      next(e);
    }
  },

  async getAuthById({ id }) {
    try {
      const result = await authsModel.findOne({ where: { id } });
      return result;
    } catch (e) {
      throw new Error(e);
    }
  },

  async getAuth(where) {
    try {
      const result = await authsModel.findOne({ where });
      return result;
    } catch (e) {
      throw new Error(e);
    }
  },

  async getUserById({ id }) {
    const query = {
      attributes: [],
      include: [
        {
          model: users,
          attributes: ['email', 'name'],
        },
      ],
      where: {
        id,
      },
    };
    try {
      const result = await authsModel.findOne(query);
      return result;
    } catch (e) {
      throw new Error(e);
    }
  },
};

module.exports = authService;
