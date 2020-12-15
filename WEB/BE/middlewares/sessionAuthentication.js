const createError = require('http-errors');

const sessionAuthentication = {
  sessionCheck(req, res, next) {
    const { CSRF_TOKEN } = req.session;
    const { csrfToken } = req.query;
    if (!req.session.user && CSRF_TOKEN !== csrfToken) {
      res.clearCookie('csrfToken');
      return next(createError(401, '로그아웃되어 권한이 없습니다.'));
    }
    console.log(req.session);
    console.log(req.query);
    res.cookie('csrfToken', csrfToken, {
      maxAge: 2 * 60 * 60 * 1000,
    });
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
