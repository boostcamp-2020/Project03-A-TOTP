import { checkEmailDuplicateAPI, checkIDDuplicateAPI } from '@/api';
import { useState } from 'react';
import { message } from '../utils/message';
import { useEmailInput } from './useEmailInput';

interface returnProps {
  idCheck: string;
  emailCheck: string;
  id: string;
  setID: (e: React.ChangeEvent<HTMLInputElement>) => void;
  firstEmail: string;
  secondEmail: string;
  setFirstEmail: (e: React.ChangeEvent<HTMLInputElement>) => void;
  onChangeEmail: (e: React.ChangeEvent<HTMLInputElement>) => void;
  emailState: boolean;
  checkIDDuplicateEventHandler: (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => Promise<void>;
  checkEmailDuplicateEventHandler: (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => Promise<void>;
}

const useSignUpInput = (): returnProps => {
  const [idCheck, setIDCheck] = useState('');
  const [emailCheck, setEmailCheck] = useState('');
  const [id, setID] = useState('');
  const { firstEmail, setFirstEmail, secondEmail, onChangeEmail, emailState } = useEmailInput({
    setEmailCheck,
  });

  const viewMessage = (result: boolean, isId: boolean, value: string) => {
    const setFunc = isId ? setIDCheck : setEmailCheck;
    if (!result) {
      alert(isId ? message.ALREADYID : message.ALREADYEMAIL);
      setFunc('-1');
      return;
    }
    alert(isId ? message.POSSIBLEID : message.POSSIBLEEMAIL);
    setFunc(value);
  };

  const checkDuplicate = (value: string, isId: boolean) => {
    return async (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
      const checkAPI = isId ? checkIDDuplicateAPI : checkEmailDuplicateAPI;
      e.preventDefault();
      checkAPI(value).then((result) => viewMessage(result, isId, value));
    };
  };
  const checkIDDuplicateEventHandler = checkDuplicate(id, true);
  const checkEmailDuplicateEventHandler = checkDuplicate(`${firstEmail}@${secondEmail}`, false);

  const onChangeId = (e: React.ChangeEvent<HTMLInputElement>) => {
    setID(e.target.value);
    setIDCheck('-1');
  };

  return {
    idCheck,
    emailCheck,
    id,
    setID: onChangeId,
    firstEmail,
    secondEmail,
    setFirstEmail,
    onChangeEmail,
    emailState,
    checkIDDuplicateEventHandler,
    checkEmailDuplicateEventHandler,
  };
};

export { useSignUpInput };
