import React from 'react';
import styled from 'styled-components';

const ButtonTag = styled.button`
  height: 36px;
  border: none;
  background-color: ${({ theme }) => theme.color.GrayBrown};
  color: ${({ theme }) => theme.color.White};
  width: 100%;
  border-radius: 4px;
`;

interface ButtonProps {
  text: React.ReactNode;
  type?: 'submit' | 'button' | 'reset';
  onClick?: (e: React.MouseEvent) => any;
}

const Button: React.FC<ButtonProps> = ({ text, onClick, type = 'button' }) => {
  return (
    <ButtonTag type={type} onClick={onClick}>
      {text}
    </ButtonTag>
  );
};

export default Button;
