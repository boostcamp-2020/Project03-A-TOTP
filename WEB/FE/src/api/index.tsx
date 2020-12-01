import axios from 'axios';

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

export const login = async ({ id, password, reCaptchaToken }: loginParams): Promise<any> => {
  const { data } = await axios.post('/api/auth', { id, password, reCaptchaToken });
  return data;
};
