import React from 'react';
import styled from 'styled-components';
import { Colors } from '@styles/variable';

const ButtonTag = styled.button`
  height: 36px;
  border: none;
  background-color: ${Colors.GrayBrown};
  color : ${Colors.White};
  width: 100%;
`;

const Button = (props: any) => { 
  const { name, buttonEvent } = props;
  return (
    <>
      <ButtonTag onClick={(e) => buttonEvent(e)}>{name}</ButtonTag>
    </>
  );
};

export default Button;
