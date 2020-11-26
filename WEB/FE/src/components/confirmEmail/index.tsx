import React from 'react';
import qs from 'qs';
import { RouteComponentProps, Redirect } from 'react-router-dom';
import { confirmEmailAPI } from '../../api/index';

interface PathParamsProps {
  id: string;
}

const ComfirmEmail: React.FC<RouteComponentProps<PathParamsProps>> = ({ location }) => {
  const { search } = location;
  if (!search) {
    return <Redirect to='/' />;
  }
  const userData = qs.parse(search, {
    ignoreQueryPrefix: true,
  });
  const queryStr: string = userData.user!.toString();
  confirmEmailAPI(encodeURIComponent(queryStr));
  return <Redirect to='/' />;
};

export default ComfirmEmail;
