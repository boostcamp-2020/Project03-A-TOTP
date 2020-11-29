import React from 'react';
import styled from 'styled-components';
import Button from '@components/common/Button';

const Wrapper = styled.form``;

interface LogInFormProps {}

const LogInForm: React.FC<LogInFormProps> = () => {
  return (
    <Wrapper>
      <Button />
    </Wrapper>
  );
};

export { LogInForm };
