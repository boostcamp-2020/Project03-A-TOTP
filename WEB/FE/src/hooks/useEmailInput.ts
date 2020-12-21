import { useState } from 'react';

interface returnProps {
  firstEmail: string;
  setFirstEmail: (e: React.ChangeEvent<HTMLInputElement>) => void;
  secondEmail: string;
  emailState: boolean;
  onChangeEmail: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

interface emailProps {
  setEmailCheck?: React.Dispatch<React.SetStateAction<string>>;
}

const useEmailInput = ({ setEmailCheck = undefined }: emailProps): returnProps => {
  const [firstEmail, setFirstEmail] = useState('');
  const [secondEmail, setSecondEmail] = useState('');
  const [emailState, setEmailState] = useState(true);

  const onChangeFirstEmail = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFirstEmail(e.target.value);
    if (setEmailCheck) setEmailCheck('-1');
  };

  const onChangeEmail = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSecondEmail(e.target.value);
    if (e.target.value.indexOf('.') !== -1 || e.target.value === '') setEmailState(true);
    else setEmailState(false);
    if (setEmailCheck) setEmailCheck('-1');
  };

  return { firstEmail, setFirstEmail: onChangeFirstEmail, secondEmail, emailState, onChangeEmail };
};

export { useEmailInput };
