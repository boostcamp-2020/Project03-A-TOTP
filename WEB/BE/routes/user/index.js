const express = require('express');

const router = express.Router();
const userController = require('@controllers/user');
const { validator } = require('@middlewares/validator');
const reCAPTCHA = require('@middlewares/reCaptcha');

router.post('/', reCAPTCHA.verify, validator.signUp, userController.signUp);
router.post('/dup-email', userController.dupEmail);
router.get('/confirm-email', userController.confirmEmail);
module.exports = router;
