const express = require('express');
const router = express.Router();
const authController = require('@controllers/auth');

router.post('/check', authController.check);

module.exports = router;
