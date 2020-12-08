const createError = require('http-errors');

const sessionAuthentication = {
  sessionCheck(req, res, next) {
    const { csrfToken } = req.body;
    // if (!req.session.key && req.session.CSRF_TOKEN !== CSRFTOKEN) {
    if (!req.session.key) {
      return next(createError(401, '권한이 없습니다'));
    }

    return next();
  },

  sessionLogout(req, res, next) {
    // key 유무 확인을 먼저 해야하나?????
    req.session.destroy((err) => {
      if (err) {
        throw err;
      }
    });
    return next();
  },
};

module.exports = { sessionAuthentication };
