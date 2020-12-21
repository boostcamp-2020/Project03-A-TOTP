import React from 'react';
import styled from 'styled-components';
import { InputTag } from './Input';
import Form, { Wrapper as FormWrapper } from './Form';

const Wrapper = styled.div`
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
  ${FormWrapper} {
    width: 30%;
  }
`;

interface Props {
  firstValue: string;
  secondValue: string;
  thirdValue: string;
  type: string;
  placeholder: string | undefined;
  onChangeFirst: (event: React.ChangeEvent<HTMLInputElement>) => void;
  onChangeSecond: (event: React.ChangeEvent<HTMLInputElement>) => void;
  onChangeThird: (event: React.ChangeEvent<HTMLInputElement>) => void;
}

const PhoneInput = ({
  firstValue,
  secondValue,
  thirdValue,
  type,
  placeholder,
  onChangeFirst,
  onChangeSecond,
  onChangeThird,
}: Props): JSX.Element => {
  return (
    <Wrapper>
      <Form>
        <InputTag
          type={type}
          placeholder={placeholder}
          value={firstValue}
          onChange={(e) => onChangeFirst(e)}
        />
      </Form>
      <Form>
        <InputTag type={type} placeholder='0000' value={secondValue} onChange={(e) => onChangeSecond(e)} />
      </Form>
      <Form>
        <InputTag type={type} placeholder='0000' value={thirdValue} onChange={(e) => onChangeThird(e)} />
      </Form>
    </Wrapper>
  );
};

export default PhoneInput;
