const express = require('express');

const router = express.Router();
const userController = require('@controllers/iOS/user');

router.post('/email', userController.sendEmail);
router.post('/confirm-email', userController.verifyEmailCode);

router.use(userController.getUser);

module.exports = router;
