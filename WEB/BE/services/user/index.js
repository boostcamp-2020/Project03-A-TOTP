const model = require('@models/sequelizeWEB.js');

function userService() {}

userService.check = async ({ email, next }) => {
  const usersModel = model.users;
  const query = {};
  query.where = { email };
  try {
    const result = await usersModel.findAll(query);
    return result.length === 0;
  } catch (e) {
    next(e);
  }
};

userService.insert = async ({ userInfo, next }) => {
  const usersModel = model.users;
  const query = { email: userInfo.email, name: userInfo.name, birth: userInfo.birth, phone: userInfo.phone };
  try {
    const result = await usersModel.create(query);
    return result;
  } catch (e) {
    next(e);
  }
};

module.exports = userService;
