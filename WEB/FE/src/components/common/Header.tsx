import React from 'react';
import styled from 'styled-components';
import logo from '@static/logo.svg';
import { Link } from 'react-router-dom';
import Button from '@components/common/Button';

const Wrapper = styled.header`
  width: 100%;
  height: 64px;
  background-color: ${({ theme }) => theme.color.headerBg};
  border-bottom: 1px solid ${({ theme }) => theme.color.border};
`;

const Inner = styled.div`
  width: 100%;
  height: 100%;
  max-width: ${({ theme }) => theme.size.pageWidth};
  padding: 0 1rem;
  margin: auto;
  display: flex;
  align-items: center;

  img {
    width: 40px;
    vertical-align: bottom;
  }
`;

const NavContainer = styled.div`
  flex: 1;
  display: flex;
  align-items: center;
`;
const AuthContainer = styled.div``;

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

interface HeaderProps {}

const Header: React.FC<HeaderProps> = () => {
  return (
    <Wrapper>
      <Inner>
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
        <AuthContainer>
          <Link to='/login'>
            <Button type='secondary' text='Log in' style={{ marginRight: '1rem' }} />
          </Link>
          <Link to='signup'>
            <Button type='primary' text='Sign up' />
          </Link>
        </AuthContainer>
      </Inner>
    </Wrapper>
  );
};

export { Header };
