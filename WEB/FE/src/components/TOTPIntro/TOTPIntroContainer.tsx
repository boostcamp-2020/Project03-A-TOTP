import React from 'react';
import styled from 'styled-components';
import { HeadingSection } from '@components/common/Section/HeadingSection';
import { BlockSection } from '@components/common/Section/BlockSection';
import { Paragraph } from '@components/common/Paragraph';
import totpImage from '@static/totp-diagram.png';
import hmacImage from '@static/640px-SHAhmac.png';
import Button from '@components/common/Button';
import { Link } from 'react-router-dom';

interface TOTPIntroContainerProps {}

const Title = styled.h3`
  font-size: ${({ theme }) => theme.fontSize.lg};
  margin-bottom: 1rem;
`;

const ImageContainer = styled.div`
  text-align: center;
  margin: 3rem 0;
  img {
    width: 100%;
    max-width: 600px;
  }
`;

const ButtonContainer = styled.div`
  text-align: center;
  margin-top: 5rem;
`;

function TOTPIntroContainer({}: TOTPIntroContainerProps): JSX.Element {
  return (
    <>
      <HeadingSection>TOTP</HeadingSection>
      <BlockSection>
        <Title>TOTP의 원리</Title>
        <Paragraph>
          TOTP(Time-based One-time Password, 시간 기반 일회성 암호 알고리즘)는 HMAC 기반 일회성 암호
          알고리즘의 확장으로, 암호 알고리즘으로 HMAC-SHA-1을 사용하며 비밀 키와 현재 시간을 이용해 암호를
          생성합니다.
        </Paragraph>
        <ImageContainer>
          <img src={hmacImage} alt='HMAC-SHA1 diagram' />
        </ImageContainer>
        <Title>TOTP 인증 과정</Title>
        <Paragraph>
          서비스 제공자와 사용자는 사전에 서로 비밀 키를 공유합니다. 그 후 인증할 때 사용자가 OTP를 생성해서
          전달합니다. 서비스 제공자는 전달받은 OTP와 자신이 생성한 OTP가 같은지 비교해서 인증을 처리하게
          됩니다.
        </Paragraph>
        <ImageContainer>
          <img src={totpImage} alt='totp diagram' />
        </ImageContainer>
        <ButtonContainer>
          <Link to='/study'>
            <Button text='확인해보기 &#xE001;' />
          </Link>
        </ButtonContainer>
      </BlockSection>
    </>
  );
}

export { TOTPIntroContainer };
