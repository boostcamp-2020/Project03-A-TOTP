import React, { useState } from 'react';
import styled from 'styled-components';
import { AuthForm } from '@components/common/AuthForm';
import { login } from '@api/index';

const Input = styled.input``;

interface LogInFormProps {}

const LogInForm: React.FC<LogInFormProps> = () => {
  const [id, setId] = useState('');
  const [password, setPassword] = useState('');

  const onSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    login({ id, password })
      .then((result) => alert(result.id))
      .catch((err) => alert(err.response?.data?.message || err.message));
  };

  return (
    <AuthForm title='LogIn' action='/api/auth/login' onSubmit={onSubmit} submitButtonText='로그인'>
      <Input placeholder='id' name='id' type='text' value={id} onChange={(e) => setId(e.target.value)} />
      <Input
        placeholder='password'
        name='password'
        type='password'
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
    </AuthForm>
  );
};

export { LogInForm };
