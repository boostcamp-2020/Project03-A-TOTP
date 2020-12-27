import React, { useState, memo, useCallback } from 'react';
import { AuthForm } from '@components/common/AuthForm';
import DefaultInput from '@components/common/Input/DefaultInput';
import { loginWithPassword, reSend } from '@api/index';
import { useGoogleReCaptcha } from 'react-google-recaptcha-v3';
import { useInput } from '@hooks/useInput';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

const TextWrapper = styled.div`
  text-align: center;
  margin-top: 4%;
  a {
    margin-left: 3%;
    color: ${({ theme }) => theme.color?.link};
  }
`;

interface LogInFormProps {
  onSuccess: (authToken: string) => any;
}

const LogInForm = memo(
  ({ onSuccess }: LogInFormProps): JSX.Element => {
    const { executeRecaptcha } = useGoogleReCaptcha();
    const [id, setId] = useInput('');
    const [password, setPassword] = useInput('');
    const [isSubmitting, setIsSubmitting] = useState(false);

    const onSubmit = useCallback(
      (e: React.FormEvent<HTMLFormElement>) => {
        setIsSubmitting(true);
        e.preventDefault();
        executeRecaptcha('LogInWithPassword')
          .then((reCaptchaToken: string) => loginWithPassword({ id, password, reCaptchaToken }))
          .then(({ authToken }: { authToken: string }) => onSuccess(authToken))
          .catch((err: any) => {
            if (err.response.status === 403) {
              if (window.confirm('이메일 미인증 사용자입니다. 다시 인증 메일을 보내시겠습니까?')) {
                reSend(id).then((data) => {
                  if (data.message === 'ok') {
                    alert('성공적으로 재 전송되었습니다.');
                  }
                });
              }
            }
          })
          .finally(() => setIsSubmitting(false));
      },
      [id, password],
    );

    const onChangeId = useCallback((id) => setId(id), []);

    const onChangePassword = useCallback((pw) => setPassword(pw), []);

    return (
      <AuthForm
        title='LOGIN'
        action='/api/auth'
        onSubmit={onSubmit}
        submitButtonText={isSubmitting ? '로그인 중' : '로그인'}
        disabled={isSubmitting}
      >
        <DefaultInput value={id} type='text' placeholder='ID' onChange={onChangeId} />
        <DefaultInput value={password} type='password' placeholder='Password' onChange={onChangePassword} />
        <TextWrapper>
          <span>계정이 없나요?</span>
          <span>
            <Link to='/signup'>회원가입</Link>
          </span>
        </TextWrapper>
        <TextWrapper>
          <Link to='/findId'>아이디찾기</Link>
          <Link to='/findPassword'>비밀번호찾기</Link>
        </TextWrapper>
      </AuthForm>
    );
  },
);

export { LogInForm };
