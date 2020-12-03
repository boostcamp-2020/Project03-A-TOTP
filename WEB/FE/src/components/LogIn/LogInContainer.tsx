import React, { useState } from 'react';
import { LogInForm } from '@components/LogIn/LogInForm';
import { TOTPModal } from '@components/TOTPModal/TOTPModal';
import { loginWithOTP } from '@api/index';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { useHistory } from 'react-router-dom';

const TOTP_LEN = 6;

interface LogInContainerProps {}

const LogInContainer = ({}: LogInContainerProps): JSX.Element => {
  const history = useHistory();
  const { executeRecaptcha } = useGoogleReCaptcha();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [TOTP, setTOTP] = useState('');
  const [authToken, setAuthToken] = useState('');
  const [hasTOTPModalError, setHasTOTPModalError] = useState(false);
  const [modalDisabled, setModalDisabled] = useState(false);
  const [errorMsg, setErrorMsg] = useState('');

  const onSuccessLogInWithPassword = (authToken: string) => {
    setAuthToken(authToken);
    setIsModalOpen(true);
  };
  const onCloseModal = () => {
    setTOTP('');
    setIsModalOpen(false);
  };
  const onErrorWithOTP = (errMsg: string) => {
    setHasTOTPModalError(true);
    setErrorMsg(errMsg);
  };
  const onSubmitOTP = () => {
    if (TOTP.length < TOTP_LEN) {
      onErrorWithOTP('전부 입력해 주세요~');
      return;
    }
    setModalDisabled(true);
    executeRecaptcha('LogInWithOTP')
      .then((reCaptchaToken: string) => loginWithOTP({ authToken, totp: TOTP, reCaptchaToken }))
      .then(() => history.replace('/'))
      .catch((err: any) => onErrorWithOTP(err.response?.data?.message || err.message))
      .finally(() => setModalDisabled(false));
  };

  return (
    <>
      <LogInForm onSuccess={onSuccessLogInWithPassword} />
      <TOTPModal
        isOpen={isModalOpen}
        TOTP={TOTP}
        onChange={setTOTP}
        onSubmit={onSubmitOTP}
        onClose={onCloseModal}
        hasErrored={hasTOTPModalError}
        disabled={modalDisabled}
        errorMsg={errorMsg}
      />
    </>
  );
};

export { LogInContainer };
