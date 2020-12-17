import { useState } from 'react';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { message } from '@utils/message';

const TOTP_LEN = 6;
const UNAUTHORIZED = 403;

interface useTOTPModalProps {
  reIssueHandler: (reCaptchaToken: string) => Promise<any>;
  submitHandler: (reCaptchaToken: string) => Promise<any>;
}

interface useTOTPModalReturnType {
  isModalOpen: boolean;
  openModal: () => void;
  closeModal: () => void;
  hasTOTPModalError: boolean;
  modalDisabled: boolean;
  TOTP: string;
  setTOTP: (otp: string) => void;
  errorMsg: string;
  onReIssueQRCode: () => void;
  onSubmitOTP: () => void;
}

const useTOTPModal = ({ reIssueHandler, submitHandler }: useTOTPModalProps): useTOTPModalReturnType => {
  const { executeRecaptcha } = useGoogleReCaptcha();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [TOTP, setTOTP] = useState('');
  const [hasTOTPModalError, setHasTOTPModalError] = useState(false);
  const [modalDisabled, setModalDisabled] = useState(false);
  const [errorMsg, setErrorMsg] = useState('');

  const openModal = () => setIsModalOpen(true);

  const closeModal = () => {
    setTOTP('');
    setHasTOTPModalError(false);
    setModalDisabled(false);
    setIsModalOpen(false);
    setErrorMsg('');
  };

  const handleError = (errMsg: string) => {
    setHasTOTPModalError(true);
    setErrorMsg(errMsg);
  };

  const onReIssueQRCode = () => {
    setHasTOTPModalError(false);
    setModalDisabled(true);
    if (window.confirm('QR 재등록 Email을 전송하시겠습니까? \n이전에 사용된 OTP 정보는 삭제됩니다.')) {
      executeRecaptcha('sendSecretKeyEmail')
        .then(reIssueHandler)
        .then(() => alert(message.EMAILSECRETKEYSUCCESS))
        .catch((err: any) => handleError(err.response?.data?.message || err.message))
        .finally(() => setModalDisabled(false));
    }
  };

  const onSubmitOTP = () => {
    setHasTOTPModalError(false);
    if (TOTP.length < TOTP_LEN) {
      handleError('전부 입력해 주세요~');
      return;
    }
    setModalDisabled(true);
    executeRecaptcha('LogInWithOTP')
      .then(submitHandler)
      .catch((err: any) => {
        if (err.response.status === UNAUTHORIZED) {
          alert(err.response?.data?.message);
          window.location.reload();
        }
        handleError(err.response?.data?.message || err.message);
        setModalDisabled(false);
      });
  };

  return {
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
  };
};

export { useTOTPModal };
