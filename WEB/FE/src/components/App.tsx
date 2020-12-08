import React from 'react';
import { BrowserRouter, Switch, Route, Link } from 'react-router-dom';
import * as Pages from '@pages/index';
import { PrivateRoute } from '@/components/PrivateRoute/PrivateRoute';
import ComfirmEmail from '@components/confirmEmail/index';
import Button from '@components/common/Button';
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
      <Button text={<Link to='/findPassword'>Find Password?</Link>} />
      <br />
      <br />
    </Modal>
  </>
);

const App: React.FC<AppProps> = () => {
  return (
    <>
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
          <PrivateRoute path='/me' component={Pages.MyPage} />
          <Route component={Pages.NotFoundPage} />
        </Switch>
      </BrowserRouter>
    </>
  );
};

export { App };
