import React from 'react';
import styled from 'styled-components';
import CSS from 'csstype';

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
  style?: CSS.Properties<0 | (string & unknown), string & unknown>;
}

const Button: React.FC<ButtonProps> = ({ text, onClick, type = 'button', style = undefined }) => {
  return (
    <ButtonTag type={type} onClick={onClick} style={style}>
      {text}
    </ButtonTag>
  );
};

export default Button;
