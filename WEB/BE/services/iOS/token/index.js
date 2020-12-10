const { tokens: Token } = require('@models/sequelizeIOS');

const toeknService = {
  async addTokens(params) {
    console.log(params);
    await Token.bulkCreate(params, { ignoreDuplicates: true });
    return true;
  },

  async getTokens(params) {
    const result = await Token.findAll({ where: params });
    return result;
  },

  async updateToken(params, id) {
    console.log(params, id);
    const result = await Token.update(params, { where: { id } });
    return result;
  },

  async delToken({ id }) {
    const result = await Token.destroy({ where: { id } });
    return result;
  },
};

module.exports = toeknService;
