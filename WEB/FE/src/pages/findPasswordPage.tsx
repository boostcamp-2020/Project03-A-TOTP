import React from 'react';

import { FindPasswordComponent } from '@components/findPass/findPasswordComponent';
import { AuthPageLayout } from '@layouts/AuthPageLayout';
import { RouteComponentProps } from 'react-router-dom';

interface PathParamsProps {
  id: string;
}

const FindPasswordPage: React.FC<RouteComponentProps<PathParamsProps>> = ({ location }): JSX.Element => {
  return (
    <AuthPageLayout>
      <FindPasswordComponent location={location} />
    </AuthPageLayout>
  );
};

export default FindPasswordPage;
