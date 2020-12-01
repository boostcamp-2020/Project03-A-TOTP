const express = require('express');

const router = express.Router();
const userController = require('@controllers/user');
const { validator } = require('@middlewares/validator');
const reCAPTCHA = require('@middlewares/reCAPTCHA');

router.post(
  '/',
  reCAPTCHA.verify,
  validator(['id', 'password', 'email', 'name', 'phone', 'birth']),
  userController.signUp
);
router.post('/dup-email', userController.dupEmail);
router.get('/confirm-email', userController.confirmEmail);
module.exports = router;
