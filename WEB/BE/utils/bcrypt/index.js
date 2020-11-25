require('dotenv').config();
const bcrypt = require('bcrypt');
const saltRounds = Number(process.env.SALTROUNDS);

const encryptedPassword = (password) => {
  return new Promise((resolve, reject) => {
    bcrypt.hash(password, saltRounds, (err, hash) => {
      resolve(hash);
    });
  });
};

const comparePassword = (password, DBpw) => {
  return new Promise((resolve, reject) => {
    bcrypt.compare(password, DBpw, (err, result) => {
      resolve(result);
    });
  });
};

module.exports = { encryptedPassword, comparePassword };
