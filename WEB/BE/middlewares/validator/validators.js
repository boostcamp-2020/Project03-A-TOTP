const { PARAMS, REGEX } = require('@/middlewares/validator/constants');

const NOT_FOUND = -1;

// validator 조건 함수

const longerThan = (param, len) => param.length > len;

const shorterThan = (param, len) => param.length < len;

const hasWhiteSpace = (param) => param.search(REGEX.WHITE_SPACE) !== NOT_FOUND;

const hasNumber = (param) => param.search(REGEX.NUMBER) !== NOT_FOUND;

const hasAlphabet = (param) => param.search(REGEX.ENG) !== NOT_FOUND;

const hasSpecialCharacter = (param) => param.search(REGEX.SPECIAL_CHAR) !== NOT_FOUND;

// validator 함수

exports.validateId = (id) =>
  !(longerThan(id, PARAMS.ID.MAX_LENGTH) || shorterThan(id, PARAMS.ID.MIN_LENGTH) || hasWhiteSpace(id));

exports.validatePW = (pw) =>
  !(
    longerThan(pw, PARAMS.PASSWORD.MAX_LENGTH) ||
    shorterThan(pw, PARAMS.PASSWORD.MIN_LENGTH) ||
    hasWhiteSpace(pw) ||
    !hasNumber(pw) ||
    !hasAlphabet(pw) ||
    !hasSpecialCharacter(pw)
  );

exports.validateEmail = (email) => REGEX.EMAIL.test(email);

exports.validateBirth = (birth) => REGEX.BIRTH.test(birth);

exports.validatePhone = (phone) => REGEX.PHONE.test(phone);

exports.validateName = (name) =>
  !(
    longerThan(name, PARAMS.NAME.MAX_LENGTH) ||
    shorterThan(name, PARAMS.NAME.MIN_LENGTH) ||
    hasWhiteSpace(name)
  );

exports.validateTOTP = (totp) => REGEX.TOTP.test(totp);
