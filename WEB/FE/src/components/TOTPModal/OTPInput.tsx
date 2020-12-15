import React from 'react';
import ReactOtpInput from 'react-otp-input';
import CSS from 'csstype';

interface OTPInputProps {
  otp: string;
  onChange: (otp: string) => void;
  hasErrored?: boolean;
  isDisabled?: boolean;
}

const InputStyle: CSS.Properties = {
  width: '4rem',
  height: '4rem',
  margin: '0 0.3rem',
  fontSize: '20px',
  borderRadius: '4px',
  border: '1px solid #ccc',
};

const FocusStyle: CSS.Properties = {
  boxShadow: '0 0 4px 0 #4192F1',
};

const ErrorStyle: CSS.Properties = {
  border: '1px solid #ff4d4f',
};

function OTPInput({ otp, onChange, hasErrored, isDisabled }: OTPInputProps): JSX.Element {
  return (
    <ReactOtpInput
      value={otp}
      onChange={onChange}
      numInputs={6}
      inputStyle={InputStyle}
      focusStyle={FocusStyle}
      isInputNum
      shouldAutoFocus
      hasErrored={hasErrored}
      errorStyle={ErrorStyle}
      isDisabled={isDisabled}
    />
  );
}

OTPInput.defaultProps = {
  hasErrored: false,
  isDisabled: false,
};

export { OTPInput };
