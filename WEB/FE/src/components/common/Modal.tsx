import React from 'react';
import styled, { keyframes } from 'styled-components';

interface ModalProps {
  children: React.ReactNode;
  style?: React.CSSProperties;
}

const boxFade = keyframes`
  0% { transform: translateY(100%); }
  100% { transform: translateY(0); }
`;

const Wrapper = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const Dimmed = styled.div`
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: ${({ theme }) => theme.color.Black};
  opacity: 0.2;
  z-index: 100;
`;

const ModalContainer = styled.div`
  position: relative;
  z-index: 101;
  padding: 1.5rem;
  border: 1px solid ${({ theme }) => theme.color.border};
  background-color: ${({ theme }) => theme.color.White};
  border-radius: 4px;
  margin-bottom: 5%;
  animation: ${boxFade} 0.2s;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1), 0 6px 6px rgba(0, 0, 0, 0.14);
`;

const Modal: React.FC<ModalProps> = ({ children, style }) => {
  return (
    <Wrapper>
      <Dimmed />
      <ModalContainer style={style}>{children}</ModalContainer>
    </Wrapper>
  );
};

export { Modal };
