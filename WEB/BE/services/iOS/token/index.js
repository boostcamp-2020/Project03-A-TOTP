const { tokens: Token } = require('@models/sequelizeIOS');

const tokenService = {
  async addTokens(params) {
    const result = await Token.bulkCreate(params, { ignoreDuplicates: true });
    return result;
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

  async delTokenByTokenId({ id }) {
    const result = await Token.destroy({ where: { id } });
    return result;
  },

  async delTokenByUserId({ userIdx }) {
    const result = await Token.destroy({ where: { user_idx: userIdx } });
    return result;
  },
};

module.exports = tokenService;
