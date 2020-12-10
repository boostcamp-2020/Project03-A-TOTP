import React from 'react';
import { Redirect, Route, RouteProps } from 'react-router-dom';
import storageHandler from '@utils/localStorage';

interface PrivateRouteProps extends RouteProps {}

const PrivateRoute: React.FC<PrivateRouteProps> = (props) => {
  const isAuthenticated = storageHandler.get();

  return isAuthenticated ? (
    <Route {...props} />
  ) : (
    <Route
      {...props}
      component={undefined}
      render={({ location }) => (
        <Redirect
          to={{
            pathname: '/login',
            state: { from: location },
          }}
        />
      )}
    />
  );
};

export { PrivateRoute };
