const { PARAMS, REGEX } = require('@/middlewares/validator/config');

const NOT_FOUND = -1;
const ZERO = 0;

exports.validateId = (id) => {
  if (
    id.length < PARAMS.ID.MIN_LENGTH ||
    id.length > PARAMS.ID.MAX_LENGTH ||
    id.search(REGEX.WHITE_SPACE) !== NOT_FOUND
  ) {
    return false;
  }
  return true;
};

exports.validatePW = (pw) => {
  if (
    pw.length < PARAMS.PASSWORD.MIN_LENGTH ||
    pw.length > PARAMS.PASSWORD.MAX_LENGTH ||
    pw.search(REGEX.WHITE_SPACE) !== NOT_FOUND ||
    pw.search(REGEX.NUMBER) < ZERO ||
    pw.search(REGEX.ENG) < ZERO ||
    pw.search(REGEX.SPECIAL_CHAR) < ZERO
  ) {
    return false;
  }
  return true;
};

exports.validateEmail = (email) => {
  return REGEX.EMAIL.test(email);
};

exports.validateBirth = (birth) => {
  return REGEX.BIRTH.test(birth);
};

exports.validatePhone = (phone) => {
  return true;
};

exports.validateName = (name) => {
  return true;
};
