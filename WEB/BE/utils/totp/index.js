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

  makeURL({ secretKey, email }) {
    return `otpauth://totp/${process.env.SECRETKEYLABEL}?secret=${secretKey}&issuer=${email}`;
  },
};

module.exports = totp;
