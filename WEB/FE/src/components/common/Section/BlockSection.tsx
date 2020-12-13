import React from 'react';
import styled from 'styled-components';
import CSS from 'csstype';

interface BlockSectionProps {
  children: React.ReactNode;
  style?: CSS.Properties;
}

const Wrapper = styled.section`
  width: 100%;
`;

const Inner = styled.div`
  width: 100%;
  max-width: ${({ theme }) => theme.size.pageWidth};
  margin: auto;
  padding: 1rem;
`;

function BlockSection({ children, style }: BlockSectionProps): JSX.Element {
  return (
    <Wrapper style={style}>
      <Inner>{children}</Inner>
    </Wrapper>
  );
}

BlockSection.defaultProps = {
  style: {},
};

export { BlockSection };
