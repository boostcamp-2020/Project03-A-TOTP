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

const ButtonContainer = styled.div`
  padding-top: 1.5rem;
`;

interface AuthFormProps {
  children?: React.ReactNode;
  title: string;
  action: string;
  onSubmit: (e: React.FormEvent<HTMLFormElement>) => any;
  submitButtonText: string;
  disabled?: boolean;
}

const AuthForm: React.FC<AuthFormProps> = ({
  children,
  title,
  action,
  onSubmit,
  submitButtonText,
  disabled = false,
}) => {
  return (
    <Form action={action} method='POST' onSubmit={onSubmit}>
      <Title>{title}</Title>
      {children}
      <ButtonContainer>
        <Button htmlType='submit' text={submitButtonText} block disabled={disabled} />
      </ButtonContainer>
    </Form>
  );
};

export { AuthForm };
