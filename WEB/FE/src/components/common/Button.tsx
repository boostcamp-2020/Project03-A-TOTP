import React from 'react';
import styled from 'styled-components';
import CSS from 'csstype';

const ButtonTag = styled.button`
  height: 40px;
  border: none;
  padding: 0 2rem;
  width: auto;
  border-radius: 4px;
  font-size: ${({ theme }) => theme.fontSize.md};

  &.block {
    width: 100%;
  }
  &:disabled {
    cursor: not-allowed;
    filter: saturate(0.5);
  }

  &:not(:disabled):hover {
    filter: brightness(1.1);
  }
  &.text:not(:disabled):not(.danger):hover {
    filter: none;
    color: ${({ theme }) => theme.color.GrayBrown};
  }

  &.primary {
    background-color: ${({ theme }) => theme.color.GrayBrown};
    color: ${({ theme }) => theme.color.White};
    border: 1px solid ${({ theme }) => theme.color.GrayBrown};
  }
  &.secondary {
    background-color: ${({ theme }) => theme.color.White};
    color: ${({ theme }) => theme.color.Black};
    border: 1px solid ${({ theme }) => theme.color.Gray};
  }
  &.text {
    background-color: ${({ theme }) => theme.color.White};
    color: ${({ theme }) => theme.color.Black};
    border: 1px solid ${({ theme }) => theme.color.White};
  }

  &.danger {
    &.primary {
      background-color: ${({ theme }) => theme.color.danger};
      color: ${({ theme }) => theme.color.White};
      border: 1px solid ${({ theme }) => theme.color.danger};
    }
    &.secondary {
      background-color: ${({ theme }) => theme.color.White};
      color: ${({ theme }) => theme.color.danger};
      border: 1px solid ${({ theme }) => theme.color.danger};
    }
    &.text {
      background-color: ${({ theme }) => theme.color.White};
      color: ${({ theme }) => theme.color.danger};
      border: 1px solid ${({ theme }) => theme.color.White};
    }
  }
`;

interface ButtonProps {
  text?: React.ReactNode;
  type?: 'primary' | 'secondary' | 'text';
  onClick?: (e: React.MouseEvent) => any | undefined;
  style?: CSS.Properties;
  block?: boolean;
  disabled?: boolean;
  htmlType?: 'button' | 'submit' | 'reset';
  danger?: boolean;
}

const Button: React.FC<ButtonProps> = ({
  text = '',
  onClick = undefined,
  type = 'primary',
  style = {},
  block = false,
  disabled = false,
  htmlType = 'button',
  danger = false,
}) => {
  const typeClass = type;
  const blockClass = block ? 'block' : '';
  const dangerClass = danger ? 'danger' : '';

  return (
    <ButtonTag
      type={htmlType}
      onClick={onClick}
      style={style}
      className={`${typeClass} ${blockClass} ${dangerClass}`}
      disabled={disabled}
    >
      {text}
    </ButtonTag>
  );
};

export default Button;
