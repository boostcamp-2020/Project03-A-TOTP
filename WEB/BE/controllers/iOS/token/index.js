const tokenService = require('@services/iOS/token');
const userService = require('@services/iOS/user');
const DB = require('@models/sequelizeIOS');

const tokenController = {
  async addTokenList(req, res) {
    let { tokens } = req.body;
    const { user } = req;

    tokens = tokens.map((token) => {
      return {
        ...token,
        user_idx: user.idx,
        is_main: token.isMain,
      };
    });

    await DB.sequelize.transaction(async () => {
      await tokenService.addTokens(tokens);
      await userService.updateDateTimeByNow({ idx: user.idx });
    });
    res.json({ message: 'ok' });
  },

  async getTokenList(req, res) {
    const { user } = req;
    const tokens = await tokenService.getTokens({ user_idx: user.idx });

    const response = {
      message: 'ok',
      data: {
        lastUpdate: user.last_update,
        tokens: tokens.map((token) => {
          return {
            ...token,
            isMain: token.isMain === 1,
          };
        }),
      },
    };
    res.json(response);
  },

  async updateToken(req, res) {
    const { id } = req.params;
    const { user } = req;
    const { token } = req.body;
    await DB.sequelize.transaction(async () => {
      const result = await tokenService.updateToken(token, id);

      if (result !== 0) {
        await userService.updateDateTimeByNow({ idx: user.idx });
        res.json({ message: 'ok' });
      } else res.status(400).json({ mgessage: 'There is no token' });
    });
  },

  async delToken(req, res) {
    const { id } = req.params;
    const { user } = req;
    await DB.sequelize.transaction(async () => {
      const result = await tokenService.delTokenByTokenId({ id });

      if (result !== 0) {
        await userService.updateDateTimeByNow({ idx: user.idx });
        res.json({ message: 'ok' });
      } else res.status(400).json({ mgessage: 'There is no token' });
    });
  },

  async replaceToken(req, res) {
    const { user } = req;
    const { lastUpdate } = req.body.data;
    let { tokens } = req.body.data;
    tokens = tokens.map((token) => {
      token.user_idx = user.idx;
      token.is_main = token.isMain;
      delete token.isMain;
      return token;
    });

    await DB.sequelize.transaction(async (t) => {
      await tokenService.delTokenByUserId({ userIdx: user.idx }, t);
      await tokenService.addTokens(tokens, t);
      await userService.updateDateTime({ lastUpdate, idx: user.idx }, t);
    });
    res.json({ message: 'ok' });
  },
};
module.exports = tokenController;
