const authService = require('@/services/auth');
const totp = require('@/utils/totp');
const JWT = require('jsonwebtoken');
const createError = require('http-errors');

const verifyJWT = {
  async verifyTOTP(req, res, next) {
    try {
      const { authToken, totp: digits } = req.body;
      const { id, action } = JWT.verify(authToken, process.env.ENCRYPTIONKEY);
      req.body.action = action;
      const secretKey = (await authService.getAuthById({ id })).secret_key;
      const result = totp.verifyDigits(secretKey, digits);
      if (!result) next(createError(400, 'TOTP 6자리가 틀렸습니다.'));
      next();
    } catch (e) {
      next(e);
    }
  },
};

module.exports = { verifyJWT };
