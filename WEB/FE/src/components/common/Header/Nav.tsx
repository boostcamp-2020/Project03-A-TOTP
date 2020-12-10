import React from 'react';
import styled from 'styled-components';
import logo from '@static/logo.svg';
import { Link } from 'react-router-dom';
import Button from '@components/common/Button';

interface NavProps {}

const NavContainer = styled.nav`
  flex: 1;
  display: flex;
  align-items: center;
`;

const LogoContainer = styled.div`
  margin-right: 3rem;
`;

const Title = styled.h1`
  display: inline-block;
  margin-left: 0.5rem;
  font-size: ${({ theme }) => theme.fontSize.lg};
`;

const NavButton = styled.span`
  margin-right: 1.25rem;
`;

function Nav({}: NavProps): JSX.Element {
  return (
    <NavContainer>
      <LogoContainer>
        <Link to='/'>
          <img src={logo} alt='logo' />
          <Title>DADAIKSEON</Title>
        </Link>
      </LogoContainer>
      <NavButton>
        <Link to='/'>
          <Button type='text' text='Why 2FA?' style={{ padding: 0 }} />
        </Link>
      </NavButton>
      <NavButton>
        <Link to='/'>
          <Button type='text' text='TOTP' style={{ padding: 0 }} />
        </Link>
      </NavButton>
      <NavButton>
        <Link to='/'>
          <Button type='text' text='학습하기' style={{ padding: 0 }} />
        </Link>
      </NavButton>
    </NavContainer>
  );
}

export { Nav };
