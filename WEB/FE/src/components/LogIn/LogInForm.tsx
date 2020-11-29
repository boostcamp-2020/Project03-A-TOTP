import React from 'react';
import styled from 'styled-components';
import Button from '@components/common/Button';

const Form = styled.form`
  width: 100%;
  max-width: 440px;
  margin: auto;
  padding: 4rem 2rem;
  border-radius: 8px;
  box-shadow: #ddd 0 0 20px 0;
`;

const Title = styled.h1`
  text-align: center;
  font-size: ${({ theme }) => theme.fontSize.xl};
  margin-bottom: 2rem;
`;

interface LogInFormProps {}

const LogInForm: React.FC<LogInFormProps> = () => {
  return (
    <Form>
      <Title>LogIn</Title>
      <Button text='로그인' onClick={() => {}} />
    </Form>
  );
};

export { LogInForm };
