import React from 'react';
import styled from 'styled-components';
import { HeadingSection } from '@components/common/Section/HeadingSection';
import { BlockSection } from '@components/common/Section/BlockSection';
import { Paragraph } from '@components/common/Paragraph';
import image from '@static/undraw_two_factor_authentication_namy.svg';

interface Why2FAContainerProps {}

const ColumnContainer = styled.div`
  display: flex;
  align-items: stretch;
`;

const Title = styled.h3`
  font-size: ${({ theme }) => theme.fontSize.lg};
  margin-bottom: 1rem;
`;

const TextContainer = styled.div`
  flex: 1.5;
`;

const ImageContainer = styled.div`
  flex: 1;
  max-width: 400px;
  padding: 2rem;
  display: flex;
  justify-content: center;
  align-items: center;

  img {
    width: 100%;
  }
`;

const List = styled.ul`
  padding: 0.5rem 20px;
  list-style: circle;
`;

function Why2FAContainer({}: Why2FAContainerProps): JSX.Element {
  return (
    <>
      <HeadingSection>Why 2FA?</HeadingSection>
      <BlockSection>
        <ColumnContainer>
          <TextContainer>
            <Title>2단계 보안인증이 필요한 이유</Title>
            <Paragraph>인증 수단(Factor)에는 세 가지 요소가 있습니다.</Paragraph>
            <List>
              <li>정보 - 비밀 번호, 핀 번호</li>
              <li>소유물 - 인증 카드, 스마트폰</li>
              <li>생체 - 지문, 얼굴</li>
            </List>
            <Paragraph>
              대부분의 사람들은 1번 수단인 비밀번호로 한 번만 인증하고 로그인을 하게 됩니다. 비밀번호의
              문제점은 타인과 공유할 수 있으며, 추측할 수 있으며, 유출될 가능성이 크다는 것입니다. ID와
              비밀번호는 각각 2가지 인증 요소처럼 보이지만, 사실 둘 다{' '}
              <b>사용자가 알고 있는 ‘지식’이며, 예측이 쉽습니다.</b>
            </Paragraph>
            <Paragraph>
              게다가 약 <b>39%</b>의 사람들은 다른 온라인 계정에도 같은 비밀번호를 사용한다고 합니다. 가입
              되어 있는 온라인 계정들 중 어딘가는 안전하지 않은 사이트가 있을 수 있습니다. 네이버 카카오에서
              아무리 보안을 두텁게 하고 있다고 한들 올바른 아이디 비밀번호를 입력한 해커를 막을 수는 없을
              것입니다.
            </Paragraph>
            <Paragraph>
              그래서 2FA는 필요합니다. 새로운 기기를 등록하거나 계정 접근 및 변경을 위해 사용자는 계정에
              등록된 이메일 주소나 휴대폰 번호로 발송된 인증코드를 입력하도록 하는 것입니다.{' '}
              <b>
                해커가 사용자 비밀번호를 유출해 이메일 계정을 해킹하더라도, 사용자 휴대폰을 소지하지 않는 한
                해당 서비스의 사용자 정보를 변경하는 것은 불가능하게 됩니다.
              </b>
            </Paragraph>
          </TextContainer>
          <ImageContainer>
            <img src={image} alt='2fa diagram' />
          </ImageContainer>
        </ColumnContainer>
      </BlockSection>
    </>
  );
}

export { Why2FAContainer };
