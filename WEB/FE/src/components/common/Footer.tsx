import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.footer`
  height: 108px;
`;

const Inner = styled.div`
  max-width: 1280px;
  height: 100%;
  margin: auto;
  border-top: 1px solid ${({ theme }) => theme.color.borderColor};
  display: flex;
  justify-content: center;
  align-items: center;
`;

interface FooterProps {}

const Footer: React.FC<FooterProps> = () => {
  return (
    <Wrapper>
      <Inner>
        <span>Boostcamp</span>
      </Inner>
    </Wrapper>
  );
};

export { Footer };
