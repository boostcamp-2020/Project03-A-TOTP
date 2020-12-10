import React, { useEffect } from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

interface DropdownProps {
  onClose: () => void;
  onLogout: () => void;
}

const Wrapper = styled.div`
  position: absolute;
  right: 0;
  top: 3rem;
  border: 1px solid ${({ theme }) => theme.color.darkerBorder};
  background-color: ${({ theme }) => theme.color.white};
  border-radius: 4px;
  padding: 0.5rem 0;
`;

const Button = styled.button`
  width: 100%;
  border: 0;
  background-color: transparent;
  text-align: left;
  padding: 0.5rem;

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
