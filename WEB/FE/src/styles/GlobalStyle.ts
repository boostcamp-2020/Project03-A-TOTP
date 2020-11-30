import { css, createGlobalStyle } from 'styled-components';

export const resetCss = css`
  /* prettier-ignore */
  html, body, div, span, applet, object, iframe,
  h1, h2, h3, h4, h5, h6, p, blockquote, pre,
  a, abbr, acronym, address, big, cite, code,
  del, dfn, em, img, ins, kbd, q, s, samp,
  small, strike, strong, sub, sup, tt, var,
  b, u, i, center,
  dl, dt, dd, ol, ul, li,
  fieldset, form, label, legend,
  table, caption, tbody, tfoot, thead, tr, th, td,
  article, aside, canvas, details, embed, 
  figure, figcaption, footer, header, hgroup, 
  menu, nav, output, ruby, section, summary,
  time, mark, audio, video {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    vertical-align: baseline;
    box-sizing: border-box;
  }
  html,
  #app {
    width: 100%;
    height: 100%;
  }
  body {
    width: 100%;
    height: 100%;
    color: #333;
    font-size: 100%;
    font-weight: 200;
    line-height: 1.2;
    font-family: 'SpocaHanSans', -apple-system, BlinkMacSystemFont, 'Helvetica Neue', 'Apple SD Gothic Neo',
      'Malgun Gothic', '맑은 고딕', 나눔고딕, 'Nanum Gothic', 'Noto Sans KR', 'Noto Sans CJK KR', arial, 돋움,
      Dotum, Tahoma, Geneva, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    box-sizing: border-box;
  }
  * {
    box-sizing: inherit;
  }
  input,
  button,
  textarea {
    font-family: inherit;
  }
  /* prettier-ignore */
  article, aside, details, figcaption, figure, 
  footer, header, hgroup, menu, nav, section {
    display: block;
  }
  ol,
  ul {
    list-style: none;
  }
  blockquote,
  q {
    quotes: none;
  }
  /* prettier-ignore */
  blockquote:before, blockquote:after,
  q:before, q:after {
    content: '';
    content: none;
  }
  table {
    border-collapse: collapse;
    border-spacing: 0;
  }
  a {
    text-decoration: none;
    color: inherit;
  }
  a:link {
    text-decoration: none;
  }
  a:visited {
    text-decoration: none;
  }
  a:hover {
    text-decoration: none;
  }
  input {
    outline: 0;
  }
  button {
    outline: 0;
    cursor: pointer;
  }
`;

export const GlobalStyle = createGlobalStyle`
  ${resetCss}
`;
