import React from 'react';
import styled from 'styled-components';
import ReactPaginate from 'react-paginate';
import { Table } from '@components/common/Table';
import Button from '@components/common/Button';

interface Log {
  time: string;
  device: string;
  ip: string;
  location: string;
  isLoggedIn: boolean;
  sessionId: string | undefined;
}

interface AccessLogProps {
  logs: Array<Log>;
  page: number;
  maxPage: number;
  onPageChange: (selecteItem: { selected: number }) => void;
}

const TableWrapper = styled.div`
  padding: 2rem 0;
`;

const PaginationWrapper = styled.div`
  .pagination {
    display: flex;
    font-size: 1.125rem;
    margin: 2em 0;
    justify-content: center;

    li {
      list-style: none;
    }

    li + li {
      margin-left: 0.5em;
    }

    a {
      width: 2em;
      height: 2em;
      border-radius: 4px;
      display: flex;
      justify-content: center;
      align-items: center;
      cursor: pointer;
      outline: none;
    }

    .active {
      background-color: ${({ theme }) => theme.color.primary};
      color: white;
    }

    .prev-link,
    .next-link {
      background-color: ${({ theme }) => theme.color.border};
    }
  }
`;

function AccessLog({ logs, page, maxPage, onPageChange }: AccessLogProps): JSX.Element {
  const columns = [
    { title: '시간', key: 'time' },
    { title: '디바이스', key: 'device' },
    { title: 'IP', key: 'ip' },
    { title: '위치', key: 'location' },
    {
      title: '상태',
      key: 'isLoggedIn',
      render: (isLoggedIn: boolean) => (isLoggedIn ? '로그인' : '로그아웃'),
    },
    {
      title: '접속차단',
      key: 'sessionId',
      render: (sid: string) => (sid ? <Button text='로그아웃' onClick={() => console.log(sid)} /> : '-'),
    },
  ];
  const data = [
    {
      key: '0',
      time: '2020-20-10',
      device: 'iPhone',
      ip: '201.2.1.3',
      location: '서울',
      isLoggedIn: false,
      sessionId: undefined,
    },
    {
      key: '1',
      time: '2020-20-11',
      device: 'Mac',
      ip: '201.2.1.4',
      location: '서울',
      isLoggedIn: false,
      sessionId: undefined,
    },
    {
      key: '2',
      time: '2020-20-12',
      device: 'Window 10',
      ip: '201.2.1.5',
      location: '부산',
      isLoggedIn: true,
      sessionId: '456',
    },
  ];
  return (
    <>
      <TableWrapper>
        <Table columns={columns} dataSource={data} />
      </TableWrapper>
      <PaginationWrapper>
        <ReactPaginate
          pageCount={maxPage}
          pageRangeDisplayed={3}
          forcePage={page - 1}
          marginPagesDisplayed={2}
          previousLabel='&#xE000;'
          nextLabel='&#xE001;'
          breakLabel='···'
          containerClassName='pagination'
          previousLinkClassName='prev-link'
          nextLinkClassName='next-link'
          activeLinkClassName='active'
          onPageChange={onPageChange}
        />
      </PaginationWrapper>
    </>
  );
}

export { AccessLog };
