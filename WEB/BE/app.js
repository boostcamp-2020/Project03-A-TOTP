require('module-alias/register');
const createError = require('http-errors');
const express = require('express');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const RedisStore = require('connect-redis')(session);
const logger = require('morgan');
const cors = require('cors');
const debug = require('debug')('server:server');
const authRouter = require('@routes/auth');
const userRouter = require('@routes/user');
const logRouter = require('@routes/log');
const csrf = require('@middlewares/csrf');
const redis = require('@models/redis');
const sequelizeWEB = require('@models/sequelizeIOS').sequelize;
const sequelizeIOS = require('@models/sequelizeWEB').sequelize;
const swaggerUi = require('swagger-ui-express');
const swaggerJSDoc = require('swagger-jsdoc');
const swaggerDefinition = require('@config/swagger');

require('dotenv').config();

const dev = process.env.NODE_ENV !== 'production';
const port = process.env.PORT || 3000;
const app = express();
redis.notifyEvent();
const corsOptions = {
  origin: 'http://dadaikseon.com/',
  optionsSuccessStatus: 200,
};
const sessionOptions = {
  store: new RedisStore({
    client: redis.client(),
    prefix: 'session:',
  }),
  saveUninitialized: false,
  resave: true,
  rolling: true,
  secret: process.env.SESSIONKEY,
  cookie: {
    maxAge: 7200000,
  },
};
const swaggerOptions = {
  swaggerDefinition,
  apis: ['./routes/**/*.js'],
};

// production 환경에서 추가 설정
if (!dev) {
  app.set('trust proxy', 1);
  sessionOptions.cookie.httpOnly = true;
  sessionOptions.cookie.sameSite = true;
  app.use(csrf.checkHeader);
}

sequelizeWEB.sync();
sequelizeIOS.sync();
app.use(logger(dev ? 'dev' : 'combined'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(dev ? cors() : cors(corsOptions));
app.use(session(sessionOptions));

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerJSDoc(swaggerOptions)));
app.use('/api/auth', authRouter);
app.use('/api/user', userRouter);
app.use('/api/log', logRouter);
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
