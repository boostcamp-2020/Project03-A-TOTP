import React, { useState } from 'react';

import { AuthForm } from '@components/common/AuthForm';
import { useInput } from '@hooks/useInput';
import { DefaultInput } from '@components/common';
import { findPassword } from '@api/index';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { useHistory } from 'react-router-dom';

interface FindPasswordFormProps {
  onSuccess: (authToken: string) => any;
}

const FindPasswordForm = ({ onSuccess }: FindPasswordFormProps): JSX.Element => {
  const [id, setID] = useInput('');
  const [name, setName] = useInput('');
  const [birth, setBirth] = useInput('');
  const { executeRecaptcha } = useGoogleReCaptcha();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const onSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setIsSubmitting(true);
    executeRecaptcha('findPassword')
      .then((reCaptchaToken: string) => findPassword({ id, name, birth, reCaptchaToken }))
      .then(({ authToken }: { authToken: string }) => onSuccess(authToken))
      .catch((err: any) => alert(err.response?.data?.message || err.message))
      .finally(() => setIsSubmitting(false));
  };

  return (
    <AuthForm
      title='비밀번호 찾기'
      action='api/user/find-id'
      onSubmit={onSubmit}
      submitButtonText='찾기'
      disabled={isSubmitting}
    >
      <DefaultInput placeholder='ID' type='text' value={id} onChange={setID} />
      <DefaultInput placeholder='Name' type='text' value={name} onChange={setName} />
      <DefaultInput placeholder='Birth' type='date' value={birth} onChange={setBirth} />
    </AuthForm>
  );
};

export { FindPasswordForm };
