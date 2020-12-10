import React from 'react';
import { MainPageLayout } from '@layouts/MainPageLayout';
import { MyPageContainer } from '@components/MyPage/MyPageContainer';

interface MyPageProps {}

function MyPage({}: MyPageProps): JSX.Element {
  return (
    <MainPageLayout>
      <MyPageContainer />
    </MainPageLayout>
  );
}

export default MyPage;
