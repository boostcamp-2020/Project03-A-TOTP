import React from 'react';
import styled from 'styled-components';
import bg from '@static/john-tuesday-8c6iJMh80BI-unsplash.jpg';

interface BannerProps {
  children: React.ReactNode;
}

const Wrapper = styled.div`
  width: 100%;
  padding: 8rem 0;
  background-color: dodgerblue;
  background: linear-gradient(90deg, ${({ theme }) => theme.color.primary}DD, #fff0),
    center / cover no-repeat url(${bg});
  filter: saturate(0.7) brightness(1);
`;

const Inner = styled.div`
  width: 100%;
  max-width: calc(${({ theme }) => theme.size.pageWidth} - 320px);
  margin: auto;
  font-size: 40px;
  font-weight: ${({ theme }) => theme.fontWeight.bold};
  line-height: 1.35;
  color: ${({ theme }) => theme.color.white};
  text-shadow: 0 0 6px #0006;
  padding: 0 1rem;
`;

function Banner({ children }: BannerProps): JSX.Element {
  return (
    <Wrapper>
      <Inner>{children}</Inner>
    </Wrapper>
  );
}

export { Banner };
