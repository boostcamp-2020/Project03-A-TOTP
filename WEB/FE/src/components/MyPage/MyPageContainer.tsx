import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { MyInfo } from '@components/MyPage/MyInfo';
import { MyInfoEdit } from '@components/MyPage/MyInfoEdit';
import { AccessLog } from '@components/MyPage/AccessLog';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import { getUser, updateUser } from '@api/index';
import 'react-tabs/style/react-tabs.css';

interface MyPageContainerProps {}

const Wrapper = styled.div`
  width: 100%;
  max-width: ${({ theme }) => theme.size.pageWidth};
  padding: 2rem 1rem;
  margin: auto;

  .react-tabs__tab-list {
    border-bottom: 1px solid ${({ theme }) => theme.color.border};
    display: flex;
    justify-content: space-evenly;
    margin-bottom: 1.5rem;
  }

  .react-tabs__tab {
    color: ${({ theme }) => theme.color.text};
    font-size: 1.125rem;
    border-radius: 0;
  }

  .react-tabs__tab--selected {
    background-color: transparent;
    font-weight: bold;
    border: 1px solid transparent;
    border-bottom: 3px solid ${({ theme }) => theme.color.primary};
  }
`;

const Title = styled.h1`
  font-size: ${({ theme }) => theme.fontSize.xl};
`;

const TabWrapper = styled.div`
  margin-top: 5rem;
`;

function MyPageContainer({}: MyPageContainerProps): JSX.Element {
  const [name, setName] = useState('');
  const [mail, setMail] = useState('');
  const [birth, setBirth] = useState('');
  const [phone, setPhone] = useState('');
  const [isEditInfo, setIsEditInfo] = useState(false);
  const [logs, setLogs] = useState([]);
  const [page, setPage] = useState(1);
  const [maxPage, setMaxPage] = useState(10);

  const onSaveInfo = () =>
    updateUser({ name, email: mail, birth, phone })
      .catch(alert)
      .finally(() => setIsEditInfo(false));
  const onCancelEdit = () => setIsEditInfo(false);
  const onPageChange = ({ selected }: { selected: number }) => setPage(selected + 1);

  useEffect(() => {
    getUser().then(({ user: { name, email, birth, phone } }) => {
      setName(name);
      setMail(email);
      setBirth(birth);
      setPhone(phone);
    });
  }, []);

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
