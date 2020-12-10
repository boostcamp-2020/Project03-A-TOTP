import React from 'react';
import styled from 'styled-components';
import CSS from 'csstype';

interface HeadingSectionProps {
  children: React.ReactNode;
  style?: CSS.Properties;
}

const Section = styled.div`
  padding: 4rem 0;
  background: linear-gradient(150deg, #f96f7688, #f96f7600 70.71%),
    linear-gradient(240deg, #5e71de88, #5e71de00 70.71%), linear-gradient(340deg, #53a2a888, #53a2a800 70.71%),
    linear-gradient(60deg, #6c5b5188, #6c5b5100 70.71%);
  margin-bottom: 3rem;
`;

const Inner = styled.div`
  max-width: ${({ theme }) => theme.size.pageWidth};
  margin: auto;
  padding: 0 1rem;
`;

const Title = styled.h1`
  font-size: ${({ theme }) => theme.fontSize.xl};
`;

function HeadingSection({ children, style }: HeadingSectionProps): JSX.Element {
  return (
    <Section style={style}>
      <Inner>
        <Title>{children}</Title>
      </Inner>
    </Section>
  );
}

HeadingSection.defaultProps = {
  style: {},
};

export { HeadingSection };
