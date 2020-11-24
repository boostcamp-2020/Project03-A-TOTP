const model = require('@models/sequelizeWEB.js');

function authService() {}

authService.check = async ({ id }) => {
  const authsModel = model.auths;
  const query = {};
  query.where = { id };
  const result = await authsModel.findAll(query);
  return result.length === 0;
};

module.exports = authService;
