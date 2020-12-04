import { message } from './message';

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
  phone: string[];
}

export const verify = ({ id, password, rePassword, name, birth, email, phone }: Form): string => {
  if (id.length < ID_MIN_LENGTH || id.length > ID_MAX_LENGTH || id.search(WS_REGEX) !== -1)
    return message.IDNOTCONDITION;
  if (
    password.length < PW_MIN_LENGTH ||
    password.length > PW_MAX_LENGTH ||
    password.search(WS_REGEX) !== -1 ||
    password.search(NUM_REGEX) < 0 ||
    password.search(ENG_REGEX) < 0 ||
    password.search(SC_REGEX) < 0
  )
    return message.PASSWORDNOTCONDITION;
  if (password !== rePassword) return message.PASSWORDNOTACCORD;
  if (!id || !password || !email || !name || !birth || phone.findIndex((elem) => elem === '') !== -1)
    return message.SOMETHINGNOTINPUT;
  return '1';
};
