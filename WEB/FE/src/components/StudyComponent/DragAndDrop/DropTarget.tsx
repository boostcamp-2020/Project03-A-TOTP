import React from 'react';

interface DropTargetProps {
  children: React.ReactNode;
  onDrop: (e: React.DragEvent<HTMLDivElement>, name: string) => void;
}

const DropTarget = ({ children, onDrop }: DropTargetProps): JSX.Element => {
  function dragOver(e: React.DragEvent<HTMLDivElement>) {
    e.preventDefault();
    e.dataTransfer.dropEffect = 'move';
  }
  return (
    <div onDragOver={dragOver} onDrop={onDrop}>
      {children}
    </div>
  );
};

export { DropTarget };
