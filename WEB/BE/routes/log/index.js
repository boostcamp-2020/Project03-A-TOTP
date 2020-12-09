const express = require('express');

const router = express.Router();
const logContoller = require('@controllers/log');
const { validator, reCAPTCHA, verifyJWT, sessionAuthentication } = require('@middlewares');
const { catchErrors } = require('@utils/util');

router.delete('/session', logContoller.delSession);

module.exports = router;
