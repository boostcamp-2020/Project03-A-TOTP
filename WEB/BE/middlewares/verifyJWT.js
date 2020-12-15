const authService = require('@/services/web/auth');
const totp = require('@/utils/totp');
const JWT = require('jsonwebtoken');
const createError = require('http-errors');
const DB = require('@models/sequelizeIOS');
const { emailSender } = require('@utils/emailSender');
const { decryptWithAES256 } = require('@utils/crypto');

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

      if (!(await checkLoingCount(id, next))) return;

      const secretKey = (await authService.getAuthById({ id })).secret_key;
      const result = totp.verifyDigits(secretKey, digits);
      if (!result) {
        await authService.loginFail({ id });
        next(createError(400, 'TOTP 6자리가 틀렸습니다.'));
      }
      next();
    } catch (e) {
      next(e);
    }
  },
};

const checkLoingCount = async (id, next) => {
  const auth = await authService.getUserById({ id });
  const {
    user: { email, name, idx },
  } = auth;
  if (auth.login_fail_count === 5) {
    /** @TODO 트랜젝션 */
    await DB.sequelize.transaction(async () => {
      await authService.userDeactivation({ id });
      await authService.loginFail({ id });
    });

    await emailSender.SignUpAuthentication(
      decryptWithAES256({ encryptedText: email }),
      decryptWithAES256({ encryptedText: name }),
      idx
    );
    next(createError(401, '5번 연속 틀리셨습니다 등록된 Email에서 다시 인증해 주세요'));
    return false;
  }
  if (auth.login_fail_count >= 5) {
    next(createError(400, '5번 연속 틀리셨습니다 등록된 Email에서 다시 인증해 주세요'));
    return false;
  }
  return true;
};

module.exports = { verifyJWT };
