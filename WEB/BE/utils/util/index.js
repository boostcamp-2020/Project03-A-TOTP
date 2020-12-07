const createError = require('http-errors');

exports.catchErrors = (fn) => (req, res, next) => fn(req, res, next).catch((err) => next(createError(err)));
