import React from 'react';
import { AuthForm } from '@components/common/AuthForm';
import DefaultInput from '@components/common/Input/DefaultInput';
import { login } from '@api/index';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { useInput } from '@hooks/useInput';

interface LogInFormProps {
  onSuccess: () => any;
}

const LogInForm = ({ onSuccess }: LogInFormProps): JSX.Element => {
  const { executeRecaptcha } = useGoogleReCaptcha();
  const [id, setId] = useInput('');
  const [password, setPassword] = useInput('');

  const onSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    executeRecaptcha('LogIn')
      .then((reCaptchaToken: string) => login({ id, password, reCaptchaToken }))
      .then((result) => onSuccess(result.id))
      .catch((err) => alert(err.response?.data?.message || err.message));
  };

  return (
    <AuthForm title='LogIn' action='/api/auth' onSubmit={onSubmit} submitButtonText='로그인'>
      <DefaultInput value={id} type='text' placeholder='ID' onChange={setId} />
      <DefaultInput value={password} type='password' placeholder='Password' onChange={setPassword} />
    </AuthForm>
  );
};

export { LogInForm };
