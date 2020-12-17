import { useState } from 'react';

interface passwordProps {
  password: string;
  rePassword: string;
  setPassword: (e: React.ChangeEvent<HTMLInputElement>) => void;
  setRePassword: (e: React.ChangeEvent<HTMLInputElement>) => void;
  accord: boolean;
}

const usePasswordInput = (): passwordProps => {
  const [password, setPassword] = useState('');
  const [rePassword, setRePassword] = useState('');
  const [accord, setAccord] = useState(true);

  const makeOnChange = (setFunc: React.Dispatch<React.SetStateAction<string>>, isPassword: boolean) => {
    return (e: React.ChangeEvent<HTMLInputElement>) => {
      setFunc(e.target.value);
      const comparePassword = isPassword ? rePassword : password;
      if (e.target.value !== comparePassword) setAccord(false);
      else setAccord(true);
    };
  };

  const onChangePassword = makeOnChange(setPassword, true);
  const onChangeRePassword = makeOnChange(setRePassword, false);

  return { password, rePassword, setPassword: onChangePassword, setRePassword: onChangeRePassword, accord };
};

export { usePasswordInput };
