import React from 'react';
import ReactDOM from 'react-dom';
import '@styles/typography.css';
import '@static/favicon.ico';
import { App } from '@/components/App';
import { GoogleReCaptchaProvider } from 'react-google-recaptcha-v3';
import { ThemeProvider } from 'styled-components';
import { GlobalStyle } from '@styles/GlobalStyle';
import { theme } from '@styles/theme';
import { Helmet } from 'react-helmet';

ReactDOM.render(
  <>
    <Helmet>
      <title>다다익선</title>
      <meta name='description' content='더 안전한 TOTP 서비스. 다다익선에서 시작하세요.' />
    </Helmet>
    <React.StrictMode>
      <GoogleReCaptchaProvider reCaptchaKey='6LcsnewZAAAAAOHzbLjkR4CvWRBNdibrcmtHd8SD' language='ko'>
        <ThemeProvider theme={theme}>
          <GlobalStyle />
          <App />
        </ThemeProvider>
      </GoogleReCaptchaProvider>
    </React.StrictMode>
  </>,
  document.getElementById('app'),
);
