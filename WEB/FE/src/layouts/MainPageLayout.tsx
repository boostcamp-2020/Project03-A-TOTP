import React from 'react';
import styled from 'styled-components';

interface MainPageLayoutProps {
  children: React.ReactNode;
}

const MainPageLayout: React.FC<MainPageLayoutProps> = ({ children }) => {
  return <>{children}</>;
};

export { MainPageLayout };
