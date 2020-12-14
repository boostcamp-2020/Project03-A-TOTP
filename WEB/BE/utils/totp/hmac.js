const crypto = require('crypto');

const MAX_KEY_BYTES = 64;
const IPAD_NUM = 0x36;
const OPAD_NUM = 0x5c;

const strToBuffer = (encoding) => (string) => Buffer.from(string, encoding);

const createHash = ({ algorithm, encoding }) => (data) =>
  crypto.createHash(algorithm).update(data).digest(encoding);

const concatBuffer = (a) => (b) => Buffer.concat([a, b]);

const pipe = (...functions) => (arg) => functions.reduce((prev, fn) => fn(prev), arg);

const xor = (a, b) => {
  const maxLength = Math.max(a.length, b.length);
  const buffer = Buffer.allocUnsafe(maxLength);

  for (let i = 0; i < maxLength; ++i) {
    buffer[i] = a[i] ^ b[i];
  }
  return buffer;
};

/**
 * HMAC을 생성합니다
 * @param {string} key 비밀 키 문자열
 * @param {buffer | string} data HMAC을 생성할 메시지 문자열 또는 버퍼
 * @param {string} algorithm 적용할 암호화 알고리즘 (sha1, sha256)
 * @param {string} encoding HMAC 문자열의 인코딩 (hex, base64)
 * @returns {string} HMAC 문자열
 */
exports.createHmac = ({ key, data, algorithm, encoding }) => {
  if (typeof key !== 'string') {
    throw new Error('key must be a String');
  }

  if (!Buffer.isBuffer(data) && typeof data !== 'string') {
    throw new Error('data must be a Buffer or String');
  }

  const keyBuffer = Buffer.from(key);
  const dataBuffer = Buffer.isBuffer(data) ? data : Buffer.from(data);

  if (keyBuffer.byteLength > MAX_KEY_BYTES) {
    throw new Error('Key length exceeded the limit');
  }

  const targetBuffer = Buffer.alloc(MAX_KEY_BYTES, 0);

  keyBuffer.copy(targetBuffer, 0, 0, keyBuffer.byteLength);

  const iPad = Buffer.alloc(MAX_KEY_BYTES, IPAD_NUM);
  const oPad = Buffer.alloc(MAX_KEY_BYTES, OPAD_NUM);
  const iKeyPad = xor(targetBuffer, iPad);
  const oKeyPad = xor(targetBuffer, oPad);

  return pipe(
    concatBuffer(iKeyPad),
    createHash({ algorithm, encoding }),
    strToBuffer(encoding),
    concatBuffer(oKeyPad),
    createHash({ algorithm, encoding })
  )(dataBuffer);
};
