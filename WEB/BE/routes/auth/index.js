const express = require('express');

const router = express.Router();
const authController = require('@controllers/auth');
const { validator } = require('@middlewares/validator');
const reCAPTCHA = require('@middlewares/reCAPTCHA');
const { verifyJWT } = require('@middlewares/verifyJWT');
const { catchErrors } = require('@utils/util');

router.post('/dup-id', catchErrors(authController.dupId));
router
  .route('/')
  .post(reCAPTCHA.verify, validator(['id', 'password']), catchErrors(authController.logIn))
  .put(verifyJWT.verifyTOTP, catchErrors(authController.logInSuccess));
router
  .route('/password/email')
  .post(reCAPTCHA.verify, validator(['id', 'name', 'birth']), catchErrors(authController.sendPasswordToken))
  .put(reCAPTCHA.verify, verifyJWT.verifyTOTP, catchErrors(authController.sendPasswordEmail))
  .patch(validator(['password']), catchErrors(authController.changePassword));

module.exports = router;
