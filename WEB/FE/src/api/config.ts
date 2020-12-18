import axios, { AxiosRequestConfig } from 'axios';
import storageHandler from '@utils/localStorage';

const fillterCode = [403, 488];

const Axios = axios.create({
  headers: { 'X-CSRF': 'X-CSRF' },
});

Axios.interceptors.request.use((value: AxiosRequestConfig) => {
  const config = value;
  config.params = {
    csrfToken: document.cookie.split('csrfToken=')[1],
    ...config.params,
  };
  return config;
});

Axios.interceptors.response.use(
  (response) => response,
  (error) => {
    if (!fillterCode.includes(error.response.status))
      alert(`${error.response?.data?.message || error.message}`);
    if (error.response.status === 401) {
      storageHandler.clear();
      window.location.reload();
    }
    return Promise.reject(error);
  },
);

export default Axios;
