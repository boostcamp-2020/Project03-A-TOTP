import React, { useState, useCallback } from 'react';
import { LogInForm } from '@components/LogIn/LogInForm';
import { TOTPModal } from '@components/TOTPModal/TOTPModal';
import { loginWithOTP, sendSecretKeyEmail } from '@api/index';
import { useHistory } from 'react-router-dom';
import { message } from '@utils/message';
import storageHandler from '@utils/localStorage';
import { useTOTPModal } from '@hooks/useTOTPModal';

interface LogInContainerProps {}

const LogInContainer = ({}: LogInContainerProps): JSX.Element => {
  const history = useHistory();
  const [authToken, setAuthToken] = useState('');

  const onSuccessLogInWithPassword = useCallback((authToken: string) => {
    setAuthToken(authToken);
    openModal();
  }, []);

  const successLoginHandler = useCallback(({ userName }: { userName: string }) => {
    alert(message.SIGNINSUCCESS);
    storageHandler.set(userName);
    history.replace('/');
  }, []);

  const reIssueHandler = (reCaptchaToken: string) =>
    sendSecretKeyEmail({ authToken, reCaptchaToken }).then(() => alert(message.EMAILSECRETKEYSUCCESS));

  const submitHandler = (reCaptchaToken: string) =>
    loginWithOTP({ authToken, totp: TOTP, reCaptchaToken }).then(successLoginHandler);

  const {
    isModalOpen,
    openModal,
    closeModal,
    TOTP,
    setTOTP,
    hasTOTPModalError,
    modalDisabled,
    errorMsg,
    onReIssueQRCode,
    onSubmitOTP,
  } = useTOTPModal({ reIssueHandler, submitHandler });

  return (
    <>
      <LogInForm onSuccess={onSuccessLogInWithPassword} />
      <TOTPModal
        isOpen={isModalOpen}
        TOTP={TOTP}
        onChange={setTOTP}
        onSubmit={onSubmitOTP}
        onClose={closeModal}
        onReIssueQRCode={onReIssueQRCode}
        hasErrored={hasTOTPModalError}
        disabled={modalDisabled}
        errorMsg={errorMsg}
      />
    </>
  );
};

export { LogInContainer };
