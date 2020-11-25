import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import { GoogleReCaptchaProvider } from 'react-google-recaptcha-v3';
import { PrivateRoute } from './route/PrivateRoute';

interface AppProps {}

const Hello = () => <>Hello</>;
const No = () => <>No</>;

const App: React.FC<AppProps> = () => {
  return (
    <GoogleReCaptchaProvider reCaptchaKey='6LcsnewZAAAAAOHzbLjkR4CvWRBNdibrcmtHd8SD' language='ko'>
      <BrowserRouter>
        <Switch>
          {/** @TODO component 추가 */}
          <Route exact path='/' component={Hello} />
          <PrivateRoute path='/user' component={No} />
        </Switch>
      </BrowserRouter>
    </GoogleReCaptchaProvider>
  );
};

export { App };
