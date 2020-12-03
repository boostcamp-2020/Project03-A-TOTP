import React from 'react';
import { Redirect, Route, RouteProps } from 'react-router-dom';

interface PrivateRouteProps extends RouteProps {}

const PrivateRoute: React.FC<PrivateRouteProps> = (props) => {
  /** @TODO 로그인 조건 추가 */
  const isAuthenticated = false;

  return isAuthenticated ? (
    <Route {...props} />
  ) : (
    <Route
      {...props}
      component={undefined}
      render={({ location }) => (
        <Redirect
          to={{
            pathname: '/',
            state: { from: location },
          }}
        />
      )}
    />
  );
};

export { PrivateRoute };
