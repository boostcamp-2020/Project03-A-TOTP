const crypto = require('crypto');
const base32 = require('hi-base32');

const totp = {
  makeSecretKey(length = 20) {
    const secretKey = crypto.randomBytes(length);
    return base32.encode(secretKey).replace(/=/g, '');
  },

  makeURL({ secretKey, email }) {
    return `otpauth://totp/${process.env.SECRETKEYLABEL}?secret=${secretKey}&issuer=${email}`;
  },

  verifyDigits(key, digits, date = new Date()) {
    const sixDigits = makeSixDigits(key, date);
    return digits === sixDigits;
  },
};

const makeSixDigits = (key, date) => {
  const timeStmap = makeTimeStamp(date);
};

const makeTimeStamp = (date, window = 0) => {
  return Math.floor(new Date(date) / 30000) + window;
};

module.exports = totp;
