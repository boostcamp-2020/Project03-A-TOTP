import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.footer`
  height: 108px;
`;

const Inner = styled.div`
  max-width: ${({ theme }) => theme.size.pageWidth};
  height: 100%;
  margin: auto;
  border-top: 1px solid ${({ theme }) => theme.color.border};
  display: flex;
  justify-content: center;
  align-items: center;
`;

interface FooterProps {}

const Footer: React.FC<FooterProps> = () => {
  return (
    <Wrapper>
      <Inner>
        <span>&copy; {new Date().getFullYear()} Boostcamp. All right reserved</span>
      </Inner>
    </Wrapper>
  );
};

export { Footer };
