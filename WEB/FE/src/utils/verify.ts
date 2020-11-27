const ID_MIN_LENGTH = 8;
const ID_MAX_LENGTH = 20;
const PW_MIN_LENGTH = 8;
const PW_MAX_LENGTH = 20;
const WS_REGEX = /\s/;
const NUM_REGEX = /[0-9]/gi;
const ENG_REGEX = /[a-zA-Z]/gi;
const SC_REGEX = /[`~!@#$%^&*|\\'";:/?]/gi;

interface Form {
  id: string;
  password: string;
  rePassword: string;
  name: string;
  birth: string;
  email: string;
  phone: string;
}

export const verify = (form: Form): string => {
  if (form.id.length < ID_MIN_LENGTH || form.id.length > ID_MAX_LENGTH || form.id.search(WS_REGEX) !== -1)
    return '아이디가 조건에 맞지 않습니다.';
  if (
    form.password.length < PW_MIN_LENGTH ||
    form.password.length > PW_MAX_LENGTH ||
    form.password.search(WS_REGEX) !== -1 ||
    form.password.search(NUM_REGEX) < 0 ||
    form.password.search(ENG_REGEX) < 0 ||
    form.password.search(SC_REGEX) < 0
  )
    return '비밀번호가 조건에 맞지 않습니다.';
  if (form.password !== form.rePassword) return '비밀번호가 일치하지 않습니다.';
  if (!form.id || !form.password || !form.email || !form.name || !form.birth || !form.phone)
    return '입력되지 않은 값이 있습니다.';
  return '1';
};
