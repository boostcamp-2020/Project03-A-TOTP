const createError = require('http-errors');
const { PARAMS, ERR } = require('@/middlewares/validator/config');
const {
  validateId,
  validatePW,
  validateEmail,
  validateBirth,
  validateName,
  validatePhone,
} = require('@/middlewares/validator/validators');

const validatorObj = {
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
};

const validator = (params) => {
  return (req, res, next) => {
    if (!Array.isArray(params)) {
      return next(createError(ERR.CODE.SERVER_ERROR, ERR.MSG.NOT_ARRAY));
    }

    const hasWrongParameter = !params.every((param) => Object.hasOwnProperty.bind(validatorObj)(param));

    if (hasWrongParameter) {
      return next(createError(ERR.CODE.BAD_REQUEST, ERR.MSG.INVALID_KEY));
    }

    const hasEmptyParameter = !params.every((param) => req.body[param]);

    if (hasEmptyParameter) {
      return next(createError(ERR.CODE.BAD_REQUEST, ERR.MSG.MISSING));
    }

    for (const param of params) {
      const { validator, errCode, errMsg } = validatorObj[param];
      const value = req.body[param];

      if (!validator(value)) {
        return next(createError(errCode, errMsg));
      }
    }

    next();
  };
};

module.exports = { validator };
