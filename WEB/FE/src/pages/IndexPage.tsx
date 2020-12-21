import React from 'react';
import { MainPageLayout } from '@layouts/MainPageLayout';
import { IndexPageContainer } from '@/components/IndexPage/IndexPageContainer';

interface MyPageProps {}

function MyPage({}: MyPageProps): JSX.Element {
  return (
    <MainPageLayout>
      <IndexPageContainer />
    </MainPageLayout>
  );
}

export default MyPage;
