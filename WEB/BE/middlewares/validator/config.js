exports.REGEX = {
  WHITE_SPACE: /\s/,
  NUMBER: /[0-9]/gi,
  ENG: /[a-zA-Z]/gi,
  SPECIAL_CHAR: /[`~!@#$%^&*|\\'";:\/?]/gi,
  EMAIL: /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/,
  BIRTH: /^\d{4}-\d{2}-\d{2}$/,
};

exports.PARAMS = {
  ID: {
    KEY: 'id',
    MIN_LENGTH: 8,
    MAX_LENGTH: 20,
  },
  PASSWORD: {
    KEY: 'password',
    MIN_LENGTH: 8,
    MAX_LENGTH: 20,
  },
  EMAIL: {
    KEY: 'email',
  },
  NAME: {
    KEY: 'name',
  },
  BIRTH: {
    KEY: 'birth',
  },
  PHONE: {
    KEY: 'phone',
  },
};

exports.ERR = {
  CODE: {
    BAD_REQUEST: 400,
    SERVER_ERROR: 500,
  },
  MSG: {
    ID: '유효하지 않은 형식의 아이디입니다.',
    PASSWORD: '유효하지 않은 형식의 비밀번호입니다.',
    EMAIL: '유효하지 않은 형식의 이메일입니다.',
    NAME: '유효하지 않은 형식의 이름입니다.',
    BIRTH: '유효하지 않은 형식의 생년월일입니다.',
    PHONE: '유효하지 않은 형식의 전화번호입니다.',
    MISSING: '입력되지 않은 값이 있습니다.',
    INVALID_KEY: '유효하지 않은 키값입니다. validator에 전달한 배열을 확인하세요.',
    NOT_ARRAY: 'prarms가 배열이 아닙니다.',
  },
};
