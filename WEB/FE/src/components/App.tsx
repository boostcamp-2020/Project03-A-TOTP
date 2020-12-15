import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import * as Pages from '@pages/index';
import { PrivateRoute } from '@/components/PrivateRoute/PrivateRoute';
import ComfirmEmail from '@components/confirmEmail/index';

interface AppProps {}

const App: React.FC<AppProps> = () => {
  return (
    <>
      <BrowserRouter>
        <Switch>
          <Route exact path='/' component={Pages.IndexPage} />
          <Route exact path='/login' component={Pages.LogInPage} />
          <Route exact path='/confirm-email' component={ComfirmEmail} />
          <Route exact path='/signup' component={Pages.SignUpPage} />
          <Route exact path='/QRCode/:url' component={Pages.QRCodePage} />
          <Route exact path='/findId' component={Pages.findIDPage} />
          <Route exact path='/findPassword' component={Pages.FindPasswordPage} />
          <Route exact path='/changePassword' component={Pages.ChangePasswordPage} />
          <Route exact path='/why-2fa' component={Pages.Why2FAPage} />
          <Route exact path='/totp-intro' component={Pages.TOTPIntroPage} />
          <Route exact path='/study' component={Pages.StudyPage} />
          <PrivateRoute exact path='/me' component={Pages.MyPage} />
          <Route component={Pages.NotFoundPage} />
        </Switch>
      </BrowserRouter>
    </>
  );
};

export { App };
