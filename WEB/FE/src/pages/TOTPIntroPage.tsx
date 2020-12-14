import React from 'react';
import { MainPageLayout } from '@layouts/MainPageLayout';
import { TOTPIntroContainer } from '@components/TOTPIntro/TOTPIntroContainer';

interface TOTPIntroPageProps {}

function TOTPIntroPage({}: TOTPIntroPageProps): JSX.Element {
  return (
    <MainPageLayout>
      <TOTPIntroContainer />
    </MainPageLayout>
  );
}

export default TOTPIntroPage;
