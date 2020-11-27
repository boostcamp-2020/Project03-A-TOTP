import React from 'react';
import ReactDOM from 'react-dom';
import { App } from '@/components/App';
import { GoogleReCaptchaProvider } from 'react-google-recaptcha-v3';
import { ThemeProvider } from 'styled-components';
import { GlobalStyle } from '@styles/GlobalStyle';
import { theme } from '@styles/theme';

ReactDOM.render(
  <React.StrictMode>
    <GoogleReCaptchaProvider reCaptchaKey='6LcsnewZAAAAAOHzbLjkR4CvWRBNdibrcmtHd8SD' language='ko'>
      <ThemeProvider theme={theme}>
        <GlobalStyle />
        <App />
      </ThemeProvider>
    </GoogleReCaptchaProvider>
  </React.StrictMode>,
  document.getElementById('app'),
);
