import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  width: 100%;
  padding: 10rem 0;
  background-color: dodgerblue;
`;

const Inner = styled.div`
  width: 100%;
  max-width: calc(${({ theme }) => theme.size.pageWidth} - 400px);
  margin: auto;
  font-size: ${({ theme }) => theme.fontSize.xl};
  color: white;
`;

function Banner() {
  return (
    <Wrapper>
      <Inner>
        TOTP Authentication
        <br />
        for Everyone
      </Inner>
    </Wrapper>
  );
}

export { Banner };
