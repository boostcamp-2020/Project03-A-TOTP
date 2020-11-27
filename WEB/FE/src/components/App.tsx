import React from 'react';
import { BrowserRouter, Switch, Route, Link } from 'react-router-dom';
import * as Pages from '@pages/';
import { GoogleReCaptchaProvider } from 'react-google-recaptcha-v3';
import { ThemeProvider } from 'styled-components';
import { theme } from '../styles/theme';
import { PrivateRoute } from './route/PrivateRoute';
import ComfirmEmail from './confirmEmail/index';
import { Modal } from './common/Modal';

interface AppProps {}

const Hello = () => (
  <>
    <Modal>
      <Link to='/signup'>Sign Up</Link>
    </Modal>
  </>
);
const No = () => <>No</>;

const App: React.FC<AppProps> = () => {
  return (
    <GoogleReCaptchaProvider reCaptchaKey='6LcsnewZAAAAAOHzbLjkR4CvWRBNdibrcmtHd8SD' language='ko'>
      <ThemeProvider theme={theme}>
        <BrowserRouter>
          <Switch>
            {/** @TODO component 추가 */}
            <Route exact path='/' component={Hello} />
            <Route exact path='/confirm-email' component={ComfirmEmail} />
            <Route exact path='/signup' component={Pages.SignUpPage} />
            <Route exact path='/QRCode/:url' component={Pages.QRCodePage} />
            <PrivateRoute path='/user' component={No} />
          </Switch>
        </BrowserRouter>
      </ThemeProvider>
    </GoogleReCaptchaProvider>
  );
};

export { App };
