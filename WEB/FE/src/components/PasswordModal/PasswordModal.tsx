import React from 'react';
import styled from 'styled-components';
import OtpInput from 'react-otp-input';
import { Modal } from '@components/common/Modal';
import { PasswordInput } from '@components/common';
import Button from '@components/common/Button';
import CSS from 'csstype';
import { Link } from 'react-router-dom';
import { useInput } from '../../hooks/useInput';

interface PasswordModalProps {
  isOpen: boolean;
  onSubmit: () => any;
  onClose: () => void;
  hasErrored?: boolean;
  disabled?: boolean;
  errorMsg?: string | undefined;
}

const Title = styled.h1`
  font-size: ${({ theme }) => theme.fontSize.xl};
  font-weight: ${({ theme }) => theme.fontWeight.bold};
  text-align: center;
  padding: 2rem 0 1rem;
`;

const Description = styled.p`
  font-size: ${({ theme }) => theme.fontSize.md};
  font-weight: ${({ theme }) => theme.fontWeight.regular};
  text-align: center;
  margin-bottom: 3rem;
  position: relative;
`;

const Error = styled.span`
  color: ${({ theme }) => theme.color.danger};
  display: block;
  width: 100%;
  position: absolute;
  bottom: -32px;
`;

const ButtonContainer = styled.div`
  text-align: center;
  margin: 3rem 0 1rem;

  a {
    color: ${({ theme }) => theme.color.link};
    display: inline-block;
    margin: 1rem 0;
  }
`;

const InputStyle: CSS.Properties = {
  width: '4rem',
  height: '4rem',
  margin: '0 0.3rem',
  fontSize: '20px',
  borderRadius: '4px',
  border: '1px solid #ccc',
};

const ErrorStyle: CSS.Properties = {
  border: '1px solid #ff4d4f',
};

const PasswordModal = ({
  isOpen,
  onSubmit,
  onClose,
  hasErrored,
  disabled,
  errorMsg,
}: PasswordModalProps): JSX.Element => {
  const [password, setPassword] = useInput('');
  return (
    <>
      {isOpen ? (
        <Modal>
          <Title>비밀번호 입력</Title>
          <Description>
            비밀번호를 입력해주세요.
            {hasErrored && <Error>{errorMsg}</Error>}
          </Description>
          <PasswordInput value={password} type='password' placeholder='Password' onChange={setPassword} />
          <ButtonContainer>
            <Button
              text='확인'
              onClick={onSubmit}
              style={{ padding: '0 4rem', marginRight: '1rem' }}
              disabled={disabled}
            />
            <Button text='취소' onClick={onClose} type='text' disabled={disabled} />
          </ButtonContainer>
        </Modal>
      ) : (
        ''
      )}
    </>
  );
};

PasswordModal.defaultProps = {
  hasErrored: false,
  disabled: false,
  errorMsg: undefined,
};

export { PasswordModal };
