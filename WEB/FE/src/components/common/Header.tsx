import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.header`
  width: 100%;
  height: 64px;
  background-color: ${({ theme }) => theme.color.headerBg};
`;

interface HeaderProps {}

const Header: React.FC<HeaderProps> = () => {
  return <Wrapper />;
};

export { Header };
