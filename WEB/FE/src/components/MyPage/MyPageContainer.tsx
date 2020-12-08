import React, { useState } from 'react';
import styled from 'styled-components';
import { MyInfo } from '@components/MyPage/MyInfo';
import { MyInfoEdit } from '@components/MyPage/MyInfoEdit';
import { AccessLog } from '@components/MyPage/AccessLog';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import 'react-tabs/style/react-tabs.css';

interface MyPageContainerProps {}

const Wrapper = styled.div`
  width: 100%;
  max-width: 1440px;
  padding: 2rem 1rem;
  margin: auto;

  .react-tabs__tab-list {
    border-bottom: 1px solid ${({ theme }) => theme.color.border};
    display: flex;
    justify-content: space-evenly;
    margin-bottom: 1.5rem;
  }

  .react-tabs__tab {
    color: ${({ theme }) => theme.color.Black};
    font-size: 1.125rem;
    border-radius: 0;
  }

  .react-tabs__tab--selected {
    background-color: transparent;
    font-weight: bold;
    border: 1px solid transparent;
    border-bottom: 3px solid ${({ theme }) => theme.color.Black};
  }
`;

const Title = styled.h1`
  font-size: ${({ theme }) => theme.fontSize.xl};
`;

const TabWrapper = styled.div`
  margin-top: 5rem;
`;

function MyPageContainer({}: MyPageContainerProps): JSX.Element {
  const [name, setName] = useState('jh');
  const [mail, setMail] = useState('asd@naver.com');
  const [birth, setBirth] = useState('2020-20-20');
  const [phone, setPhone] = useState('010-2312-1234');
  const [isEditInfo, setIsEditInfo] = useState(false);
  const [logs, setLogs] = useState([]);
  const [page, setPage] = useState(1);
  const [maxPage, setMaxPage] = useState(10);

  const onSaveInfo = () => setIsEditInfo(false);
  const onCancelEdit = () => setIsEditInfo(false);
  const onPageChange = ({ selected }: { selected: number }) => setPage(selected + 1);

  return (
    <Wrapper>
      <Title>마이페이지</Title>
      <TabWrapper>
        <Tabs>
          <TabList>
            <Tab>내 정보</Tab>
            <Tab>접속 이력</Tab>
          </TabList>
          <TabPanel>
            {isEditInfo ? (
              <MyInfoEdit
                info={{
                  name: [name, setName],
                  mail: [mail, setMail],
                  birth: [birth, setBirth],
                  phone: [phone, setPhone],
                }}
                onSave={onSaveInfo}
                onCancel={onCancelEdit}
              />
            ) : (
              <MyInfo info={{ name, mail, birth, phone }} onEdit={() => setIsEditInfo(true)} />
            )}
          </TabPanel>
          <TabPanel>
            <AccessLog logs={logs} page={page} maxPage={maxPage} onPageChange={onPageChange} />
          </TabPanel>
        </Tabs>
      </TabWrapper>
    </Wrapper>
  );
}

export { MyPageContainer };