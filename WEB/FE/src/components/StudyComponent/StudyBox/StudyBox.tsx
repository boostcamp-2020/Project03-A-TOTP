import React from 'react';
import { Drag } from '@/components/StudyComponent/DragAndDrop/Drag';
import styled from 'styled-components';
import { initialArrayData } from '@/utils/initialData';
import { DropTarget } from '../DragAndDrop/DropTarget';

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

interface StudyBoxProps {
  value: string;
  list: { [name: string]: string }[];
  onDrop: (e: React.DragEvent<HTMLDivElement>, name: string) => void;
}

const StudyBox = ({ value, list, onDrop }: StudyBoxProps): JSX.Element => {
  return (
    <DropTarget onDrop={(e) => onDrop(e, value)}>
      <DropContainer styles={initialArrayData[value]} isList={value === 'list'}>
        {list.map((item: any): any => {
          return (
            <Drag key={item.name} dataItem={`${value}:${item.name}`}>
              <DragImg styles={initialArrayData[item.name]} src={item.svg} />
            </Drag>
          );
        })}
      </DropContainer>
    </DropTarget>
  );
};

export { StudyBox };
