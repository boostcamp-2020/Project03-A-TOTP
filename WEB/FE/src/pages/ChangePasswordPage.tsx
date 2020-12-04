import React from 'react';

import { ChangePasswordComponent } from '@/components/ChangePass/ChangePasswordComponent';
import { AuthPageLayout } from '@layouts/AuthPageLayout';
import { RouteComponentProps } from 'react-router-dom';

interface PathParamsProps {
  id: string;
}

const ChangePasswordPage: React.FC<RouteComponentProps<PathParamsProps>> = ({ location }): JSX.Element => {
  return (
    <AuthPageLayout>
      <ChangePasswordComponent location={location} />
    </AuthPageLayout>
  );
};

export default ChangePasswordPage;
