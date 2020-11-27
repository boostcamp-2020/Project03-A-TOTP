import React from 'react';
import styled from 'styled-components';
import svgImage from '@static/undraw_unlock_24mb.svg';

const Wrapper = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const Inner = styled.div`
  padding: 0 60px;
  display: flex;
  width: 100%;
  align-items: stretch;
`;

const Illustration = styled.div`
  flex: 1;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  > img {
    width: 100%;
    position: relative;
    right: -120px;
  }
`;

const Main = styled.main`
  flex: 1.25;
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1;
`;

interface AuthPageLayoutProps {
  children: React.ReactNode;
}

const AuthPageLayout: React.FC<AuthPageLayoutProps> = ({ children }) => {
  return (
    <Wrapper>
      <Inner>
        <Illustration>
          <img src={svgImage} alt='background illustration' />
        </Illustration>
        <Main>{children}</Main>
      </Inner>
    </Wrapper>
  );
};

export { AuthPageLayout };
