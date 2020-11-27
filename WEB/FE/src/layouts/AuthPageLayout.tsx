import React from 'react';

interface AuthPageLayoutProps {}

const AuthPageLayout: React.FC<AuthPageLayoutProps> = ({ children }) => {
  return <main>{children}</main>;
};

export { AuthPageLayout };
