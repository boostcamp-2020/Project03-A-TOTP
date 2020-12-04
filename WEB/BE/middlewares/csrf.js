const createError = require('http-errors');

const dev = process.env.NODE_ENV !== 'production';
const CUSTOM_CSRF_HEADER = 'X-CSRF';
const ORIGIN_HEADER_REGEX = dev ? /^http:\/\/localhost:8080/ : /^https:\/\/dadaikseon\.com/;
const UNAUTHORIZED = 401;
const CSRF_ERROR_MSG = 'CSRF Attack!';

const csrf = {
  checkHeader(req, res, next) {
    const csrfHeader = req.headers[CUSTOM_CSRF_HEADER] || req.headers[CUSTOM_CSRF_HEADER.toLocaleLowerCase()];

    const originHeader = req.headers.origin;
    const isValidOrigin = originHeader && ORIGIN_HEADER_REGEX.test(originHeader);

    const refererHeader = req.headers.referer;
    const isValidReferrer = refererHeader && ORIGIN_HEADER_REGEX.test(refererHeader);

    if (!csrfHeader || (!isValidOrigin && !isValidReferrer)) {
      return next(createError(UNAUTHORIZED, CSRF_ERROR_MSG));
    }

    return next();
  },
};

module.exports = csrf;
