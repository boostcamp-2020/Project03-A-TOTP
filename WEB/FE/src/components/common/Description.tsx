import React from 'react';
import styled from 'styled-components';

interface DescriptionProps {
  children: Array<React.ReactNode>;
}

const Table = styled.table`
  width: 100%;
  border-collapse: collapse;
`;

const TBody = styled.tbody``;

const TH = styled.th`
  border: 1px solid ${({ theme }) => theme.color.border};
  padding: 1.5rem 2rem;
  text-align: left;
  background-color: ${({ theme }) => theme.color.borderColor};
  width: 20%;
`;

const TD = styled.td`
  border: 1px solid ${({ theme }) => theme.color.border};
  padding: 1.5rem 2rem;
  width: 30%;
`;

function Description({ children }: DescriptionProps): JSX.Element {
  return (
    <Table>
      <TBody>{children}</TBody>
    </Table>
  );
}

interface DescriptionRowProps {
  children: Array<React.ReactNode>;
}

function DescriptionRow({ children }: DescriptionRowProps): JSX.Element {
  return <tr>{children}</tr>;
}

interface DescriptionItemProps {
  children: React.ReactNode;
  label: string;
}

function DescriptionItem({ children, label }: DescriptionItemProps): JSX.Element {
  return (
    <>
      <TH>{label}</TH>
      <TD>{children}</TD>
    </>
  );
}

Description.Item = DescriptionItem;
Description.Row = DescriptionRow;

export { Description };
