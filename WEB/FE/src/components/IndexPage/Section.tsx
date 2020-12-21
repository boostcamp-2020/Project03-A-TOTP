import React from 'react';
import styled from 'styled-components';
import CSS from 'csstype';

interface SectionProps {
  children: React.ReactNode;
  style?: CSS.Properties;
}

const Wrapper = styled.section`
  width: 100%;
  padding: 5rem 0;
`;

const Inner = styled.div`
  width: 100%;
  max-width: ${({ theme }) => theme.size.pageWidth};
  padding: 0 1rem;
  margin: auto;
  display: flex;
  justify-content: space-between;
`;

function Section({ children, style }: SectionProps): JSX.Element {
  return (
    <Wrapper style={style}>
      <Inner>{children}</Inner>
    </Wrapper>
  );
}

Section.defaultProps = {
  style: {},
};

export { Section };
