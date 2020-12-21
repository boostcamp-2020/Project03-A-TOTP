import { MainPageLayout } from '@/layouts/MainPageLayout';
import React from 'react';
import { RouteComponentProps } from 'react-router-dom';
import QRCodeComponent from '../components/QRCodeComponent/QRCodeComponent';

interface MatchParams {
  url: string;
}

const QRCodePage: React.FC<RouteComponentProps<MatchParams>> = ({ match }) => {
  return (
    <MainPageLayout>
      <QRCodeComponent url={match.params.url} />
    </MainPageLayout>
  );
};

export default QRCodePage;
