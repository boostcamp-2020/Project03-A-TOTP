import {
  UserInfo,
  loginWithPasswordParams,
  loginWithPasswordResponse,
  loginWithOTPParams,
  loginWithOTPResponse,
  findPasswordWithOTPParams,
  findIdParams,
  findPasswordParams,
  findPasswordReturn,
  getUserReturn,
  updateUserParmas,
  receiveLogsReturn,
  delSessionParmas,
  sendPasswordParams,
  sendSecretKeyEmailParams,
  reSendReturn,
} from '../types/apiType';
import axios from './config';

export const confirmEmailAPI = async (query: string): Promise<string> => {
  const { data } = await axios.get(`/api/user/confirm-email?user=${query}`);
  return data;
};

export const checkIDDuplicateAPI = async (params: string): Promise<boolean> => {
  const apiurl = `/api/auth/dup-id`;
  const { data } = await axios.post(apiurl, { id: params });
  return data.result;
};

export const checkEmailDuplicateAPI = async (params: string): Promise<boolean> => {
  const apiurl = `/api/user/dup-email`;
  const { data } = await axios.post(apiurl, { email: params });
  return data.result;
};

export const registerUserAPI = async (params: UserInfo): Promise<string> => {
  const apiurl = `/api/user/`;
  const { data } = await axios.post(apiurl, params);
  return data.url;
};

export const loginWithPassword = async (
  params: loginWithPasswordParams,
): Promise<loginWithPasswordResponse> => {
  const { data } = await axios.post('/api/auth', params);
  return data;
};

export const loginWithOTP = async (params: loginWithOTPParams): Promise<loginWithOTPResponse> => {
  const { data } = await axios.put('/api/auth', params);
  return data;
};

export const findPasswordWithOTP = async (params: findPasswordWithOTPParams): Promise<string> => {
  const { data } = await axios.put('/api/auth/password/email', params);
  return data;
};

export const findId = async (params: findIdParams): Promise<boolean> => {
  const { data } = await axios.post('/api/user/find-id', params);
  return data;
};

export const findPassword = async (params: findPasswordParams): Promise<findPasswordReturn> => {
  const { data } = await axios.post('/api/auth/password/email', params);
  return data;
};

export const changePass = async (query: string, password: string): Promise<string> => {
  const { data } = await axios.patch(`/api/auth/password/email?user=${query}`, { password });
  return data;
};

export const sendSecretKeyEmail = async (params: sendSecretKeyEmailParams): Promise<string> => {
  const { data } = await axios.put(`/api/auth/secret-key/email`, params);
  return data;
};

export const sendPassword = async (params: sendPasswordParams): Promise<boolean> => {
  const { data } = await axios.post(`api/auth/check-pw`, params);
  return data;
};

export const getUser = async (): Promise<getUserReturn> => {
  const { data } = await axios.get('api/user');
  return data;
};

export const updateUser = async (params: updateUserParmas): Promise<string> => {
  const { data } = await axios.patch('api/user', params);
  return data;
};

export const receiveLogs = async (num: number): Promise<receiveLogsReturn[]> => {
  const { data } = await axios.get(`api/log/${num}`);
  return data;
};

export const delSession = async (sid: delSessionParmas): Promise<boolean> => {
  const { data } = await axios.patch('api/log/session', sid);
  return data;
};

export const logoutAPI = async (): Promise<boolean> => {
  const { data } = await axios.get('api/auth/logout');
  return data;
};

export const reSend = async (id: string): Promise<reSendReturn> => {
  const { data } = await axios.post('api/user/reSend', { id });
  return data;
};
