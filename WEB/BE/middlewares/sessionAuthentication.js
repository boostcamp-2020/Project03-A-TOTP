const sessionAuthentication = {
  sessionCheck(req, res, next) {
    if (!req.session.key) {
      /**
       * @TODO
       * session이 없는 경우에 처리
       */
    } else {
      return next();
    }
  },

  sessionLogin(req, res, next) {
    if (req.session.key) {
      return next();
    }
    req.session.key = req.body.id;
    /**
     * @TODO
     * session key 만들어주기
     */
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
