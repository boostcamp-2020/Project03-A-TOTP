const createError = require('http-errors');

const csrf = {
  checkHeader(req, res, next) {
    // custom header
    const csrfHeader = req.headers['X-CSRF'] || req.headers['x-csrf'];

    // origin header
    const originHeader = req.headers.origin;
    const isValidOrigin = originHeader && /^(http|https):\/\/dadaikseon\.com/.test(originHeader);

    // referrer header
    const referrerHeader = req.headers.referer;
    const isValidReferrer = referrerHeader && /^(http|https):\/\/dadaikseon\.com/.test(originHeader);

    if (!csrfHeader || (!isValidOrigin && !isValidReferrer)) {
      return next(createError(401));
    }

    return next();
  },
};

module.exports = csrf;
