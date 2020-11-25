const express = require('express');
const router = express.Router();
const userController = require('@controllers/user');

router.post('/', userController.signUp);
router.post('/dup-email', userController.dupEmail);

module.exports = router;
