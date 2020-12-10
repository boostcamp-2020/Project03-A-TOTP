import React from 'react';
import { Redirect, Route, RouteProps } from 'react-router-dom';

interface PrivateRouteProps extends RouteProps {}

const PrivateRoute: React.FC<PrivateRouteProps> = (props) => {
  const isAuthenticated = localStorage.user;

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
