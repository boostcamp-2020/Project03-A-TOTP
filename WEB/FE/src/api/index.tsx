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
  axios.get(`/api/user/confirm-email?user=${query}`);
};

export const checkIDDuplicateAPI = async ({ id }: { id: string }): Promise<boolean> => {
  const apiurl = `/api/auth/dup-id`;
  const { data } = await axios.post(apiurl, { id });
  return data.result;
};

export const checkEmailDuplicateAPI = async ({ email }: { email: string }): Promise<boolean> => {
  const apiurl = `/api/user/dup-email`;
  const { data } = await axios.post(apiurl, { email });
  return data.result;
};

export const registerUserAPI = async (params: UserInfo): Promise<string> => {
  const apiurl = `/api/user/`;
  const { data } = await axios.post(apiurl, params);
  return data.url;
};

interface loginWithPasswordParams {
  id: string;
  password: string;
  reCaptchaToken: string;
}

interface loginWithPasswordResponse {
  authToken: string;
}

export const loginWithPassword = async (
  params: loginWithPasswordParams,
): Promise<loginWithPasswordResponse> => {
  const { data } = await axios.post('/api/auth', params);
  return data;
};

interface loginWithOTPParams {
  authToken: string;
  totp: string;
  reCaptchaToken: string;
}

interface loginWithOTPResponse {
  result: boolean;
}

export const loginWithOTP = async (params: loginWithOTPParams): Promise<loginWithOTPResponse> => {
  const { data } = await axios.put('/api/auth', params);
  return data;
};

interface findPasswordWithOTPParams {
  authToken: string;
  totp: string;
  reCaptchaToken: string;
}

export const findPasswordWithOTP = async (params: findPasswordWithOTPParams): Promise<any> => {
  const { data } = await axios.put('/api/auth/password/email', params);
  return data;
};

interface findIdParams {
  email: string;
  name: string;
  birth: string;
  reCaptchaToken: string;
}

export const findId = async (params: findIdParams): Promise<any> => {
  const { data } = await axios.post('/api/user/find-id', params);
  return data;
};

interface findPasswordParams {
  id: string;
  name: string;
  birth: string;
  reCaptchaToken: string;
}

export const findPassword = async (params: findPasswordParams): Promise<any> => {
  const { data } = await axios.post('/api/auth/password/email', params);
  return data;
};

export const changePass = async (query: string, password: string): Promise<any> => {
  const { data } = await axios.patch(`/api/auth/password/email?user=${query}`, { password });
  return data;
};

interface sendSecretKeyEmailParams {
  authToken: string;
  reCaptchaToken: string;
}

export const sendSecretKeyEmail = async (params: sendSecretKeyEmailParams): Promise<any> => {
  const { data } = await axios.put(`/api/auth/secret-key/email`, params);
  return data;
};

interface sendPasswordParams {
  password: string;
}

// MyPage에서 비밀번호 입력하여 확인할 때 사용
export const sendPassword = async (params: sendPasswordParams): Promise<any> => {
  const { data } = await axios.post(`api/auth/check-pw`, params);
  return data;
};

export const getUser = async (): Promise<any> => {
  const { data } = await axios.get('api/user');
  return data;
};

interface updateUserParmas {
  name?: string;
  email?: string;
  phone?: string;
  birth?: string;
}

export const updateUser = async (params: updateUserParmas): Promise<any> => {
  const { data } = await axios.patch('api/user', params);
  return data;
};

export const receiveLogs = async (num: number): Promise<any> => {
  const { data } = await axios.get(`api/log/${num}`);
  return data;
};
