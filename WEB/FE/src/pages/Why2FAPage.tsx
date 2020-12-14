import React from 'react';
import { MainPageLayout } from '@layouts/MainPageLayout';
import { Why2FAContainer } from '@components/Why2FA/Why2FAContainer';

interface Why2FAPageProps {}

function Why2FAPage({}: Why2FAPageProps): JSX.Element {
  return (
    <MainPageLayout>
      <Why2FAContainer />
    </MainPageLayout>
  );
}

export default Why2FAPage;
