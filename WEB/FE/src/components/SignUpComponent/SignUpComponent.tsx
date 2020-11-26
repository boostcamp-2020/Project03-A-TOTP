import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import Input from '@components/common/Input';
import Button from '@components/common/Button';

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

  const checkDuplicateEventHandler = (e: MouseEvent): void => {
    e.preventDefault();
    console.log('dup-id API');
  };

  const submitEventHandler = (e: MouseEvent): void => {
    e.preventDefault();
    console.log('send : ', form);
  };

  return (
    <Wrapper>
      <Title>SIGN UP</Title>
      <Input
        placeholder='ID'
        name='id'
        form={form}
        setForm={setForm}
        buttonEvent={checkDuplicateEventHandler}
      />
      {list.map((name, idx) => (
        <Input key={idx} placeholder={placeholders[idx]} name={name} form={form} setForm={setForm} />
      ))}
      <Input
        placeholder='E-Mail'
        name='email'
        form={form}
        setForm={setForm}
        buttonEvent={checkDuplicateEventHandler}
      />
      <Button name={'회원가입'} buttonEvent={submitEventHandler} />
    </Wrapper>
  );
};

export default SignUpComponent;
