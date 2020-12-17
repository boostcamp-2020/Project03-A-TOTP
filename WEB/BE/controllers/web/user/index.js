const authService = require('@/services/web/auth');
const userService = require('@/services/web/user');
const { encryptWithAES256, decryptWithAES256 } = require('@utils/crypto');
const { getEncryptedPassword } = require('@utils/bcrypt');
const { emailSender } = require('@/utils/emailSender');
const createError = require('http-errors');
const DB = require('@models/sequelizeWEB');
const totp = require('@utils/totp');

const userController = {
  async signUp(req, res) {
    let userInfo = {
      email: req.body.email,
      name: req.body.name,
      birth: req.body.birth,
      phone: req.body.phone,
    };
    const { id, password } = req.body;

    userInfo = encrypUserInfo({ userInfo });
    const secretKey = totp.makeSecretKey();
    const url = totp.makeURL({ secretKey, email: req.body.email });
    const encryptPassword = await getEncryptedPassword(password);

    await DB.sequelize.transaction(async () => {
      const insertResult = await userService.insert({ userInfo });
      const result = await authService.insert({
        idx: insertResult.dataValues.idx,
        id,
        password: encryptPassword,
        isVerified: '0',
        secretKey,
      });

      emailSender.SignUpAuthentication(req.body.email, req.body.name, insertResult.dataValues.idx);
      res.json({ result, url });
    });
  },

  async dupEmail(req, res) {
    const email = encryptWithAES256({ Text: req.body.email });
    const result = await userService.check({ email });
    res.json({ result });
  },

  async confirmEmail(req, res, next) {
    const user = decryptWithAES256({ encryptedText: req.query.user }).split(' ');
    const time = user[1];
    const idx = user[2];
    if (time < Date.now()) return next(createError(400, '요청이 만료되었습니다.'));
    const info = {
      isVerified: 1,
      idx,
      loginFailCount: 0,
    };

    await authService.update({ info });
    res.json({ result: true });
  },

  async findID(req, res, next) {
    const { email, name } = req.body;

    const userInfo = encrypUserInfo({ userInfo: req.body });
    const user = await userService.findAuthByUser({ userInfo });

    if (!user) return next(createError(400, '존재하지 않는 사용자입니다.'));

    emailSender.sendId(email, name, user.auth.id);
    res.json(true);
  },

  async getUser(req, res) {
    const uid = req.session.user;
    const {
      user: { birth, email, name, phone },
    } = await authService.getUserById({ id: uid });

    res.json({
      user: {
        birth: decryptWithAES256({ encryptedText: birth }),
        email: decryptWithAES256({ encryptedText: email }),
        name: decryptWithAES256({ encryptedText: name }),
        phone: decryptWithAES256({ encryptedText: phone }),
      },
    });
  },

  async updateUser(req, res) {
    const uid = req.session.user;
    const { name, email, phone, birth } = req.body;
    const { user } = await authService.getUserById({ id: uid });

    const userInfo = {
      name: name && encryptWithAES256({ Text: name }),
      email: email && encryptWithAES256({ Text: email }),
      phone: phone && encryptWithAES256({ Text: phone }),
      birth: birth && encryptWithAES256({ Text: birth }),
    };

    await user.update(userInfo);

    res.json({ message: 'ok' });
  },

  async reSendEmail(req, res, next) {
    const { id } = req.body;
    const { user } = await authService.getUserById({ id });
    emailSender.SignUpAuthentication(
      decryptWithAES256({ encryptedText: user.email }),
      decryptWithAES256({ encryptedText: user.name }),
      user.idx
    );
    res.json({ message: 'ok' });
  },
};

const encrypUserInfo = ({ userInfo }) => {
  Object.keys(userInfo).forEach((key) => {
    userInfo[key] = encryptWithAES256({ Text: userInfo[key] });
  });
  return userInfo;
};

module.exports = userController;
