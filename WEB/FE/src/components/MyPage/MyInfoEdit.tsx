import React from 'react';
import styled from 'styled-components';
import { Description } from '@/components/common/Description';
import Button from '@/components/common/Button';

interface MyInfoEditProps {
  info: {
    name: [name: string, setName: (name: string) => void];
    mail: [mail: string, setMail: (mail: string) => void];
    birth: [birth: string, setBirth: (birth: string) => void];
    phone: [phone: string, setPhone: (phone: string) => void];
  };
  onSave: () => void;
  onCancel: () => void;
}

const Wrapper = styled.div`
  width: 100%;
  padding: 2rem 0;
`;

const ButtonWrapper = styled.div`
  text-align: center;
  padding-top: 3rem;
`;

function MyInfoEdit({
  info: {
    name: [name, setName],
    mail: [mail, setMail],
    birth: [birth, setBirth],
    phone: [phone, setPhone],
  },
  onSave,
  onCancel,
}: MyInfoEditProps): JSX.Element {
  return (
    <Wrapper>
      <Description>
        <Description.Row>
          <Description.Item label='Name'>
            <input type='text' value={name} onChange={(e) => setName(e.target.value)} />
          </Description.Item>
          <Description.Item label='E-mail'>
            <input type='text' value={mail} onChange={(e) => setMail(e.target.value)} />
          </Description.Item>
        </Description.Row>
        <Description.Row>
          <Description.Item label='Birthday'>
            <input type='text' value={birth} onChange={(e) => setBirth(e.target.value)} />
          </Description.Item>
          <Description.Item label='Phone'>
            <input type='text' value={phone} onChange={(e) => setPhone(e.target.value)} />
          </Description.Item>
        </Description.Row>
      </Description>
      <ButtonWrapper>
        <Button type='text' text='취소' onClick={onCancel} />
        <Button text='수정' onClick={onSave} />
      </ButtonWrapper>
    </Wrapper>
  );
}

export { MyInfoEdit };
