import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';

const App = (): JSX.Element => {
  return (
    <BrowserRouter>
      <Switch>
        {/** @TODO component 추가 */}
        <Route exact path='/' />
      </Switch>
    </BrowserRouter>
  );
};

export { App };
