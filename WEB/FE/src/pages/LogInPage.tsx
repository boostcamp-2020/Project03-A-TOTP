import React from 'react';
import { LogInContainer } from '@components/LogIn/LogInContainer';
import { AuthPageLayout } from '@layouts/AuthPageLayout';

interface LogInPageProps {}

const LogInPage: React.FC<LogInPageProps> = () => {
  return (
    <AuthPageLayout>
      <LogInContainer />
    </AuthPageLayout>
  );
};

export default LogInPage;
