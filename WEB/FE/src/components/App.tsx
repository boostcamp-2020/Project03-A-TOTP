import React from 'react';
import { BrowserRouter, Switch, Route, Link } from 'react-router-dom';
import * as Pages from '@pages/index';
import { PrivateRoute } from '@/components/PrivateRoute/PrivateRoute';
import ComfirmEmail from '@components/confirmEmail/index';
import Button from '@components/common/Button';
import TokenProvider from '@layouts/TokenContext';
import { Modal } from './common/Modal';

interface AppProps {}

const Hello = () => (
  <>
    <Modal>
      <Button text={<Link to='/signup'>Sign up</Link>} />
      <br />
      <br />
      <Button text={<Link to='/login'>Log in</Link>} />
      <br />
      <br />
      <Button text={<Link to='/findId'>Find ID</Link>} />
      <br />
      <br />
      <Button text={<Link to='/findPassword'>Find Password</Link>} />
      <br />
      <br />
    </Modal>
  </>
);

const App: React.FC<AppProps> = () => {
  return (
    <>
      <TokenProvider>
        <BrowserRouter>
          <Switch>
            <Route exact path='/' component={Hello} />
            <Route exact path='/confirm-email' component={ComfirmEmail} />
            <Route exact path='/signup' component={Pages.SignUpPage} />
            <Route exact path='/login' component={Pages.LogInPage} />
            <Route exact path='/QRCode/:url' component={Pages.QRCodePage} />
            <Route exact path='/findId' component={Pages.findIDPage} />
            <Route exact path='/findPassword' component={Pages.FindPasswordPage} />
            <Route exact path='/changePassword' component={Pages.ChangePasswordPage} />
            <Route component={Pages.NotFoundPage} />
          </Switch>
        </BrowserRouter>
      </TokenProvider>
    </>
  );
};

export { App };
