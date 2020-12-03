const express = require('express');

const router = express.Router();
const authController = require('@controllers/auth');
const { validator } = require('@middlewares/validator');
const reCAPTCHA = require('@middlewares/reCaptcha');

router.post('/dup-id', authController.dupId);
router.post('/', reCAPTCHA.verify, validator(['id', 'password']), authController.logIn);
router
  .route('/password/email')
  .post(reCAPTCHA.verify, validator(['id', 'name', 'birth']), authController.sendPasswordToken)
  .put(reCAPTCHA.verify, authController.sendPasswordEmail);

module.exports = router;
