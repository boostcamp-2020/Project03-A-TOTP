import styled from 'styled-components';

export const ButtonTag = styled.button`
  height: 36px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  background-color: ${({ theme }) => theme.color.GrayBrown};
  color: ${({ theme }) => theme.color.White};
  width: 100%;
`;

export const InputTag = styled.input`
  display: block;
  flex: 1;
  width: 230px;
  height: 30px;
  border: none;
  padding-left: 10px;
`;
