import React from 'react';
import QRCODE from 'qrcode.react';
import { Modal } from '@components/common/Modal';
import styled from 'styled-components';
import { ButtonTag } from '@styles/style';
import { Link } from 'react-router-dom';
import { Buffer } from 'buffer';

const Title = styled.div`
  font-size: ${({ theme }) => theme.fontSize.xl};
  font-weight: 600;
  margin-right: 290px;
  margin-bottom: 10%;
`;

const ContentWrapper = styled.div`
  display: flex;
`;

const ContentText = styled.p`
  margin-bottom: 15px;
`;

const QRWrapper = styled.div`
  background-color: #f4f4f4;
  padding: 48px;
`;

const RegisterText = styled.div`
  font-size: ${({ theme }) => theme.fontSize.lg};
  margin-left: 20px;
`;

const ConfirmButton = styled(ButtonTag)`
  width: 20%;
  float: right;
  color: white;
  font-size: ${({ theme }) => theme.fontSize.md};
  font-weight: 600;
  margin-top: 18%;
`;

interface qrProps {
  url: string;
}

const QRCodeComponent = ({ url }: qrProps): JSX.Element => {
  const qrcode = decodeURIComponent(Buffer.from(url, 'base64').toString('ascii'));
  return (
    <Modal>
      <Title>Register QR Code</Title>
      <ContentWrapper>
        <QRWrapper>
          <QRCODE value={qrcode} />
        </QRWrapper>
        <RegisterText>
          <ContentText>1. APP을 켜주세요.</ContentText>
          <ContentText>2. A 버튼을 눌러주세요.</ContentText>
          <ContentText>3. 카메라 중앙에 QR Code를 위치시켜주세요.</ContentText>
          <Link to='/'>
            <ConfirmButton>Done</ConfirmButton>
          </Link>
        </RegisterText>
      </ContentWrapper>
    </Modal>
  );
};

export default QRCodeComponent;
