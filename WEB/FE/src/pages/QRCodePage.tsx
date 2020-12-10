import React from 'react';
import QRCodeComponent from '../components/QRCodeComponent/QRCodeComponent';

const QRCodePage = ({ match }) => {
  return (
    <div>
      <QRCodeComponent url={match.params.url} />
    </div>
  );
};

export default QRCodePage;
