const createError = require('http-errors');
const ID_MIN_LENGTH = 8;
const ID_MAX_LENGTH = 20;
const PW_MIN_LENGTH = 8;
const PW_MAX_LENGTH = 20;
const WS_REGEX = /\s/;
const NUM_REGEX = /[0-9]/gi;
const ENG_REGEX = /[a-z]/gi;
const SC_REGEX = /[`~!@#$%^&*|\\\'\";:\/?]/gi;

const validateId = (id) => {
  if (id.length < ID_MIN_LENGTH || id.length > ID_MAX_LENGTH || id.search(WS_REGEX) !== -1) {
    return false;
  }
  return true;
};

const validatePw = (pw) => {
  if (
    pw.length < PW_MIN_LENGTH ||
    pw.length > PW_MAX_LENGTH ||
    pw.search(WS_REGEX) !== -1 ||
    pw.search(NUM_REGEX) < 0 ||
    pw.search(ENG_REGEX) < 0 ||
    pw.search(SC_REGEX) < 0
  ) {
    return false;
  }
  return true;
};

const validator = {
  logIn(req, res, next) {
    const { id, password } = req.body;

    if (!id || !password) {
      return next(createError(400, '아이디 또는 비밀번호가 잘못되었습니다.'));
    }
    if (!validateId(id)) {
      return next(createError(400, '잘못된 아이디입니다.'));
    }
    if (!validatePw(password)) {
      return next(createError(400, '잘못된 비밀번호입니다.'));
    }
    return next();
  },
  signUp() {},
};

module.exports = { validator };
