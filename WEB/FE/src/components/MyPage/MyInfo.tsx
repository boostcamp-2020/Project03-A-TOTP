import React from 'react';
import styled from 'styled-components';
import { Description } from '@/components/common/Description';
import Button from '@/components/common/Button';

interface MyInfoProps {
  info: {
    name: string;
    mail: string;
    birth: string;
    phone: string;
  };
  onEdit: () => void;
}

const Wrapper = styled.div`
  width: 100%;
  padding: 2rem 0;
`;

const ButtonWrapper = styled.div`
  text-align: center;
  padding-top: 3rem;
`;

function MyInfo({ info: { name, mail, birth, phone }, onEdit }: MyInfoProps): JSX.Element {
  return (
    <Wrapper>
      <Description>
        <Description.Row>
          <Description.Item label='Name'>{name}</Description.Item>
          <Description.Item label='E-mail'>{mail}</Description.Item>
        </Description.Row>
        <Description.Row>
          <Description.Item label='Birthday'>{birth}</Description.Item>
          <Description.Item label='Phone'>{phone}</Description.Item>
        </Description.Row>
      </Description>
      <ButtonWrapper>
        <Button text='수정' onClick={onEdit} />
      </ButtonWrapper>
    </Wrapper>
  );
}

export { MyInfo };
