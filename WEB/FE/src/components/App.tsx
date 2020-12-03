import React from 'react';
import { BrowserRouter, Switch, Route, Link } from 'react-router-dom';
import * as Pages from '@pages/index';
import { PrivateRoute } from '@/components/PrivateRoute/PrivateRoute';
import ComfirmEmail from '@components/confirmEmail/index';
import { Modal } from './common/Modal';

interface AppProps {}

const Hello = () => (
  <>
    <Modal>
      <Link to='/signup'>Sign Up</Link>
    </Modal>
  </>
);

const App: React.FC<AppProps> = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path='/' component={Hello} />
        <Route exact path='/confirm-email' component={ComfirmEmail} />
        <Route exact path='/signup' component={Pages.SignUpPage} />
        <Route exact path='/login' component={Pages.LogInPage} />
        <Route exact path='/QRCode/:url' component={Pages.QRCodePage} />
        <Route exact path='/findId' component={Pages.findIDPage} />
        <Route component={Pages.NotFoundPage} />
      </Switch>
    </BrowserRouter>
  );
};

export { App };
