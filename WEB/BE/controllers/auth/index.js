const authService = require('@services/auth');
const userService = require('@services/user');

function authController() {}

authController.check = async (req, res, next) => {
  const { id, email } = req.body;
  console.log(id, email);
  try {
    const result = id ? await authService.check({ id }) : await userService.check({ email });
    res.json({ result });
  } catch (e) {
    next(e);
  }
};

module.exports = authController;
