import React from 'react';
import styled from 'styled-components';
import { Banner } from '@components/IndexPage/Banner';
import { Section } from '@components/IndexPage/Section';
import sectionImg1 from '@static/undraw_security_o890.svg';
import sectionImg2 from '@static/undraw_mobile_web_2g8b.svg';
import Button from '@components/common/Button';
import { Link } from 'react-router-dom';

interface IndexPageContainerProps {}

const TextContainer = styled.div`
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
`;

const ImageContainer = styled.div`
  flex: 1;
  text-align: center;
  padding: 1rem;
  text-align: center;

  img {
    max-width: 60%;
    max-height: 280px;
  }

  &:first-child {
    margin-right: 8rem;
  }
`;

const Title = styled.h3`
  font-size: ${({ theme }) => theme.fontSize.lg};
  margin-bottom: 1rem;
`;

const Description = styled.p`
  max-width: 440px;
  font-size: ${({ theme }) => theme.fontSize.md};
  line-height: 1.5;
  margin-bottom: 2rem;
  word-break: keep-all;
`;

function IndexPageContainer({}: IndexPageContainerProps): JSX.Element {
  return (
    <>
      <Banner>
        TOTP Authentication
        <br />
        for Everyone
      </Banner>
      <Section>
        <TextContainer>
          <Title>계정을 더 안전하게 보호하세요</Title>
          <Description>
            비밀번호만 사용하는 인증 방법은 더 이상 안전하지 않습니다. 날이 갈수록 데이터 유출은 빈번해지고
            새로운 해킹 방법이 등장하고 있습니다. 2단계 보안인증 적용으로 스스로 위험에서 보호하세요.
          </Description>
          <Link to='/why-2fa'>
            <Button text='더 알아보기 &#xE001;' />
          </Link>
        </TextContainer>
        <ImageContainer>
          <img src={sectionImg1} alt='security' />
        </ImageContainer>
      </Section>
      <Section style={{ backgroundColor: '#f2f2f2' }}>
        <ImageContainer>
          <img src={sectionImg2} alt='security' />
        </ImageContainer>
        <TextContainer>
          <Title>TOTP는 더욱 안전합니다</Title>
          <Description>
            비밀번호와 시간의 조합으로 OTP를 생성하는 TOTP는 더욱 쉽고 안전하게 계정을 위협으로부터 보호할 수
            있도록 해줍니다.
          </Description>
          <Link to='/totp-intro'>
            <Button text='더 알아보기 &#xE001;' />
          </Link>
        </TextContainer>
      </Section>
    </>
  );
}

export { IndexPageContainer };
