import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { useHistory } from 'react-router-dom';
import { MyInfo } from '@components/MyPage/MyInfo';
import { MyInfoEdit } from '@components/MyPage/MyInfoEdit';
import { AccessLog } from '@components/MyPage/AccessLog';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import 'react-tabs/style/react-tabs.css';
import { AxiosError } from 'axios';
import { PasswordModal } from '@components/PasswordModal/PasswordModal';
import { getUser, updateUser, sendPassword, receiveLogs } from '@api/index';
import storageHandler from '@utils/localStorage';
import { HeadingSection } from '@components/common/Section/HeadingSection';

const UNAUTHORIZED = 401;
const LOGIN_URL = '/login';

interface MyPageContainerProps {}

const Wrapper = styled.div`
  width: 100%;
  margin: auto;

  .react-tabs__tab-list {
    border-bottom: 1px solid ${({ theme }) => theme.color.darkerBorder};
    display: flex;
    justify-content: space-evenly;
    margin-bottom: 1.5rem;
  }

  .react-tabs__tab {
    color: ${({ theme }) => theme.color.text};
    font-size: 1.125rem;
    border-radius: 0;

    &:focus {
      box-shadow: none;

      &:after {
        display: none;
      }
    }
  }

  .react-tabs__tab--selected {
    background-color: transparent;
    font-weight: bold;
    border: 1px solid transparent;
    border-bottom: 3px solid ${({ theme }) => theme.color.primary};
  }
`;

const TabWrapper = styled.div`
  margin-top: 5rem;
  max-width: ${({ theme }) => theme.size.pageWidth};
  padding: 0 1rem;
  margin-bottom: 2rem;
  margin: auto;
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
  const [password, setPassword] = useState('');
  const [isOpen, setIsOpen] = useState(false);
  const [hasErrored, setHasErrored] = useState(false);
  const [errorMsg, setErrorMsg] = useState('');
  const history = useHistory();

  const handleError = (err: AxiosError<any>): void => {
    if (err.response?.status === UNAUTHORIZED) {
      history.push(LOGIN_URL);
      return;
    }
    alert(err.response?.data?.message || err.message);
  };

  const onSaveInfo = () =>
    updateUser({ name, email: mail, birth, phone })
      .catch(handleError)
      .finally(() => setIsEditInfo(false));

  const onCancelEdit = () => setIsEditInfo(false);

  const onPageChange = ({ selected }: { selected: number }) => setPage(selected + 1);
  const onClosePassword = () => {
    setIsOpen(false);
  };
  const onErrorWithPassword = (message: string) => {
    setHasErrored(true);
    setErrorMsg(message);
  };
  const onSubmitPassword = async () => {
    await sendPassword({ password })
      .then(() => {
        setIsOpen(false);
        setIsEditInfo(true);
      })
      .catch((err: any) => onErrorWithPassword(err.response?.data?.message || err.message))
      .finally(() => setPassword(''));
  };

  useEffect(() => {
    getUser()
      .then(({ user: { name, email, birth, phone } }) => {
        setName(name);
        setMail(email);
        setBirth(birth);
        setPhone(phone);
      })
      .catch(handleError);
  }, []);

  useEffect(() => {
    receiveLogs(page)
      .then((data: any) => {
        setLogs(data.result.rows);
        setMaxPage(Math.ceil(data.result.count / 6));
      })
      .catch((err: any) => {
        alert(`${err.response?.data?.message || err.message}`);
      });
  }, [page]);

  return (
    <Wrapper>
      <HeadingSection>마이페이지</HeadingSection>
      <TabWrapper>
        <Tabs onSelect={(index, lastIndex) => index !== lastIndex}>
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
              <MyInfo info={{ name, mail, birth, phone }} onEdit={() => setIsOpen(true)} />
            )}
            <PasswordModal
              password={password}
              setPassword={(e) => setPassword(e.target.value)}
              isOpen={isOpen}
              onSubmit={onSubmitPassword}
              onClose={onClosePassword}
              hasErrored={hasErrored}
              errorMsg={errorMsg}
            />
          </TabPanel>
          <TabPanel>
            <AccessLog
              logs={logs}
              setLogs={setLogs}
              page={page}
              maxPage={maxPage}
              onPageChange={onPageChange}
            />
          </TabPanel>
        </Tabs>
      </TabWrapper>
    </Wrapper>
  );
}

export { MyPageContainer };
