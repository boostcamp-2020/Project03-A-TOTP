const model = require('@models/sequelizeWEB.js');

function userService() {}

userService.check = async ({ email }) => {
  const usersModel = model.users;
  const query = {};
  query.where = { email };
  const result = await usersModel.findAll(query);
  return result.length === 0;
};

module.exports = userService;
