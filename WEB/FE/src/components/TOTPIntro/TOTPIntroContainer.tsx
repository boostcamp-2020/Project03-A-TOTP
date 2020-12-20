import React from 'react';
import styled from 'styled-components';
import { HeadingSection } from '@components/common/Section/HeadingSection';
import { BlockSection } from '@components/common/Section/BlockSection';
import { Paragraph } from '@components/common/Paragraph';
import totpImage from '@static/totp-diagram.png';
import otpRegist from '@static/OTP_authenticatioin_registration.png';
import dice from '@static/Dice.jpg';
import hmacImage from '@static/640px-SHAhmac.png';
import Button from '@components/common/Button';
import { Link } from 'react-router-dom';

interface TOTPIntroContainerProps {}

const Title = styled.h3`
  font-size: ${({ theme }) => theme.fontSize.xl};
  margin-bottom: 3rem;
  margin-top: 2rem;
`;

const ImageContainer = styled.div`
  text-align: center;
  margin: 3rem 0;
  img {
    width: 100%;
    max-width: 70%;
  }
`;

const List = styled.ul`
  padding: 0.5rem 20px;
  list-style: circle;
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
        <Title>OTP 란?</Title>
        <Paragraph>
          OTP란 무엇인가??
          <br />
          <b>OTP는</b> One-Time Password로 인증에 한 번 사용되는 비밀번호입니다. 그 방법은 무작위 번호 약속
          알고리즘에 따라 매시간 변경되는 추정 할 수 없는 비밀번호를 생성하는 것입니다. 인증할 비밀번호가{' '}
          <b>일회용이기</b> 때문에 노출되어도 재사용이 불가능하며 알고리즘을 통해 생성되므로 외부 서버 없이
          비밀번호를 생성 가능합니다.
          <br />
          따라서 가장 흔하게 우리가 접할 수 있는 곳은 주로 은행 등의 중요 자산을 보관하는 곳이고 그만큼
          안정성에 있어서 높은 효율을 보여줍니다.
          <ImageContainer>
            <img src={dice} alt='랜덤 숫자' style={{ borderRadius: '10px' }} />
          </ImageContainer>
        </Paragraph>
        <Paragraph>
          그런데 어떻게 <b>랜덤한 비밀번호가</b> 만들어지고 그것을 인증할 수 있을까??
          <br />
          만약 주사위 굴리듯 랜덤한 숫자를 만든다면 당연하게 인증할 수 없을 것입니다.
          <br />이 랜덤한 비밀번호 생성 원리를 이해하기 위해서 먼저 우리 사이트에서는 어떤 과정으로 등록되고
          인증되는지 간단하게 살펴보겠습니다. 직접 회원가입을 진행하고 인증을 한다면 이해에 더욱 도움이 될
          것입니다.
          <ImageContainer>
            <img src={otpRegist} alt='OTP authentication registration' />
          </ImageContainer>
          위 등록 페이지를 보면 QR-Code를 앱에서 등록하면 6자리 비밀번호를 확인할 수 있습니다. 그렇다면
          넘겨주는 <b>QR-Code</b>에 담긴 것은 무엇이고? 어떻게 매번 인증 가능한 다른 <b>비밀번호가</b> 나오는
          것일까요?
          <br />
          아래 원리를 살펴 보도록 합시다.
        </Paragraph>
        <hr />
        <Title>TOTP의 원리</Title>
        <Paragraph>
          TOTP(Time-based One-time Password, 시간 기반 일회성 암호 알고리즘)는 HMAC 기반 일회성 암호
          알고리즘의 확장으로, 암호 알고리즘으로 HMAC-SHA-1을 사용하며 비밀 키와 현재 시각을 이용해 암호를
          생성합니다.
        </Paragraph>
        <ImageContainer>
          <img src={hmacImage} alt='HMAC-SHA1 diagram' />
        </ImageContainer>
        <Paragraph>
          위 그림을 보면 비밀번호를 생성하기 위해서는 <b>Key</b>가 필요하다는 것을 알 수 있습니다. 그리고
          여기에 시간 값을 더해 원하는 비밀번호를 생성하는 것입니다.
          <br />즉 동일한 <b>Key</b>를 가지고 있다면 동일한 시간 범위 안에서는 같은 비밀번호를 얻을 수 있다는
          것입니다.
        </Paragraph>

        <hr />
        <Title>TOTP 인증 과정 정리</Title>
        <Paragraph>
          <List>
            <li>서비스 제공자와 사용자는 사전에 서로 비밀 키를 공유합니다.</li>
            <li>인증할 때 사용자가 OTP를 생성해서 전달합니다</li>
            <li>
              서비스 제공자는 전달받은 OTP와 자신이 생성한 OTP가 같은지 비교해서 인증을 처리하게 됩니다.
            </li>
          </List>
          <ImageContainer>
            <img src={totpImage} alt='totp diagram' />
          </ImageContainer>
          따라서 저희 사이트에서 QR-Code로 넘겨 주는 것은 <b>Key</b>이고 시각을 통해서 매번 인증 가능한
          비밀번호가 도출 되는 것입니다.
        </Paragraph>

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
