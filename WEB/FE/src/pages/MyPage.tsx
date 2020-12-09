import React from 'react';
import { MainPageLayout } from '@layouts/MainPageLayout';
import { MyPageContainer } from '@components/MyPage/MyPageContainer';
import { Redirect } from 'react-router-dom';

interface MyPageProps {}

function MyPage({}: MyPageProps): JSX.Element {
  if (!localStorage.user) {
    return <Redirect to='/login' />;
  }
  return (
    <MainPageLayout>
      <MyPageContainer />
    </MainPageLayout>
  );
}

export default MyPage;
