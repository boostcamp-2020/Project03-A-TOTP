import React from 'react';
import styled from 'styled-components';
import { MainPageLayout } from '@layouts/MainPageLayout';
import notFoundImage from '@static/undraw_page_not_found_su7k.svg';

interface NotFoundPageProps {}

const Wrapper = styled.div`
  max-width: 600px;
  text-align: center;
  img {
    width: 70%;
  }
`;

const Title = styled.h1`
  text-align: center;
  font-size: ${({ theme }) => theme.fontSize.xl};
  font-weight: ${({ theme }) => theme.fontWeight.bold};
  margin-bottom: 2rem;
`;

function NotFoundPage({}: NotFoundPageProps): JSX.Element {
  return (
    <MainPageLayout>
      <Wrapper>
        <Title>페이지를 찾을 수 없어요!</Title>
        <img src={notFoundImage} alt='404' />
      </Wrapper>
    </MainPageLayout>
  );
}

export default NotFoundPage;
