import React from 'react';
import styled from 'styled-components';
import { HeadingSection } from '@components/common/Section/HeadingSection';
import { BlockSection } from '@components/common/Section/BlockSection';
import { Paragraph } from '@components/common/Paragraph';

interface TOTPIntroContainerProps {}

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

function TOTPIntroContainer({}: TOTPIntroContainerProps): JSX.Element {
  return (
    <>
      <HeadingSection>TOTP</HeadingSection>
      <BlockSection>
        <ColumnContainer>
          <TextContainer>
            <Title>TOTP의 원리</Title>
            <Paragraph>
              시간 기반 일회성 암호 알고리즘은 HMAC 기반 일회성 암호 알고리즘의 확장으로, 대신 현재 시간에서
              고유성을 가져와 일회성 암호를 생성합니다
            </Paragraph>
          </TextContainer>
          <ImageContainer />
        </ColumnContainer>
      </BlockSection>
    </>
  );
}

export { TOTPIntroContainer };
