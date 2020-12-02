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
    key = base32.decode(key);
    const sixDigits = makeSixDigits(key, date);
    return digits === sixDigits;
  },
};

const makeSixDigits = (key, date) => {
  const timeStmap = makeTimeStamp(date);
  const buffer = makeBuffer(timeStmap);
  const hash = crypto.createHmac('sha1', key).update(buffer).digest('hex');
  const DBC = selectDBC(hash);
};

const makeTimeStamp = (date, window = 0) => {
  return Math.floor(new Date(date) / 30000) + window;
};

const makeBuffer = (timeStmap) => {
  const buffer = Buffer.alloc(8);
  for (let i = 0; i < 8; i++) {
    buffer[7 - i] = timeStmap & 0xff;
    timeStmap >>= 8;
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
