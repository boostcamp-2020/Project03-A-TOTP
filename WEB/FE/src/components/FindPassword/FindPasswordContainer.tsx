import React, { useState } from 'react';
import { FindPasswordForm } from '@/components/FindPassword/FindPasswordForm';
import { TOTPModal } from '@components/TOTPModal/TOTPModal';
import { findPasswordWithOTP } from '@api/index';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { useHistory } from 'react-router-dom';
import { message } from '../../utils/message';

const TOTP_LEN = 6;

interface FindPasswordContainerProps {}

const FindPasswordContainer = ({}: FindPasswordContainerProps): JSX.Element => {
  const history = useHistory();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const { executeRecaptcha } = useGoogleReCaptcha();
  const [TOTP, setTOTP] = useState('');
  const [authToken, setAuthToken] = useState('');
  const [hasTOTPModalError, setHasTOTPModalError] = useState(false);
  const [modalDisabled, setModalDisabled] = useState(false);
  const [errorMsg, setErrorMsg] = useState('');

  const onSuccessAuthToken = (authToken: string) => {
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
    setHasTOTPModalError(false);
    if (TOTP.length < TOTP_LEN) {
      onErrorWithOTP('전부 입력해 주세요~');
      return;
    }
    setModalDisabled(true);
    executeRecaptcha('findPasswordWithOTP')
      .then((reCaptchaToken: string) => findPasswordWithOTP({ authToken, totp: TOTP, reCaptchaToken }))
      .then(() => findPasswordSuccess())
      .catch((err: any) => onErrorWithOTP(err.response?.data?.message || err.message))
      .finally(() => setModalDisabled(false));
  };

  const findPasswordSuccess = () => {
    alert(message.FINDPASSWORDSUCCESS);
    history.replace('/');
  };

  return (
    <>
      <FindPasswordForm onSuccess={onSuccessAuthToken} />
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

export { FindPasswordContainer };
