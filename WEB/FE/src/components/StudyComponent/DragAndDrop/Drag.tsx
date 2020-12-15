import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  height: fit-content;
`;

interface DropTargetProps {
  children: React.ReactNode;
  dataItem: string;
}

const Drag = ({ children, dataItem }: DropTargetProps): JSX.Element => {
  function startDrag(e: React.DragEvent<HTMLDivElement>) {
    e.dataTransfer.setData('text/plain', dataItem);
    e.dataTransfer.effectAllowed = 'move';
  }
  return (
    <Wrapper draggable onDragStart={startDrag}>
      {children}
    </Wrapper>
  );
};

export { Drag };
