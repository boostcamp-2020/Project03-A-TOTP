import React from 'react';
import { LogInForm } from '@components/LogIn/LogInForm';
import { AuthPageLayout } from '@layouts/AuthPageLayout';

interface LogInPageProps {}

const LogInPage: React.FC<LogInPageProps> = () => {
  return (
    <AuthPageLayout>
      <LogInForm />
    </AuthPageLayout>
  );
};

export default LogInPage;
