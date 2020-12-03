import axios, { Method } from 'axios';

axios.defaults.headers['X-CSRF'] = 'X-CSRF';

interface UserInfo {
  id: string;
  password: string;
  email: string;
  birth: string;
  name: string;
  phone: string;
  reCaptchaToken: string;
}

export const confirmEmailAPI = (query: string): void => {
  try {
    axios.get(`/api/user/confirm-email?user=${query}`);
  } catch (e) {
    /**
     * @TODO 처리 필요
     */
  }
};

export const checkIDDuplicateAPI = async (data: { id: string }): boolean => {
  try {
    const apiurl = `/api/auth/dup-id`;
    const res = await axios.post(apiurl, data);
    return res.data.result;
  } catch (e) {
    /**
     * @TODO 처리 필요
     */
  }
};

export const checkEmailDuplicateAPI = async (data: { email: string }): boolean => {
  try {
    const apiurl = `/api/user/dup-email`;
    const res = await axios.post(apiurl, data);
    return res.data.result;
  } catch (e) {
    /**
     * @TODO 처리 필요
     */
  }
};

export const registerUserAPI = async (data: UserInfo): string => {
  try {
    const apiurl = `/api/user/`;
    const res = await axios.post(apiurl, data);
    return res.data.url;
  } catch (e) {
    /**
     * @TODO 처리 필요
     */
  }
};

interface loginParams {
  id: string;
  password: string;
  reCaptchaToken: string;
}

export const loginWithPassword = async (params: loginParams): Promise<any> => {
  const { data } = await axios.post('/api/auth', params);
  return data;
};

interface loginWithOTPParams {
  authToken: string;
  totp: string;
  reCaptchaToken: string;
}

export const loginWithOTP = async (params: loginWithOTPParams): Promise<any> => {
  const { data } = await axios.put('/api/auth', params);
  return data;
};

interface findIdParams {
  email: string;
  name: string;
  birth: string;
  reCaptchaToken: string;
}

export const findId = async ({ email, name, birth, reCaptchaToken }: findIdParams): Promise<any> => {
  const { data } = await axios.post('/api/user/find-id', { email, name, birth, reCaptchaToken });
  return data;
};

interface option {
  method: Method;
  url: string;
  params: any;
  data: any;
}

export const changePass = async (query: string, password: string): Promise<any> => {
  const option: option = {
    method: 'PATCH',
    url: '/api/auth/password/email',
    params: query,
    data: {
      password,
    },
  };
  const { data } = await axios(option);
  return data;
};
