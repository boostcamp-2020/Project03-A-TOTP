const express = require('express');
const router = express.Router();
const authController = require('@controllers/auth');

router.post('/dup-id', authController.dupId);
router.post('/', authController.logIn);
module.exports = router;
