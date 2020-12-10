const express = require('express');

const router = express.Router();
const userRouter = require('@routes/iOS/user');
const tokenRouter = require('@routes/iOS/token');

router.use('/user', userRouter);
router.use('/token', tokenRouter);

module.exports = router;
