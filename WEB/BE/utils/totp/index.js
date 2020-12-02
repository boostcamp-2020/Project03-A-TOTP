const crypto = require('crypto');
const speakeasy = require('speakeasy');

const totp = {
  makeSecretKey() {
    const secretKey = speakeasy.generateSecret({
      length: 20,
      name: process.env.SECRETKEYNAME,
      algorithm: process.env.SECRETKEYALGORITHM,
    });
    return secretKey;
  },
};

module.exports = totp;
