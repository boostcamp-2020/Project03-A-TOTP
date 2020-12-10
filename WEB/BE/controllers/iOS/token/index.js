const tokenService = require('@services/iOS/token');
const userService = require('@services/iOS/user');

const tokenController = {
  async addTokenList(req, res, next) {
    let { tokens } = req.body.data;
    const { user } = req;
    tokens = tokens.map((token) => {
      token.user_idx = user.idx;
      token.is_main = token.isMain;
      delete token.isMain;
      return token;
    });
    /** @TODO 트랜젝션 */
    await tokenService.addTokens(tokens);
    await userService.updateDateTimeByNow({ idx: user.idx });

    res.json({ message: 'ok' });
  },

  async getTokenList(req, res, next) {
    const { user } = req;
    const result = await tokenService.getTokens({ user_idx: user.idx });
    const data = {
      message: 'ok',
      data: {
        lastUpdate: user.last_update,
        tokens: result,
      },
    };
    res.json(data);
  },

  async updateToken(req, res, next) {
    const { id } = req.params;
    const { user } = req;
    const { token } = req.body.data;
    const result = await tokenService.updateToken(token, id);

    if (result !== 0) {
      /** @TODO 트랜젝션 */
      await userService.updateDateTimeByNow({ idx: user.idx });
      res.json({ message: 'ok' });
    } else res.status(400).json({ mgessage: 'There is no token' });
  },

  async delToken(req, res, next) {
    const { id } = req.params;
    const { user } = req;
    const result = await tokenService.delTokenByTokenId({ id });

    if (result !== 0) {
      /** @TODO 트랜젝션 */
      await userService.updateDateTimeByNow({ idx: user.idx });
      res.json(result);
    } else res.status(400).json({ mgessage: 'There is no token' });
  },

  async replaceToken(req, res, next) {
    const { user } = req;
    const { lastUpdate } = req.body.data;
    let { tokens } = req.body.data;
    tokens = tokens.map((token) => {
      token.user_idx = user.idx;
      token.is_main = token.isMain;
      delete token.isMain;
      return token;
    });
    /** @TODO 트랜젝션 */
    await tokenService.delTokenByUserId({ userIdx: user.idx });
    await tokenService.addTokens(tokens);
    await userService.updateDateTime({ lastUpdate, idx: user.idx });

    res.json('ok');
  },
};
module.exports = tokenController;
