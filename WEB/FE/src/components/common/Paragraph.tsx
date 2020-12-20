import React from 'react';
import styled from 'styled-components';
import CSS from 'csstype';

interface ParagraphProps {
  children: React.ReactNode;
  style?: CSS.Properties;
}

const Wrapper = styled.p`
  word-break: keep-all;
  margin-bottom: 0.5rem;
  letter-spacing: 1px;
  line-height: 200%;
  font-size: ${({ theme }) => theme.fontSize.md};
`;

function Paragraph({ children, style }: ParagraphProps): JSX.Element {
  return <Wrapper style={style}>{children}</Wrapper>;
}

Paragraph.defaultProps = {
  style: {},
};

export { Paragraph };
