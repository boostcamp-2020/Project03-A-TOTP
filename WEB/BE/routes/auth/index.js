const express = require('express');

const router = express.Router();
const authController = require('@controllers/auth');
const { validator } = require('@middlewares/validator');
const reCAPTCHA = require('@middlewares/reCaptcha');
const { verifyJWT } = require('@middlewares/verifyJWT');

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

module.exports = router;
