import React from 'react';
import styled from 'styled-components';
import OtpInput from 'react-otp-input';
import { Modal } from '@components/common/Modal';
import Button from '@components/common/Button';
import CSS from 'csstype';
import { Link } from 'react-router-dom';

interface TOTPModalProps {
  isOpen: boolean;
  TOTP: string;
  onChange: (otp: string) => any | React.Dispatch<React.SetStateAction<string>> | undefined;
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

const TOTPModal = ({
  isOpen,
  TOTP,
  onChange,
  onSubmit,
  onClose,
  onClick,
  hasErrored,
  disabled,
  errorMsg,
}: TOTPModalProps): JSX.Element => {
  return (
    <>
      {isOpen ? (
        <Modal>
          <Title>OTP 인증</Title>
          <Description>
            표시된 OTP 6자리를 입력해 주세요
            {hasErrored && <Error>{errorMsg}</Error>}
          </Description>
          <OtpInput
            value={TOTP}
            onChange={onChange}
            numInputs={6}
            inputStyle={InputStyle}
            isInputNum
            shouldAutoFocus
            hasErrored={hasErrored}
            errorStyle={ErrorStyle}
            isDisabled={disabled}
          />
          <ButtonContainer>
            <Button
              text='확인'
              onClick={onSubmit}
              style={{ padding: '0 4rem', marginRight: '1rem' }}
              disabled={disabled}
            />
            <Button text='취소' onClick={onClose} type='text' disabled={disabled} />
            <br />
            <Button text='QR코드 재등록' onClick={onClick} type='text' />
          </ButtonContainer>
        </Modal>
      ) : (
        ''
      )}
    </>
  );
};

TOTPModal.defaultProps = {
  hasErrored: false,
  disabled: false,
  errorMsg: undefined,
};

export { TOTPModal };
