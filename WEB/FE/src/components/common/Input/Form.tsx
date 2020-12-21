import React from 'react';
import styled from 'styled-components';

export const Wrapper = styled.div`
  display: flex;
  justify-content: center;
  border: 1px solid ${({ theme }) => theme.color.darkerBorder};
  border-radius: 4px;
  margin-top: 1.3rem;
  overflow: hidden;
  position: relative;
`;

const Button = styled.button`
  flex: 0.2;
  height: 36px;
  border: none;
`;

interface Props {
  children: React.ReactNode;
  buttonEvent?: (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => Promise<void>;
}

const Form = ({ children, buttonEvent }: Props): JSX.Element => {
  return (
    <Wrapper>
      {children}
      {buttonEvent ? <Button onClick={(e) => buttonEvent(e)}>verify</Button> : undefined}
    </Wrapper>
  );
};

Form.defaultProps = {
  buttonEvent: undefined,
};

export default Form;
