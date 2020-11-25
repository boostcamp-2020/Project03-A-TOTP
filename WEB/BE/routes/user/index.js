const express = require('express');
const router = express.Router();
const userController = require('@controllers/user');

router.post('/', userController.signUp);
router.post('/check', userController.check);

module.exports = router;
