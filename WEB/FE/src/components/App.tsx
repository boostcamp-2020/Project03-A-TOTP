import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import * as Pages from '../pages';
import { PrivateRoute } from './route/PrivateRoute';

interface AppProps {}

const Hello = () => <>Hello</>;
const No = () => <>No</>;

const App: React.FC<AppProps> = () => {
  return (
    <BrowserRouter>
      <Switch>
        {/** @TODO component 추가 */}
        <Route exact path='/' component={Hello} />
        <Route exact path='/signup' component={Pages.SignUpPage} />
        <PrivateRoute path='/user' component={No} />
      </Switch>
    </BrowserRouter>
  );
};

export { App };
