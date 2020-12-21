import React from 'react';
import styled from 'styled-components';
import { Modal } from '@components/common/Modal';
import { PasswordInput } from '@components/common';
import Button from '@components/common/Button';

interface PasswordModalProps {
  password: string;
  setPassword: (e: React.ChangeEvent<HTMLInputElement>) => void;
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

const PasswordModal = ({
  password,
  setPassword,
  isOpen,
  onSubmit,
  onClose,
  hasErrored,
  disabled,
  errorMsg,
}: PasswordModalProps): JSX.Element => {
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
