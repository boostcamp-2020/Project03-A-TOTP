import React, { useState, useContext, useEffect } from 'react';
import styled from 'styled-components';
import { FontSize } from '@styles/theme';
import Input from '../common/Input';
import Button from '../common/Button';

const ID_MIN_LENGTH = 8;
const ID_MAX_LENGTH = 20;
const PW_MIN_LENGTH = 8;
const PW_MAX_LENGTH = 20;
const WS_REGEX = /\s/;
const NUM_REGEX = /[0-9]/gi;
const ENG_REGEX = /[a-zA-Z]/gi;
const SC_REGEX = /[`~!@#$%^&*|\\\'\";:\/?]/gi;

const Wrapper = styled.div`
  width: 40%;
  margin: auto;
  text-align: -webkit-center;
`;

const Title = styled.div`
  font-size: ${FontSize.xl};
  font-weight: 600;
  height: 100px;
`;

interface Form{
    id: string;
    password: string;
    rePassword: string;
    name: string;
    birthday: string;
    email: string;
    phone: string;
}

const SignUpComponent = () => {
  const list: string[] = ['password', 'rePassword', 'name', 'birthday', 'phone'];
  const placeholders: string[] = ['Password', 'Confirm Password', 'Name', 'Birthday', 'Phone'];
  const [form, setForm] = useState({
    id: '',
    password: '',
    rePassword: '',
    name: '',
    birthday: '',
    email: '',
    phone: '',
  });

  useEffect(() => {
    console.log('useEffect :', form);
  }, [form]);

  const checkDuplicateEventHandler = (e): void =>{
    e.preventDefault();
    console.log('dup-id API');
  };

  const submitEventHandler = (e): void =>{
    e.preventDefault();
    console.log('send : ',form);
    const result: string = verify(form);
    if(result !== '1'){
        alert(result);
        return;
    }
    alert('회원가입 성공');
  }

  return (
    <Wrapper>
      <Title>SIGN UP</Title>
      <Input placeholder='ID' name='id' form={form} setForm={setForm} buttonEvent={checkDuplicateEventHandler} />
      {list.map((name, idx) => (
        <Input key={idx} placeholder={placeholders[idx]} name={name} form={form} setForm={setForm} />
      ))}
      <Input placeholder='E-Mail' name='email' form={form} setForm={setForm} buttonEvent={checkDuplicateEventHandler} />
      <Button name={'회원가입'} buttonEvent={submitEventHandler} />
    </Wrapper>
  );
};

const verify = (form: Form): string =>{
    if (form.id.length < ID_MIN_LENGTH || form.id.length > ID_MAX_LENGTH || form.id.search(WS_REGEX) !== -1)
     return '아이디가 조건에 맞지 않습니다.';
    if (
        form.password.length < PW_MIN_LENGTH ||
        form.password.length > PW_MAX_LENGTH ||
        form.password.search(WS_REGEX) !== -1 ||
        form.password.search(NUM_REGEX) < 0 ||
        form.password.search(ENG_REGEX) < 0 ||
        form.password.search(SC_REGEX) < 0
      )
      return '비밀번호가 조건에 맞지 않습니다.';
    if (form.password !== form.rePassword)
      return '비밀번호가 일치하지 않습니다.';
    if (!form.id || !form.password || !form.email || !form.name || !form.birthday || !form.phone)
      return '입력되지 않은 값이 있습니다.';
    return '1';
}

export default SignUpComponent;
