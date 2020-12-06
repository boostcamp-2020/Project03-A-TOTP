const express = require('express');

const router = express.Router();
const authController = require('@controllers/auth');
const { validator, reCAPTCHA, verifyJWT, sessionAuthentication } = require('@middlewares');

router.post('/dup-id', authController.dupId);
router
  .route('/')
  .post(reCAPTCHA.verify, validator(['id', 'password']), authController.logIn)
  .put(verifyJWT.verifyTOTP, authController.logInSuccess);
router
  .route('/password/email')
  .post(reCAPTCHA.verify, validator(['id', 'name', 'birth']), authController.sendPasswordToken)
  .put(reCAPTCHA.verify, verifyJWT.verifyTOTP, authController.sendPasswordEmail)
  .patch(validator(['password']), authController.changePassword);

router.use(sessionAuthentication.sessionCheck);

module.exports = router;
