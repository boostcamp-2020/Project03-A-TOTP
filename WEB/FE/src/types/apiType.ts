export interface UserInfo {
  id: string;
  password: string;
  email: string;
  birth: string;
  name: string;
  phone: string;
  reCaptchaToken: string;
}

export interface loginWithPasswordParams {
  id: string;
  password: string;
  reCaptchaToken: string;
}

export interface loginWithPasswordResponse {
  authToken: string;
}

export interface loginWithOTPParams {
  authToken: string;
  totp: string;
  reCaptchaToken: string;
}

export interface loginWithOTPResponse {
  userName: string;
}

export interface findPasswordWithOTPParams {
  authToken: string;
  totp: string;
  reCaptchaToken: string;
}

export interface findIdParams {
  email: string;
  name: string;
  birth: string;
  reCaptchaToken: string;
}

export interface findPasswordParams {
  id: string;
  name: string;
  birth: string;
  reCaptchaToken: string;
}

export interface findPasswordReturn {
  message: string;
  authToken: string;
}

/// ////////////////////
export interface getUserReturn {
  user: {
    birth: string;
    email: string;
    name: string;
    phone: string;
  };
}

export interface updateUserParmas {
  name?: string;
  email?: string;
  phone?: string;
  birth?: string;
}

export interface receiveLogsReturn {
  key: string;
  time: string;
  device: string;
  ip: string;
  location: string;
  isLoggedOut: boolean;
  sessionId: string | undefined;
}

export interface delSessionParmas {
  sid?: string;
}

export interface sendPasswordParams {
  password: string;
}

export interface sendSecretKeyEmailParams {
  authToken: string;
  reCaptchaToken: string;
}
