import React, { useState } from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';
import Button from '@components/common/Button';
import storageHandler from '@utils/localStorage';
import { Dropdown } from '@components/common/Header/Dropdown';
import { Nav } from '@components/common/Header/Nav';

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

const AuthContainer = styled.div`
  position: relative;
`;

interface HeaderProps {}

const Header: React.FC<HeaderProps> = () => {
  const userName = storageHandler.get();
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);

  const onLogout = () => {};

  return (
    <Wrapper>
      <Inner>
        <Nav />
        <AuthContainer>
          {userName ? (
            <>
              <Button type='primary' text={userName} onClick={() => setIsDropdownOpen(true)} />
              {isDropdownOpen && <Dropdown onClose={() => setIsDropdownOpen(false)} onLogout={onLogout} />}
            </>
          ) : (
            <>
              <Link to='/login'>
                <Button type='secondary' text='Log in' style={{ marginRight: '1rem' }} />
              </Link>

              <Link to='signup'>
                <Button type='primary' text='Sign up' />
              </Link>
            </>
          )}
        </AuthContainer>
      </Inner>
    </Wrapper>
  );
};

export { Header };
