require('dotenv').config();
const bcrypt = require('bcrypt');

const saltRounds = Number(process.env.SALTROUNDS);

const getEncryptedPassword = (password) => {
  return new Promise((resolve, reject) => {
    bcrypt.hash(password, saltRounds, (err, hash) => {
      if (err) reject(err);
      resolve(hash);
    });
  });
};

const comparePassword = (password, DBpw) => {
  return new Promise((resolve, reject) => {
    bcrypt.compare(password, DBpw, (err, result) => {
      if (err) reject(err);
      resolve(result);
    });
  });
};

module.exports = { getEncryptedPassword, comparePassword };
