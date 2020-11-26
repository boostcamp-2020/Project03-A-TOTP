require('module-alias/register');
const createError = require('http-errors');
const express = require('express');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const cors = require('cors');
const debug = require('debug')('server:server');
const sequelizeWEB = require('./models/sequelizeIOS').sequelize;
const sequelizeIOS = require('./models/sequelizeWEB').sequelize;
const authRouter = require('@routes/auth');
const userRouter = require('@routes/user');

require('dotenv').config();

const dev = process.env.NODE_ENV !== 'production';
const port = process.env.PORT || 3000;
const app = express();
const corsOptions = {
  origin: 'http://dadaikseon.com/',
  optionsSuccessStatus: 200,
};

sequelizeWEB.sync();
sequelizeIOS.sync();
app.use(logger(dev ? 'dev' : 'combined'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(dev ? cors() : cors(corsOptions));

app.use('/api/auth', authRouter);
app.use('/api/user', userRouter);

// handle 404
app.use((req, res, next) => {
  next(createError(404));
});

// error handler
app.use((err, req, res, next) => {
  const { status, message } = err;
  res.locals.message = message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  console.error(message);
  res.status(status || 500).json({
    message,
  });
});

app.listen(port, (err) => {
  if (err) throw err;
  debug(`Listening on ${port}`);
});

module.exports = app;
