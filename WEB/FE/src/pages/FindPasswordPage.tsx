import React from 'react';
import { FindPasswordContainer } from '@components/FindPassword/FindPasswordContainer';
import { AuthPageLayout } from '@layouts/AuthPageLayout';

interface FindPasswordPageProps {}

const FindPasswordPage: React.FC<FindPasswordPageProps> = () => {
  return (
    <AuthPageLayout>
      <FindPasswordContainer />
    </AuthPageLayout>
  );
};

export default FindPasswordPage;
