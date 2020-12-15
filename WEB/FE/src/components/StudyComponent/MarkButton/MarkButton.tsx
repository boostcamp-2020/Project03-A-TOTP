import React from 'react';
import Button from '@components/common/Button';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

const ButtonWrapper = styled.div`
  text-align: center;
  margin-top: 20px;
`;

const Addtion = styled.div`
  font-size: ${({ theme }) => theme.fontSize.xl};
  text-align: center;
  margin: 20px 0px;
  color: red;
`;
const LinkColor = styled.span`
  color: ${({ theme }) => theme.color.link};
`;

interface MarkButtonProps {
  markScore: (e: React.MouseEvent<Element, MouseEvent>) => any;
  score: number;
}

const MarkButton = ({ markScore, score }: MarkButtonProps): JSX.Element => {
  return (
    <ButtonWrapper>
      <Button text='채점하기' onClick={(e) => markScore(e)} />
      <Addtion>점수 : {score}</Addtion>
      {score !== 100 ? (
        <div>
          학습이 더 필요하신가요?{' '}
          <Link to='/totp-intro'>
            <LinkColor>학습하러가기</LinkColor>
          </Link>
        </div>
      ) : (
        <div>다 맞으셨어요 ~ 훌륭합니다 !</div>
      )}
    </ButtonWrapper>
  );
};

export { MarkButton };
