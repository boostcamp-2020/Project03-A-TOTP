import React, { useState } from 'react';
import svgBackground from '@static/TOTPFrame.svg';
import styled from 'styled-components';
import { HeadingSection } from '@components/common/Section/HeadingSection';
import { BlockSection } from '@components/common/Section/BlockSection';
import { initialArrayData, initialStudyData } from '@utils/initialData';
import { Drag } from './DragAndDrop/Drag';
import { DropTarget } from './DragAndDrop/DropTarget';
import { MarkButton } from './MarkButton/MarkButton';
import { StudyBox } from './StudyBox/StudyBox';

interface ListProps {
  [name: string]: string;
}

const BackGround = styled.div`
  background-image: url(${svgBackground});
  background-size: 1000px;
  background-repeat: no-repeat;
  height: 441px;
  background-position: center;
  position: relative;
`;

const DropContainer = styled.div<{ styles: any; isList: boolean }>`
  position: ${(props) => (props.isList ? 'relative' : 'absolute')};
  left: ${(props) => props.styles.left}px;
  top: ${(props) => props.styles.top}px;
  width: ${(props) => props.styles.width}px;
  height: ${(props) => props.styles.height}px;
  overflow: visible;
  justify-content: ${(props) => (props.isList ? 'none' : 'center')};
  display: flex;
  flex-wrap: wrap;
  margin: auto;
  border: ${(props) => (props.isList ? '2px solid black' : 'none')};
`;

const DragImg = styled.img<{ styles: any }>`
  width: ${(props) => props.styles.width - 5}px;
  height: ${(props) => props.styles.height - 5}px;
`;

const Title = styled.div`
  font-size: ${({ theme }) => theme.fontSize.xl};
`;

const Content = styled.div`
  font-size: ${({ theme }) => theme.fontSize.lg};
  margin: 20px;
  margin-left: 20px;
`;

const MiddleContent = styled.div`
  font-size: ${({ theme }) => theme.fontSize.lg};
  margin: 20px 108px;
  background: linear-gradient(150deg, #f96f7688, #f96f7600 70.71%),
    linear-gradient(240deg, #5e71de88, #5e71de00 70.71%), linear-gradient(340deg, #53a2a888, #53a2a800 70.71%),
    linear-gradient(60deg, #6c5b5188, #6c5b5100 70.71%);
  color: aliceblue;
  text-align: center;
`;

const StudyComponent = (): JSX.Element => {
  const [state, setState] = useState({ ...initialStudyData });
  const [score, setScore] = useState(0);

  const onDrop = (e: React.DragEvent<HTMLDivElement>, name: string) => {
    const newData = {
      ...state,
    };
    const targetContainer = state[name];
    if (name !== 'list' && targetContainer.length !== 0) return;
    const originData = e.dataTransfer.getData('text');
    const temp = originData.split(':');
    if (name === temp[0]) return;
    const originContainer = state[temp[0]];
    const liItem = temp[1];
    e.dataTransfer.clearData();
    const idx = originContainer
      .map((item: ListProps) => {
        return item.name;
      })
      .indexOf(liItem);
    targetContainer.push(originContainer[idx]);
    originContainer.splice(idx, 1);
    setState(newData);
  };

  const markScore = (e: React.MouseEvent<Element, MouseEvent>) => {
    e.preventDefault();
    let value = 0;
    Object.keys(state).forEach((key) => {
      return state[key].forEach((item: ListProps) => {
        value += key.substring(0, key.length - 1) === item.name.substring(0, item.name.length - 1) ? 10 : 0;
      });
    });
    setScore(value);
  };

  const makeContainer = (value: string, list: ListProps[]) => {
    return (
      <DropTarget onDrop={(e) => onDrop(e, value)}>
        <DropContainer styles={initialArrayData[value]} isList={value === 'list'}>
          {list.map(
            (item: ListProps): JSX.Element => {
              return (
                <Drag dataItem={`${value}:${item.name}`}>
                  <DragImg styles={initialArrayData[item.name]} src={item.svg} />
                </Drag>
              );
            },
          )}
        </DropContainer>
      </DropTarget>
    );
  };
  return (
    <>
      <HeadingSection>학습하기</HeadingSection>
      <BlockSection>
        <Title>학습하기</Title>
        <Content>
          앞에서 배웠던 TOTP를 직접 만들어보면서 내가 완벽하게 이해했는지 확인해보세요 ! <br />
          채점하기 버튼을 통해서 점수도 확인해볼 수 있습니다.
        </Content>
        <BackGround>
          {Object.keys(state)
            .filter((value) => value !== 'list')
            .map((value) => {
              return <StudyBox value={value} list={state[value]} onDrop={onDrop} />;
            })}
        </BackGround>
        <MiddleContent>아래 아이콘들을 드래그하여 위 빈칸에 넣어보세요 !</MiddleContent>
        <div>{makeContainer('list', state.list)}</div>
        <MarkButton markScore={markScore} score={score} />
      </BlockSection>
    </>
  );
};

export { StudyComponent };
