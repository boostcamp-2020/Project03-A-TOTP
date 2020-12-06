const express = require('express');

const router = express.Router();
const userController = require('@controllers/user');
const { validator, reCAPTCHA, sessionAuthentication } = require('@middlewares');

router.post(
  '/',
  reCAPTCHA.verify,
  validator(['id', 'password', 'email', 'name', 'phone', 'birth']),
  userController.signUp
);
router.post('/dup-email', userController.dupEmail);
router.get('/confirm-email', userController.confirmEmail);
router.post('/find-id', reCAPTCHA.verify, validator(['email', 'name', 'birth']), userController.findID);

router.use(sessionAuthentication.sessionCheck);

module.exports = router;
