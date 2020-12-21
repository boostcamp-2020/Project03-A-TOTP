const {
  validateId,
  validatePW,
  validateEmail,
  validateBirth,
  validateName,
  validatePhone,
  validateTOTP,
} = require('@/middlewares/validator/validators');

const { PARAMS, ERR } = require('@middlewares/validator/constants');

const validatorConfig = {
  [PARAMS.ID.KEY]: {
    validator: validateId,
    errCode: ERR.CODE.BAD_REQUEST,
    errMsg: ERR.MSG.ID,
  },
  [PARAMS.PASSWORD.KEY]: {
    validator: validatePW,
    errCode: ERR.CODE.BAD_REQUEST,
    errMsg: ERR.MSG.PASSWORD,
  },
  [PARAMS.EMAIL.KEY]: {
    validator: validateEmail,
    errCode: ERR.CODE.BAD_REQUEST,
    errMsg: ERR.MSG.EMAIL,
  },
  [PARAMS.BIRTH.KEY]: {
    validator: validateBirth,
    errCode: ERR.CODE.BAD_REQUEST,
    errMsg: ERR.MSG.BIRTH,
  },
  [PARAMS.NAME.KEY]: {
    validator: validateName,
    errCode: ERR.CODE.BAD_REQUEST,
    errMsg: ERR.MSG.NAME,
  },
  [PARAMS.PHONE.KEY]: {
    validator: validatePhone,
    errCode: ERR.CODE.BAD_REQUEST,
    errMsg: ERR.MSG.PHONE,
  },
  [PARAMS.TOTP.KEY]: {
    validator: validateTOTP,
    errCode: ERR.CODE.BAD_REQUEST,
    errMsg: ERR.MSG.TOTP,
  },
};

module.exports = { validatorConfig };
