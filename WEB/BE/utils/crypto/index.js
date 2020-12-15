const Crypto = require('crypto');
const { createHmac } = require('@utils/totp/hmac');

const secretKey = process.env.ENCRYPTIONKEY;

const encryptWithAES256 = ({ Text }) => {
  const secretKeyToArray = Buffer.from(secretKey.slice(0, 32), 'utf8');
  const parameter = Buffer.from(secretKey.slice(0, 16));
  const cipher = Crypto.createCipheriv('aes-256-cbc', secretKeyToArray, parameter);
  let encryptedValue = cipher.update(Text, 'utf8', 'base64');
  encryptedValue += cipher.final('base64');
  return encryptedValue;
};

const decryptWithAES256 = ({ encryptedText }) => {
  const secretKeyToArray = Buffer.from(secretKey.slice(0, 32), 'utf8');
  const parameter = Buffer.from(secretKey.slice(0, 16));
  const cipher = Crypto.createDecipheriv('aes-256-cbc', secretKeyToArray, parameter);
  let decryptedValue = cipher.update(encryptedText, 'base64', 'utf8');
  decryptedValue += cipher.final('utf8');
  return decryptedValue;
};

const encryptWithSHA256 = (key, payload) => {
  const hmac = createHmac({ key, data: payload, algorithm: 'sha256', encoding: 'base64' });
  return hmac;
};

module.exports = { encryptWithAES256, decryptWithAES256, encryptWithSHA256 };
