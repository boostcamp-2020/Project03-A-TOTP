import React from 'react';
import styled from 'styled-components';

interface Column {
  title: string;
  key: string;
  render?: (data: any) => React.ReactNode;
}

interface Data {
  key: string | number;
}

interface TableProps {
  columns: Array<Column>;
  dataSource: Array<Data & any>;
}

const TableWrapper = styled.table`
  width: 100%;
`;

const THead = styled.thead`
  border-top: 1px solid ${({ theme }) => theme.color.border};
`;

const TBody = styled.tbody``;

const TH = styled.th`
  padding: 1rem 0.7rem;
  background-color: ${({ theme }) => theme.color.tableHeader};
  text-align: left;
`;

const TR = styled.tr`
  border-bottom: 1px solid ${({ theme }) => theme.color.border};
`;

const TD = styled.td`
  padding: 1rem 0.7rem;
`;

function Table({ columns, dataSource }: TableProps): JSX.Element {
  return (
    <TableWrapper>
      <THead>
        <TR>
          {columns.map((col) => (
            <TH key={col.key}>{col.title}</TH>
          ))}
        </TR>
      </THead>
      <TBody>
        {dataSource.map((data) => (
          <TR key={data.key}>
            {columns.map((col) => (
              <TD key={col.key}>{col.render ? col.render(data[col.key]) : data[col.key]}</TD>
            ))}
          </TR>
        ))}
      </TBody>
    </TableWrapper>
  );
}

export { Table };
