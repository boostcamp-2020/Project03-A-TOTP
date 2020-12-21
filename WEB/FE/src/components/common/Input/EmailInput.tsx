import React from 'react';
import styled from 'styled-components';
import { InputTag } from './Input';
import Form from './Form';

const Wrapper = styled.div`
  display: flex;
`;

const AtDiv = styled.div`
  margin: 0% 1%;
  margin-top: 7%;
`;

const Warning = styled.div<{ flag: boolean }>`
  display: ${(props) => (!props.flag ? 'block' : 'none')};
  position: absolute;
  color: red;
  font-size: ${({ theme }) => theme.fontSize.sm};
`;

interface Props {
  firstValue: string;
  secondValue: string;
  type: string;
  representWarning: boolean;
  onChangeFirst: (event: React.ChangeEvent<HTMLInputElement>) => void;
  onChangeSecond: (event: React.ChangeEvent<HTMLInputElement>) => void;
  buttonEvent?: (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => Promise<void>;
}

const EmailInput = ({
  firstValue,
  secondValue,
  type,
  representWarning,
  onChangeFirst,
  onChangeSecond,
  buttonEvent,
}: Props): JSX.Element => {
  return (
    <>
      <Wrapper>
        <Form>
          <InputTag type={type} value={firstValue} onChange={(e) => onChangeFirst(e)} />
        </Form>
        <AtDiv>@</AtDiv>
        <Form buttonEvent={buttonEvent}>
          <InputTag type={type} value={secondValue} onChange={(e) => onChangeSecond(e)} />
        </Form>
      </Wrapper>
      <Warning flag={representWarning}>올바른 주소를 입력해주세요.</Warning>
    </>
  );
};

EmailInput.defaultProps = {
  buttonEvent: undefined,
};

export default EmailInput;
