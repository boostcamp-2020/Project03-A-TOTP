import React from 'react';
import ReactDOM from 'react-dom';
import { App } from '@components/App';
import { GlobalStyle } from './styles/GlobalStyle';

ReactDOM.render(
  <React.StrictMode>
    <GlobalStyle />
    <App />
  </React.StrictMode>,
  document.getElementById('app'),
);
