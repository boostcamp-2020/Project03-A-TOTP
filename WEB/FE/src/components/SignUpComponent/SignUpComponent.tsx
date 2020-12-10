import React, { useState, useEffect, useCallback } from 'react';
import { DefaultInput, PasswordInput, EmailInput, PhoneInput } from '@components/common';
import { verify } from '@utils/verify';
import { checkIDDuplicateAPI, checkEmailDuplicateAPI, registerUserAPI } from '@api/index';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { useHistory } from 'react-router-dom';
import { Buffer } from 'buffer';
import { useInput } from '@hooks/index';
import { AuthForm } from '@components/common/AuthForm';
import { message } from '@utils/message';

const SignUpComponent = (): JSX.Element => {
  const { executeRecaptcha } = useGoogleReCaptcha();
  const history = useHistory();
  const [id, setID] = useInput('');
  const [name, setName] = useInput('');
  const [birth, setBirth] = useInput('');
  const [password, setPassword] = useInput('');
  const [rePassword, setRePassword] = useInput('');
  const [accord, setAccord] = useState(true);
  const [firstEmail, setFirstEmail] = useInput('');
  const [secondEmail, setSecondEmail] = useInput('');
  const [emailState, setEmailState] = useState(true);
  const [firstPhone, setFirstPhone] = useInput('');
  const [secondPhone, setSecondPhone] = useInput('');
  const [thirdPhone, setThirdPhone] = useInput('');
  const [idCheck, setIDCheck] = useState('');
  const [emailCheck, setEmailCheck] = useState('');

  const checkIDDuplicateEventHandler = async (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
    try {
      e.preventDefault();
      const result = await checkIDDuplicateAPI({ id });
      if (!result) {
        alert(message.ALREADYID);
        setIDCheck('-1');
        return;
      }
      alert(message.POSSIBLEID);
      setIDCheck(id);
    } catch (err) {
      console.error(err);
    }
  };

  const checkEmailDuplicateEventHandler = async (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
    try {
      e.preventDefault();
      const result = await checkEmailDuplicateAPI({ email: `${firstEmail}@${secondEmail}` });
      if (!result) {
        alert(message.ALREADYEMAIL);
        setEmailCheck('-1');
        return;
      }
      alert(message.POSSIBLEEMAIL);
      setEmailCheck(`${firstEmail}@${secondEmail}`);
    } catch (err) {
      console.error(err);
    }
  };

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
    const url = encodeURIComponent(Buffer.from(result).toString('base64'));
    alert(message.SIGNUPSUCCESS);
    history.push(`/QRCode/${url}`);
  };

  const toggleAccord = useCallback(() => {
    if (password !== rePassword) setAccord(false);
    else setAccord(true);
  }, [password, rePassword]);

  useEffect(() => {
    toggleAccord();
  }, [toggleAccord]);

  useEffect(() => {
    if (secondEmail.indexOf('.') !== -1 || secondEmail === '') setEmailState(true);
    else setEmailState(false);
  }, [secondEmail]);

  useEffect(() => {
    setIDCheck('-1');
  }, [id]);

  useEffect(() => {
    setEmailCheck('-1');
  }, [firstEmail, secondEmail]);

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
        onChangeSecond={setSecondEmail}
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
