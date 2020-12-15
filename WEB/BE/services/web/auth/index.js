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
      login_fail_count: info.loginFailCount,
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
      include: [{ model: users }],
      where: { id },
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

  async updateOTP({ id, totp }) {
    const result = await authsModel.update({ last_totp: totp }, { where: { id } });
    return result;
  },

  async getOTPById({ id }) {
    const result = await authsModel.findOne({ where: { id } });
    return result.last_totp;
  },

  async loginFail({ id }) {
    const result = await authsModel.increment({ login_fail_count: +1 }, { where: { id } });
    return result;
  },

  async setLoginFailCount({ id }) {
    const result = await authsModel.update({ login_fail_count: 0 }, { where: { id } });
    return result;
  },

  async userDeactivation({ id }) {
    const result = await authsModel.update({ is_verified: false }, { where: { id } });
    return result;
  },
};

module.exports = authService;
