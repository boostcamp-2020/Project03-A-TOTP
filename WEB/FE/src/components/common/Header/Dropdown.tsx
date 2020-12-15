import React, { useEffect } from 'react';
import styled, { keyframes } from 'styled-components';
import { Link } from 'react-router-dom';

interface DropdownProps {
  onClose: () => void;
  onLogout: () => void;
}

const ScaleIn = keyframes`
  0% { transform: scale(0.7); }
  100% { transform: scale(1); }
`;

const Wrapper = styled.div`
  position: absolute;
  right: 0;
  top: 52px;
  border: 1px solid ${({ theme }) => theme.color.darkerBorder};
  background-color: ${({ theme }) => theme.color.white};
  border-radius: 4px;
  padding: 0.5rem 0;
  z-index: 1;
  animation: ${ScaleIn} 0.15s;
  animation-timing-function: cubic-bezier(0.2, 0, 0.13, 1.5);
  width: 100%;
  min-width: 120px;

  &:before {
    top: -16.5px;
    right: 19px;
    left: auto;
    border: 8px solid transparent;
    border-bottom: 8px solid ${({ theme }) => theme.color.darkerBorder};
    position: absolute;
    display: inline-block;
    content: '';
  }
  &:after {
    top: -14px;
    right: 20px;
    left: auto;
    border: 7px solid transparent;
    border-bottom: 7px solid ${({ theme }) => theme.color.white};
    position: absolute;
    display: inline-block;
    content: '';
  }
`;

const Button = styled.button`
  width: 100%;
  border: 0;
  background-color: transparent;
  text-align: left;
  padding: 0.5rem;
  font-size: ${({ theme }) => theme.fontSize.md};

  &:hover {
    background-color: ${({ theme }) => theme.color.border};
  }
`;

function Dropdown({ onClose, onLogout }: DropdownProps): JSX.Element {
  useEffect(() => {
    const clickOutside = ({ target }: MouseEvent) => {
      if ((target as HTMLElement).closest('.header-dropdown')) return;
      onClose();
    };
    document.addEventListener('click', clickOutside);
    return () => document.removeEventListener('click', clickOutside);
  }, []);

  return (
    <Wrapper className='header-dropdown'>
      <Link to='/me'>
        <Button type='button'>내 정보</Button>
      </Link>
      <Button type='button' onClick={onLogout}>
        로그아웃
      </Button>
    </Wrapper>
  );
}

export { Dropdown };
