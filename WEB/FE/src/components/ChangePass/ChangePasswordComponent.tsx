import React, { useEffect, useState } from 'react';
import { useInput } from '@hooks/useInput';
import { PasswordInput } from '@components/common';
import { Redirect, RouteComponentProps, useHistory } from 'react-router-dom';
import { message } from '@utils/message';
import { changePass } from '@/api';
import { AuthForm } from '../common/AuthForm';

const ChangePasswordComponent: React.FC<RouteComponentProps> = ({ location }): JSX.Element => {
  const { search } = location;
  const [password, setPassword] = useInput('');
  const [rePassword, setRePassword] = useInput('');
  const [accord, setAccord] = useState(true);
  const history = useHistory();

  useEffect(() => {
    if (password !== rePassword) setAccord(false);
    else setAccord(true);
  }, [password, rePassword]);
  if (!search) {
    return <Redirect to='/' />;
  }

  const onSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const userData = search.substring(6);
    if (!password || !rePassword) {
      alert(message.SOMETHINGNOTINPUT);
    } else if (!accord) {
      alert(message.PASSWORDNOTACCORD);
    } else {
      changePass(userData, password)
        .then(() => {
          alert(message.CHANGEPASSWORDSUCCESS);
          history.push('/login');
        })
        .catch((err: any) => alert(err.response?.data?.mesaage || err));
    }
  };

  return (
    <AuthForm
      title='비밀번호 변경'
      action='api/user/find-pass'
      onSubmit={onSubmit}
      submitButtonText='변경하기'
    >
      <PasswordInput
        value={password}
        type='password'
        showExplanation
        placeholder='Password'
        onChange={setPassword}
      />
      <PasswordInput
        value={rePassword}
        type='password'
        showExplanation
        representWarning
        state={accord}
        placeholder='Password'
        onChange={setRePassword}
      />
    </AuthForm>
  );
};

export { ChangePasswordComponent };
