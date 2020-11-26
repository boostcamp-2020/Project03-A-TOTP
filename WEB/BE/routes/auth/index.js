const express = require('express');
const router = express.Router();
const authController = require('@controllers/auth');
const { validator } = require('@middlewares/validator');

router.post('/dup-id', authController.dupId);
router.post('/', validator.logIn, authController.logIn);
module.exports = router;
