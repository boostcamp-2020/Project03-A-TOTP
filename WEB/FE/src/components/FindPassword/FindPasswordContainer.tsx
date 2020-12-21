import React, { useState } from 'react';
import { FindPasswordForm } from '@/components/FindPassword/FindPasswordForm';
import { TOTPModal } from '@components/TOTPModal/TOTPModal';
import { findPasswordWithOTP, sendSecretKeyEmail } from '@api/index';
import { useHistory } from 'react-router-dom';
import { useTOTPModal } from '@hooks/useTOTPModal';
import { message } from '@utils/message';

interface FindPasswordContainerProps {}

const FindPasswordContainer = ({}: FindPasswordContainerProps): JSX.Element => {
  const history = useHistory();
  const [authToken, setAuthToken] = useState('');

  const onSuccessAuthToken = (authToken: string) => {
    setAuthToken(authToken);
    openModal();
  };

  const findPasswordSuccess = () => {
    alert(message.FINDPASSWORDSUCCESS);
    history.replace('/');
  };

  const submitHandler = (reCaptchaToken: string) =>
    findPasswordWithOTP({ authToken, totp: TOTP, reCaptchaToken }).then(() => findPasswordSuccess());

  const reIssueHandler = (reCaptchaToken: string) =>
    sendSecretKeyEmail({ authToken, reCaptchaToken }).then(() => alert(message.EMAILSECRETKEYSUCCESS));

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
      <FindPasswordForm onSuccess={onSuccessAuthToken} />
      <TOTPModal
        isOpen={isModalOpen}
        TOTP={TOTP}
        onChange={setTOTP}
        onSubmit={onSubmitOTP}
        onClose={closeModal}
        hasErrored={hasTOTPModalError}
        disabled={modalDisabled}
        errorMsg={errorMsg}
        onReIssueQRCode={onReIssueQRCode}
      />
    </>
  );
};

export { FindPasswordContainer };
