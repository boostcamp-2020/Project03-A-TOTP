const createError = require('http-errors');
const { ERR } = require('@/middlewares/validator/constants');
const { validatorConfig } = require('@/middlewares/validator/config');

const validator = (params) => {
  const { CODE, MSG } = ERR;

  return (req, res, next) => {
    if (!Array.isArray(params)) {
      return next(createError(CODE.SERVER_ERROR, MSG.NOT_ARRAY));
    }

    if (!req.body) {
      return next(createError(CODE.SERVER_ERROR, MSG.CANNOT_READ_BODY));
    }

    // params 배열의 값 중에 config에 등록되지 않은 값이 있는지 체크
    const hasWrongParameter = !params.every((param) => Object.hasOwnProperty.bind(validatorConfig)(param));

    if (hasWrongParameter) {
      return next(createError(CODE.BAD_REQUEST, MSG.INVALID_KEY));
    }

    // prarms 배열에 있는 값들이 전부 body에도 있는지 체크
    const hasEmptyParameter = !params.every((param) => req.body[param]);

    if (hasEmptyParameter) {
      return next(createError(CODE.BAD_REQUEST, MSG.MISSING));
    }

    for (const param of params) {
      const { validator, errCode, errMsg } = validatorConfig[param];
      const value = req.body[param];

      if (!validator(value)) {
        return next(createError(errCode, errMsg));
      }
    }

    next();
  };
};

module.exports = { validator };
