const dotenv = require('dotenv').config();

module.exports = {
  development: {
    username: process.env.DBUSER,
    password: process.env.DBPASS,
    database: process.env.DBDATABASEWEB,
    host: process.env.DBHOST,
    dialect: 'mysql',
  },
  test: {
    username: process.env.DBUSER,
    password: process.env.DBPASS,
    database: process.env.DBDATABASEWEB,
    host: process.env.DBHOST,
    dialect: 'mysql',
  },
  production: {
    username: process.env.DBUSER,
    password: process.env.DBPASS,
    database: process.env.DBDATABASEWEB,
    host: process.env.DBHOST,
    dialect: 'mysql',
  },
  WEB: {
    development: {
      username: process.env.DBUSER,
      password: process.env.DBPASS,
      database: process.env.DBDATABASEWEB,
      host: process.env.DBHOST,
      logging: false,
      dialect: 'mysql',
    },
    test: {
      username: process.env.DBUSER,
      password: process.env.DBPASS,
      database: process.env.DBDATABASEWEB,
      host: process.env.DBHOST,
      dialect: 'mysql',
    },
    production: {
      username: process.env.DBUSER,
      password: process.env.DBPASS,
      database: process.env.DBDATABASEWEB,
      host: process.env.DBHOST,
      logging: false,
      dialect: 'mysql',
    },
  },
  iOS: {
    development: {
      username: process.env.DBUSER,
      password: process.env.DBPASS,
      database: process.env.DBDATABASEiOS,
      host: process.env.DBHOST,
      logging: false,
      dialect: 'mysql',
    },
    test: {
      username: process.env.DBUSER,
      password: process.env.DBPASS,
      database: process.env.DBDATABASEiOS,
      host: process.env.DBHOST,
      dialect: 'mysql',
    },
    production: {
      username: process.env.DBUSER,
      password: process.env.DBPASS,
      database: process.env.DBDATABASEiOS,
      host: process.env.DBHOST,
      logging: false,
      dialect: 'mysql',
    },
  },
};
