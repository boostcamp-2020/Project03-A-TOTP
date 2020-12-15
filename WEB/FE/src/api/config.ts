import axios, { AxiosRequestConfig } from 'axios';

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

export default Axios;
