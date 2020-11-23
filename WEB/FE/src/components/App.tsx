import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';

interface AppProps {}

const App: React.FC<AppProps> = () => {
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
