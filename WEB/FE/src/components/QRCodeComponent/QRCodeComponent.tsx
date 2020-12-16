import React from 'react';
import QRCODE from 'qrcode.react';
import styled from 'styled-components';
import { useHistory } from 'react-router-dom';
import { Buffer } from 'buffer';
import CSS from 'csstype';
import Button from '@components/common/Button';
import { message } from '@utils/message';

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
  button {
    font-size: ${({ theme }) => theme.fontSize.md};
    font-weight: ${({ theme }) => theme.fontWeight.bold};
    margin-top: 18%;
  }
`;

const Wrapper = styled.div`
  width: 100%;
  height: 100%;
  background-color: ${({ theme }) => theme.color.white};
`;

const QRContainer = styled.div`
  padding: 1.5rem;
  border: 1px solid ${({ theme }) => theme.color.border};
  background-color: ${({ theme }) => theme.color.white};
  border-radius: 4px;
  margin-bottom: 5%;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1), 0 6px 6px rgba(0, 0, 0, 0.14);
  width: fit-content;
  height: fit-content;
  margin: 6% auto;
`;

const buttonStyle: CSS.Properties = {
  width: '20%',
  float: 'right',
  padding: '0px',
};

interface qrProps {
  url: string;
}

const QRCodeComponent = ({ url }: qrProps): JSX.Element => {
  const qrcode = Buffer.from(decodeURIComponent(url), 'base64').toString('ascii');
  const history = useHistory();
  const onClick = (e: React.MouseEvent<Element, MouseEvent>): void => {
    e.preventDefault();
    alert(message.AFTERQRREGISTER);
    history.push('/');
  };
  return (
    <Wrapper>
      <QRContainer>
        <Title>Register QR Code</Title>
        <ContentWrapper>
          <QRWrapper>
            <QRCODE value={qrcode} />
          </QRWrapper>
          <RegisterText>
            <ContentText>1. APP을 켜주세요.</ContentText>
            <ContentText>2. 등록 버튼을 눌러주세요.</ContentText>
            <ContentText>3. 카메라 중앙에 QR Code를 위치시켜주세요.</ContentText>
            <Button text='Done' style={buttonStyle} onClick={(e) => onClick(e)} />
          </RegisterText>
        </ContentWrapper>
      </QRContainer>
    </Wrapper>
  );
};

export default QRCodeComponent;
