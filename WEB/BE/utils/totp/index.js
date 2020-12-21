const crypto = require('crypto');
const base32 = require('hi-base32');
const { createHmac } = require('@utils/totp/hmac');

const totp = {
  makeSecretKey(length = 20) {
    const bytes = crypto.randomBytes(length || 32);
    const set = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz';
    let output = '';
    for (let i = 0, l = bytes.length; i < l; i++) {
      output += set[Math.floor((bytes[i] / 255.0) * (set.length - 1))];
    }
    return base32.encode(output).replace(/=/g, '');
  },

  makeURL({ secretKey, email }) {
    return `otpauth://totp/${process.env.SECRETKEYLABEL}?secret=${secretKey}&issuer=${email}`;
  },

  verifyDigits(key, digits, date = new Date()) {
    key = base32.decode(key);
    const sixDigits = makeSixDigits(key, date);
    if (digits !== sixDigits) {
      const seSixDigits = makeSixDigits(key, date, -1);
      return digits === seSixDigits;
    }
    return digits === sixDigits;
  },
};

const makeSixDigits = (key, date, window = 0) => {
  const timeStamp = makeTimeStamp(date, window);
  const timeBuffer = makeBuffer(timeStamp);
  const hash = createHmac({ key, data: timeBuffer, algorithm: 'sha1', encoding: 'hex' });
  const DBC = selectDBC(hash);
  const sixDigits = (parseInt(DBC, 16) % 1000000).toString();

  return sixDigits.padStart(6, '0');
};

const makeTimeStamp = (date, window) => {
  return Math.floor(new Date(date) / 30000) + window;
};

const makeBuffer = (timeStamp) => {
  const buffer = Buffer.alloc(8);
  for (let i = 0; i < 8; i++) {
    buffer[7 - i] = timeStamp & 0xff;
    timeStamp >>= 8;
  }
  return buffer;
};

const selectDBC = (hash) => {
  const offset = parseInt(`${hash.charAt(hash.length - 1)}`, 16);
  let DBC = hash.slice(offset * 2, offset * 2 + 8);
  const firstByte = (0x7f & parseInt(DBC.slice(0, 2), 16)).toString(16);
  DBC = firstByte + DBC.slice(2);
  return DBC;
};

module.exports = totp;
