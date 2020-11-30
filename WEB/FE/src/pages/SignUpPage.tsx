import React from 'react';
import SignUpComponent from '@components/SignUpComponent/SignUpComponent';
import { AuthPageLayout } from '@layouts/AuthPageLayout';

const SignUpPage = () => {
  return (
    <AuthPageLayout>
      <SignUpComponent />
    </AuthPageLayout>
  );
};

export default SignUpPage;
