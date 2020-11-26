import React from 'react';
import styled from 'styled-components';

const ButtonTag = styled.button`
  height: 36px;
  border: none;
  background-color: ${({ theme }) => theme.color.GrayBrown};
  color: ${({ theme }) => theme.color.White};
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
