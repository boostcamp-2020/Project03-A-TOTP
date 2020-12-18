const { reCAPTCHA } = require('@middlewares/reCAPTCHA.js');
const { sessionAuthentication } = require('@middlewares/sessionAuthentication.js');
const { verifyJWT } = require('@middlewares/verifyJWT.js');
const { validator } = require('@middlewares/validator');

module.exports = { reCAPTCHA, sessionAuthentication, verifyJWT, validator };
