import React from 'react';

import { AuthForm } from '@components/common/AuthForm';
import { useInput } from '@hooks/useInput';
import { DefaultInput, EmailInput } from '@components/common';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { findId } from '@api/index';
import { RouteComponentProps } from 'react-router-dom';

const FindIDComponent = (props: RouteComponentProps): JSX.Element => {
  const { executeRecaptcha } = useGoogleReCaptcha();
  const [firstEmail, setFirstEmail] = useInput('');
  const [secondEmail, setSecondEmail] = useInput('');
  const [name, setName] = useInput('');
  const [birth, setBirth] = useInput('');

  const onSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const email = `${firstEmail}@${secondEmail}`;
    executeRecaptcha('findId').then((reCaptchaToken: string) =>
      findId({ email, name, birth, reCaptchaToken })
        .then(() => {
          document.location.href = '/login';
          // props.history.push('/login');
        })
        .catch((err) => alert(err || err.message)),
    );
  };

  return (
    <AuthForm title='아이디 찾기' action='api/user/find-id' onSubmit={onSubmit} submitButtonText='찾기'>
      <EmailInput
        firstValue={firstEmail}
        secondValue={secondEmail}
        onChangeFirst={setFirstEmail}
        onChangeSecond={setSecondEmail}
        type='text'
        representWarning
      />
      <DefaultInput placeholder='name' type='text' value={name} onChange={setName} />
      <DefaultInput placeholder='birth' type='date' value={birth} onChange={setBirth} />
    </AuthForm>
  );
};

export { FindIDComponent };
