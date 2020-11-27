import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import Input from '@components/common/Input';
import Button from '@components/common/Button';
import { verify } from '@utils/verify';
import { checkIDDuplicateAPI, checkEmailDuplicateAPI, registerUserAPI } from '@api/index';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { useHistory } from 'react-router-dom';
import Buffer from 'buffer';
import Input from '../common/Input';
import Button from '../common/Button';

const Wrapper = styled.div`
  width: 40%;
  margin: auto;
  text-align: center;
`;

const Title = styled.div`
  font-size: ${({ theme }) => theme.fontSize.xl};
  font-weight: 600;
  height: 100px;
`;

interface Form {
  id: string;
  password: string;
  rePassword: string;
  name: string;
  birth: string;
  email: string;
  phone: string;
}

const SignUpComponent = () => {
  const { executeRecaptcha } = useGoogleReCaptcha();
  const history = useHistory();
  const list: string[] = ['password', 'rePassword', 'name', 'birth', 'phone'];
  const placeholders: string[] = ['Password', 'Confirm Password', 'Name', 'Birthday', 'Phone'];
  const [idState, setIDState] = useState('');
  const [emailState, setEmailState] = useState('');
  const [form, setForm] = useState({
    id: '',
    password: '',
    rePassword: '',
    name: '',
    birth: '',
    email: '',
    phone: '',
  });

  useEffect(() => {
    // eslint-disable-next-line no-unused-expressions
    idState !== form.id ? setIDState('-1') : undefined;
    // eslint-disable-next-line no-unused-expressions
    emailState !== form.email ? setEmailState('-1') : undefined;
  }, [form]);

  const checkIDDuplicateEventHandler = async (e: React.ChangeEvent<HTMLInputElement>): void => {
    e.preventDefault();
    const result = await checkIDDuplicateAPI({ id: form.id });
    if (!result) {
      alert('이미존재하는 아이디 입니다.');
      return;
    }
    alert('사용가능한 아이디 입니다.');
    setIDState(form.id);
  };

  const submitEventHandler = (e: React.ChangeEvent<HTMLInputElement>): void => {
    e.preventDefault();
    const result = await checkEmailDuplicateAPI({ email: form.email });
    if (!result) {
      alert('이미존재하는 이메일 입니다.');
      return;
    }
    alert('사용가능한 이메일 입니다.');
    setEmailState(form.email);
  };

  const submitEventHandler = async (e: React.ChangeEvent<HTMLInputElement>) => {
    e.preventDefault();
    if (idState !== form.id || emailState !== form.email) {
      alert('아이디 또는 이메일 중복체크를 해주세요.');
      return;
    }
    const verifyResult = verify(form);
    if (verifyResult !== '1') {
      alert(verifyResult);
      return;
    }
    const token: string = await executeRecaptcha('SignUp');
    const result: string = (
      await registerUserAPI({
        id: form.id,
        password: form.password,
        email: form.email,
        birth: form.birth,
        name: form.name,
        phone: form.phone,
        token,
      })
    ).split('totp/')[1];
    /**
     * @TODO url 인코딩하여 보내기
     */
    alert(`회원가입에 성공하셨습니다.`);
    history.push(`/QRCode/${result}`);
  };

  return (
    <Wrapper>
      <Title>SIGN UP</Title>
      <Input
        placeholder='ID'
        name='id'
        form={form}
        setForm={setForm}
        buttonEvent={checkIDDuplicateEventHandler}
      />
      {list.map((name, idx) => (
        <Input key={idx} placeholder={placeholders[idx]} name={name} form={form} setForm={setForm} />
      ))}
      <Input
        placeholder='E-Mail'
        name='email'
        form={form}
        setForm={setForm}
        buttonEvent={checkEmailDuplicateEventHandler}
      />
      <Button name='회원가입' buttonEvent={submitEventHandler} />
    </Wrapper>
  );
};

export default SignUpComponent;
