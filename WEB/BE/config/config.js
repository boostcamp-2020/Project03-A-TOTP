const dotenv = require('dotenv').config();

module.exports = {
  WEB: {
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
  },
  iOS: {
    development: {
      username: process.env.DBUSER,
      password: process.env.DBPASS,
      database: process.env.DBDATABASEIOS,
      host: process.env.DBHOST,
      dialect: 'mysql',
    },
    test: {
      username: process.env.DBUSER,
      password: process.env.DBPASS,
      database: process.env.DBDATABASEIOS,
      host: process.env.DBHOST,
      dialect: 'mysql',
    },
    production: {
      username: process.env.DBUSER,
      password: process.env.DBPASS,
      database: process.env.DBDATABASEIOS,
      host: process.env.DBHOST,
      dialect: 'mysql',
    },
  },
};
