const speakeasy = require('speakeasy');
const QRCode = require('qrcode');
const authService = require('@services/auth');
const userService = require('@services/user');
const { encryptWithAES256 } = require('@utils/crypto');
const { encryptedPassword } = require('@utils/bcrypt');
const { requestEmail } = require('@controllers/email');

const userController = {
  async signUp(req, res, next) {
    let userInfo = {
      email: req.body.email,
      name: req.body.name,
      birth: req.body.birth,
      phone: req.body.phone,
    };
    const { id, password } = req.body;
    requestEmail(req.body.email, req.body.name);
    try {
      userInfo = encrypUserInfo({ userInfo });
      const secretKey = makeSecretKey();
      const qrcode = await makeQRCode({ secretKey });
      const encryptPassword = await encryptedPassword(password);
      const insertResult = await userService.insert({ userInfo, next });
      const result = await authService.insert({
        idx: insertResult.dataValues.idx,
        id,
        password: encryptPassword,
        state: '0',
        secretKey: secretKey.base32,
        next,
      });
      res.json({ result, qrcode });
    } catch (e) {
      next(e);
    }
  },

  async dupEmail(req, res, next) {
    const email = encryptWithAES256({ Text: req.body.email });
    try {
      const result = await userService.check({ email, next });
      res.json({ result });
    } catch (e) {
      next(e);
    }
  },
};

const encrypUserInfo = ({ userInfo }) => {
  Object.keys(userInfo).forEach((key) => {
    userInfo[key] = encryptWithAES256({ Text: userInfo[key] });
  });
  return userInfo;
};

const makeSecretKey = () => {
  const secretKey = speakeasy.generateSecret({
    length: 20,
    name: process.env.SECRETKEYNAME,
    algorithm: process.env.SECRETKEYALGORITHM,
  });
  return secretKey;
};

const makeQRCode = async ({ secretKey }) => {
  const url = speakeasy.otpauthURL({
    secret: secretKey.ascii,
    issuer: 'TOTP',
    label: process.env.SECRETKEYLABEL,
    algorithm: process.env.SECRETKEYALGORITHM,
    period: 60,
  });
  const qrcode = (await QRCode.toDataURL(url)).split('base64,')[1];
  return qrcode;
};

module.exports = userController;
