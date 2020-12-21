const createError = require('http-errors');

const sessionAuthentication = {
  sessionCheck(req, res, next) {
    const { CSRF_TOKEN } = req.session;
    const { csrfToken } = req.query;
    if (!req.session.user) {
      res.clearCookie('csrfToken');
      return next(createError(401, '로그아웃되어 권한이 없습니다.'));
    }
    // 주석처리하여 CSRF Attack 시도가능
    if (CSRF_TOKEN !== csrfToken) return next(createError(401, '잘못된 접근입니다.'));
    res.cookie('csrfToken', csrfToken, {
      maxAge: 2 * 60 * 60 * 1000,
    });
    return next();
  },

  sessionLogout(req, res, next) {
    req.session.destroy((err) => {
      if (err) {
        throw err;
      }
    });
    return next();
  },
};

module.exports = { sessionAuthentication };
