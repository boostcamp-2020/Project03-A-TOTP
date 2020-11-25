const model = require('@models/sequelizeWEB.js');
const authsModel = model.auths;
function authService() {}

authService.check = async ({ id, next }) => {
  const query = {};
  query.where = { id };
  try {
    const result = await authsModel.findAll(query);
    return result.length === 0;
  } catch (e) {
    next(e);
  }
};

authService.insert = async ({ idx, id, password, state, secretKey, next }) => {
  const query = { id, password, state, secret_key: secretKey, user_idx: idx };
  try {
    const result = await authsModel.create(query);
    return result;
  } catch (e) {
    next(e);
  }
};

module.exports = authService;
