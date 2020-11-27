import React from 'react';

interface MainPageLayoutProps {}

const MainPageLayout: React.FC<MainPageLayoutProps> = ({ children }) => {
  return <main>{children}</main>;
};

export { MainPageLayout };
