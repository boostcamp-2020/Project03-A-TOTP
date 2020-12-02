import React from 'react';
import styled from 'styled-components';
import { InputTag } from './Input';
import Form from './Form';

const Message = styled.div`
  font-size: ${({ theme }) => theme.fontSize.xs};
  position: absolute;
`;

const Warning = styled.div<{ flag: boolean | undefined }>`
  position: absolute;
  display: ${(props) => (props.flag ? 'block' : 'none')};
  text-align: left;
  font-size: ${({ theme }) => theme.fontSize.sm};
  color: red;
`;

interface Props {
  value: string;
  type: string;
  placeholder: string;
  showExplanation?: boolean;
  representWarning?: boolean;
  state?: boolean;
  onChange: (event: React.ChangeEvent<HTMLInputElement>) => void;
}

const PasswordInput = ({
  value,
  type,
  showExplanation,
  placeholder,
  onChange,
  representWarning,
  state,
}: Props): JSX.Element => {
  return (
    <>
      <Form>
        <InputTag type={type} placeholder={placeholder} value={value} onChange={(e) => onChange(e)} />
      </Form>
      {showExplanation && !representWarning ? (
        <Message>*영문/숫자, 특수문자1개 포함 8자리 이상 20자리 미만의 값을 입력하세요.</Message>
      ) : undefined}
      <Warning flag={representWarning && !state}>비밀번호가 일치하지 않습니다.</Warning>
    </>
  );
};

PasswordInput.defaultProps = {
  representWarning: false,
  showExplanation: false,
  state: true,
};

export default PasswordInput;
