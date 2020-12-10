import React from 'react';
import styled from 'styled-components';
import ReactPaginate from 'react-paginate';
import { Table } from '@components/common/Table';
import { delSession } from '@api/index';
import Button from '@components/common/Button';

interface Log {
  time: string;
  device: string;
  ip: string;
  location: string;
  isLoggedOut: boolean;
  sessionId: string | undefined;
}

interface AccessLogProps {
  logs: Array<Log>;
  setLogs: any;
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

function AccessLog({ logs, setLogs, page, maxPage, onPageChange }: AccessLogProps): JSX.Element {
  const onDelete = (sid: string) => {
    delSession({ sid }).then((result) => {
      console.log(result);
      if (result) {
        let newLogs = [...logs];
        newLogs = newLogs.map((log: Log) => {
          if (log.sessionId === sid) {
            log.sessionId = '';
            log.isLoggedOut = true;
          }
          return log;
        });
        setLogs(newLogs);

        alert('로그아웃 성공');
      } else {
        alert('요청 실패');
      }
    });
  };
  const columns = [
    {
      title: '시간',
      key: 'time',
      render: (time: Date) => {
        const show = new Date(time);
        // return <>{show.toLocaleString()}</>;

        show.setHours(show.getHours() + 9);
        const show1 = show.toISOString();
        const showArry = show1.split('T');
        return <>{`${showArry[0]} ${showArry[1].substring(0, 5)}`}</>;
      },
    },
    { title: '디바이스', key: 'device' },
    { title: 'IP', key: 'ip' },
    { title: '위치', key: 'location' },
    {
      title: '상태',
      key: 'isLoggedOut',
      render: (isLoggedOut: boolean) => (isLoggedOut ? '로그아웃' : '로그인'),
    },
    {
      title: '접속차단',
      key: 'sessionId',
      render: (sid: string) => (sid ? <Button text='로그아웃' onClick={() => onDelete(sid)} /> : '-'),
    },
  ];
  return (
    <>
      <TableWrapper>
        <Table columns={columns} dataSource={logs} />
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
