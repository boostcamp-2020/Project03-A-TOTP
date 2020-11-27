import React from 'react';
import qs from 'qs';
import QRCodeComponent from '../components/QRCodeComponent/QRCodeComponent';

const QRCodePage = ({ match, location }) => {
  return (
    <div>
      <QRCodeComponent url={match.params.url} query={location.search} />
    </div>
  );
};

// const QRCodePage = () => {
//   return (
//     <div>
//       <QRCodeComponent />
//     </div>
//   );
// };

export default QRCodePage;
