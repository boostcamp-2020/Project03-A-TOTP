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
    e.target.style.opacity = 0;
    e.dataTransfer.setData('text/plain', dataItem);
    e.dataTransfer.effectAllowed = 'move';
  }
  function endDrag(e: React.DragEvent<HTMLDivElement>) {
    e.target.style.opacity = 1;
  }
  return (
    <Wrapper draggable onDragEnd={endDrag} onDragStart={startDrag}>
      {children}
    </Wrapper>
  );
};

export { Drag };
