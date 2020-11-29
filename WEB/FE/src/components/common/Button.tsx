import React from 'react';
import { ButtonTag } from '@styles/style';

const Button = (props: any) => {
  const { name, buttonEvent } = props;
  return <ButtonTag onClick={(e) => buttonEvent(e)}>{name}</ButtonTag>;
};

export default Button;
