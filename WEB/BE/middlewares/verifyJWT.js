const authService = require('@/services/web/auth');
const totp = require('@/utils/totp');
const JWT = require('jsonwebtoken');
const createError = require('http-errors');

const verifyJWT = {
  async verifyTOTP(req, res, next) {
    try {
      const { authToken, totp: digits } = req.body;
      const { id, action } = JWT.verify(authToken, process.env.ENCRYPTIONKEY);
      req.body.id = id;
      req.body.action = action;

      const lastOtp = await authService.getOTPById({ id });
      if (String(lastOtp) === digits)
        next(createError(400, '한번 사용된 OTP입니다 다음 OTP 정보를 이용하세요'));

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
