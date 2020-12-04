import React from 'react';

import { FindIDComponent } from '@components/findID/findIDComponent';
import { AuthPageLayout } from '@layouts/AuthPageLayout';

const SignUpPage = (): JSX.Element => {
  return (
    <AuthPageLayout>
      <FindIDComponent />
    </AuthPageLayout>
  );
};

export default SignUpPage;
