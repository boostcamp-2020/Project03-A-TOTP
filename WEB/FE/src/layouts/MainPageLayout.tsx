import React from 'react';
import styled from 'styled-components';
import { Header } from '@components/common/Header';
import { Footer } from '@components/common/Footer';

const Wrapper = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
`;

const Main = styled.main`
  flex: 1;
`;

interface MainPageLayoutProps {
  children: React.ReactNode;
}

const MainPageLayout: React.FC<MainPageLayoutProps> = ({ children }) => {
  return (
    <Wrapper>
      <Header />
      <Main>{children}</Main>
      <Footer />
    </Wrapper>
  );
};

export { MainPageLayout };
