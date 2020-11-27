import React from 'react';
import QRCODE from 'qrcode.react';
import { Modal } from '@components/common/Modal';

const QRCodeComponent = ({ url, query }) => {
  const qrcode = `otpauth://totp/${url}${query}`;
  console.log(qrcode);
  return (
    <Modal>
      <QRCODE value={qrcode} />
    </Modal>
  );
};

export default QRCodeComponent;
