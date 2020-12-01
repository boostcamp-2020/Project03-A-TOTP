import React from 'react';
import styled from 'styled-components';
import OtpInput from 'react-otp-input';
import { Modal } from '@components/common/Modal';

interface TOTPModalProps {
  isOpen: boolean;
  TOTP: string;
  onChange: (otp: string) => any | React.Dispatch<React.SetStateAction<string>> | undefined;
  onSubmit: () => any;
  onClose: () => any;
}

const TOTPModal = ({ isOpen, TOTP, onChange, onSubmit, onClose }: TOTPModalProps): JSX.Element => {
  return (
    <>
      {isOpen ? (
        <Modal>
          <OtpInput value={TOTP} onChange={onChange} numInputs={6} isInputNum />
          <button type='button' onClick={onClose}>
            Close
          </button>
        </Modal>
      ) : (
        ''
      )}
    </>
  );
};

export { TOTPModal };
