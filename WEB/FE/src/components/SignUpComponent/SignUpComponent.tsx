import React from 'react';
import { DefaultInput, PasswordInput, EmailInput, PhoneInput } from '@components/common';
import { verify } from '@utils/verify';
import { registerUserAPI } from '@api/index';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { useHistory } from 'react-router-dom';
import { Buffer } from 'buffer';
import { useInput, usePasswordInput, useSignUpInput } from '@hooks/index';
import { AuthForm } from '@components/common/AuthForm';
import { message } from '@utils/message';

const SignUpComponent = (): JSX.Element => {
  const { executeRecaptcha } = useGoogleReCaptcha();
  const history = useHistory();
  const [name, setName] = useInput('');
  const [birth, setBirth] = useInput('');
  const { password, setPassword, rePassword, setRePassword, accord } = usePasswordInput();
  const [firstPhone, setFirstPhone] = useInput('');
  const [secondPhone, setSecondPhone] = useInput('');
  const [thirdPhone, setThirdPhone] = useInput('');
  const {
    idCheck,
    emailCheck,
    id,
    setID,
    firstEmail,
    secondEmail,
    setFirstEmail,
    onChangeEmail,
    emailState,
    checkIDDuplicateEventHandler,
    checkEmailDuplicateEventHandler,
  } = useSignUpInput();

  const submitEventHandler = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const email = `${firstEmail}@${secondEmail}`;
    const phone = `${firstPhone}-${secondPhone}-${thirdPhone}`;
    const signupValidation = verify({
      id,
      password,
      rePassword,
      name,
      birth,
      email: `${firstEmail}${secondEmail}`,
      phone: [firstPhone, secondPhone, thirdPhone],
    });
    if (signupValidation !== '1') {
      alert(signupValidation);
      return;
    }
    if (idCheck !== id || emailCheck !== email || id === '' || email === '@') {
      alert(message.DUPLICATENOTCHECK);
      return;
    }
    const reCaptchaToken: string = await executeRecaptcha('SignUp');
    const result: string = await registerUserAPI({
      id,
      password,
      email,
      birth,
      name,
      phone,
      reCaptchaToken,
    });
    const url = encodeURIComponent(result);
    alert(message.SIGNUPSUCCESS);
    history.push(`/QRCode/${url}`);
  };

  return (
    <AuthForm title='SIGN UP' action='' onSubmit={submitEventHandler} submitButtonText='회원가입'>
      <DefaultInput value={name} type='text' placeholder='Name' onChange={setName} />
      <DefaultInput
        value={id}
        type='text'
        showExplanation
        placeholder='ID'
        onChange={setID}
        buttonEvent={checkIDDuplicateEventHandler}
      />
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
      <EmailInput
        firstValue={firstEmail}
        secondValue={secondEmail}
        type='text'
        onChangeFirst={setFirstEmail}
        onChangeSecond={onChangeEmail}
        buttonEvent={checkEmailDuplicateEventHandler}
        representWarning={emailState}
      />
      <DefaultInput value={birth} type='date' placeholder='' onChange={setBirth} />
      <PhoneInput
        firstValue={firstPhone}
        secondValue={secondPhone}
        thirdValue={thirdPhone}
        type='text'
        placeholder='010'
        onChangeFirst={setFirstPhone}
        onChangeSecond={setSecondPhone}
        onChangeThird={setThirdPhone}
      />
    </AuthForm>
  );
};

export default SignUpComponent;
