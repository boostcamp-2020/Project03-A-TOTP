import React from 'react';
import styled from 'styled-components';
import { InputTag } from './Input';
import Form from './Form';

const Message = styled.div`
  text-align: left;
  position: absolute;
  font-size: ${({ theme }) => theme.fontSize.xs};
`;

interface Props {
  value: string;
  type: string;
  placeholder: string;
  showExplanation?: boolean;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  buttonEvent?: (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => Promise<void>;
}

const DefaultInputComp = ({
  value,
  type,
  showExplanation,
  placeholder,
  onChange,
  buttonEvent,
}: Props): JSX.Element => {
  return (
    <>
      <Form buttonEvent={buttonEvent}>
        <InputTag type={type} placeholder={placeholder} value={value} onChange={(e) => onChange(e)} />
      </Form>
      {showExplanation ? <Message>*영문/숫자 8자리 이상 20자리 미만의 값을 입력하세요.</Message> : undefined}
    </>
  );
};

DefaultInputComp.defaultProps = {
  buttonEvent: undefined,
  showExplanation: false,
};

const DefaultInput = React.memo(DefaultInputComp);

export default DefaultInput;
