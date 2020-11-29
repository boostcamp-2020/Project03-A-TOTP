import React, { useState } from 'react';
import styled from 'styled-components';
import { AuthForm } from '@components/common/AuthForm';

const Input = styled.input``;

interface LogInFormProps {}

const LogInForm: React.FC<LogInFormProps> = () => {
  const [id, setId] = useState('');
  const [password, setPassword] = useState('');

  const onSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    // login({ id, password });
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
