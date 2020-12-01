import React, { useState } from 'react';
import { LogInForm } from '@components/LogIn/LogInForm';
import { TOTPModal } from '@components/TOTPModal/TOTPModal';

interface LogInContainerProps {}

const LogInContainer = ({}: LogInContainerProps): JSX.Element => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [TOTP, setTOTP] = useState('');

  const onSuccessLogIn = () => setIsModalOpen(true);
  const onCloseModal = () => setIsModalOpen(false);
  const onSubmitOTP = () => {};

  return (
    <>
      <LogInForm onSuccess={onSuccessLogIn} />
      <TOTPModal
        isOpen={isModalOpen}
        TOTP={TOTP}
        onChange={setTOTP}
        onSubmit={onSubmitOTP}
        onClose={onCloseModal}
      />
    </>
  );
};

export { LogInContainer };
