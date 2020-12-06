const express = require('express');

const router = express.Router();
const userController = require('@controllers/user');
const { validator } = require('@middlewares/validator');
const reCAPTCHA = require('@middlewares/reCAPTCHA');
const { catchErrors } = require('@utils/util');

router.post(
  '/',
  reCAPTCHA.verify,
  validator(['id', 'password', 'email', 'name', 'phone', 'birth']),
  catchErrors(userController.signUp)
);
router.post('/dup-email', catchErrors(userController.dupEmail));
router.get('/confirm-email', catchErrors(userController.confirmEmail));
router.post(
  '/find-id',
  reCAPTCHA.verify,
  validator(['email', 'name', 'birth']),
  catchErrors(userController.findID)
);
module.exports = router;
