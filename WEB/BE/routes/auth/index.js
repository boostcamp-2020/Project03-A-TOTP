const express = require('express');

const router = express.Router();
const authController = require('@controllers/auth');
const { validator } = require('@middlewares/validator');
const reCAPTCHA = require('@middlewares/reCaptcha');

router.post('/dup-id', authController.dupId);
router.post('/', reCAPTCHA.verify, validator.logIn, authController.logIn);
module.exports = router;
