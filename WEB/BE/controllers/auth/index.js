const authService = require('@services/auth');

function authController() {}

authController.dupId = async (req, res, next) => {
  const { id } = req.body;
  try {
    const result = await authService.check({ id, next });
    res.json({ result });
  } catch (e) {
    next(e);
  }
};

module.exports = authController;
