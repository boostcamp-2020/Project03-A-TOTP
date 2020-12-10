import React from 'react';
import { MainPageLayout } from '@layouts/MainPageLayout';

interface MyPageProps {}

function MyPage({}: MyPageProps): JSX.Element {
  return (
    <MainPageLayout>
      <div>aa</div>
    </MainPageLayout>
  );
}

export default MyPage;
