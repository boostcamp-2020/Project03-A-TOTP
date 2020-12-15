import React from 'react';
import { MainPageLayout } from '@layouts/MainPageLayout';
import { StudyComponent } from '@components/StudyComponent/StudyComponent';

interface StudyPageProps {}

function StudyPage({}: StudyPageProps): JSX.Element {
  return (
    <MainPageLayout>
      <StudyComponent />
    </MainPageLayout>
  );
}

export default StudyPage;
