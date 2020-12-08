const authsModel = require('@models/sequelizeWEB.js').auths;
const { users } = require('@models/sequelizeWEB.js');

const authService = {
  async check({ id }) {
    const query = {};
    query.where = { id };
    const result = await authsModel.findAll(query);
    return result.length === 0;
  },

  async insert({ idx, id, password, isVerified, secretKey }) {
    const query = { id, password, is_verified: isVerified, secret_key: secretKey, user_idx: idx };
    const result = await authsModel.create(query);
    return result;
  },

  async update({ info }) {
    const query = {
      is_verified: info.isVerified,
    };
    const where = {
      user_idx: info.idx,
    };
    const result = await authsModel.update(query, { where });

    return result;
  },

  async getAuthById({ id }) {
    const result = await authsModel.findOne({ where: { id } });
    return result;
  },

  async getAuth(where) {
    const result = await authsModel.findOne({ where });
    return result;
  },

  async getUserById({ id }) {
    const query = {
      attributes: [],
      include: [
        {
          model: users,
        },
      ],
      where: {
        id,
      },
    };
    const result = await authsModel.findOne(query);
    return result;
  },

  async updatePassword(password, id) {
    const query = { password };
    const where = { id };
    const result = await authsModel.update(query, { where });
    return result;
  },

  async reissueSecretKey({ id, secretKey }) {
    const query = { secret_key: secretKey };
    const where = { id };
    const result = await authsModel.update(query, { where });
    return result;
  },
};

module.exports = authService;
