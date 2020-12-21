import React from 'react';

import { AuthForm } from '@components/common/AuthForm';
import { DefaultInput, EmailInput } from '@components/common';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { findId } from '@api/index';
import { useHistory } from 'react-router-dom';
import { message } from '@utils/message';
import { useEmailInput, useInput } from '@/hooks';

const FindIDComponent = (): JSX.Element => {
  const { executeRecaptcha } = useGoogleReCaptcha();
  const { firstEmail, setFirstEmail, secondEmail, onChangeEmail } = useEmailInput({});
  const [name, setName] = useInput('');
  const [birth, setBirth] = useInput('');
  const history = useHistory();

  const onSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const email = `${firstEmail}@${secondEmail}`;
    executeRecaptcha('findId').then((reCaptchaToken: string) =>
      findId({ email, name, birth, reCaptchaToken }).then(() => {
        alert(message.FINDIDEMAILSEND);
        history.push('/login');
      }),
    );
  };

  return (
    <AuthForm title='아이디 찾기' action='api/user/find-id' onSubmit={onSubmit} submitButtonText='찾기'>
      <EmailInput
        firstValue={firstEmail}
        secondValue={secondEmail}
        onChangeFirst={setFirstEmail}
        onChangeSecond={onChangeEmail}
        type='text'
        representWarning
      />
      <DefaultInput placeholder='name' type='text' value={name} onChange={setName} />
      <DefaultInput placeholder='birth' type='date' value={birth} onChange={setBirth} />
    </AuthForm>
  );
};

export { FindIDComponent };
