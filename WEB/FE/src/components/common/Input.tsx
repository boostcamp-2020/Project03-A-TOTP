import React from 'react';
import styled from 'styled-components';
import { InputTag } from '@styles/style';

const Wrapper = styled.div`
  display: flex;
  justify-content: center;
  border: 2px solid darkgray;
  border-radius: 5px;
  margin-bottom: 12px;
`;

const Button = styled.button`
  flex: 0.2;
  height: 36px;
  border: none;
`;
const Input = (props: any) => {
  const { placeholder, form, setForm, name, buttonEvent } = props;
  const onChangeHandler = (e: React.ChangeEvent<HTMLInputElement>, target: string) => {
    setForm({ ...props.form, [target]: e.target.value });
  };
  return (
    <Wrapper>
      <InputTag
        type={name === 'password' || name === 'rePassword' ? 'password' : 'text'}
        placeholder={placeholder}
        value={form[name]}
        onChange={(e) => onChangeHandler(e, props.name)}
      />
      {buttonEvent ? <Button onClick={(e) => buttonEvent(e)}>verify</Button> : undefined}
    </Wrapper>
  );
};

export default Input;
