const userService = require('@services/iOS/user');
const deviceService = require('@services/iOS/device');
const createError = require('http-errors');
const JWT = require('jsonwebtoken');
const { makeRandom } = require('@utils/random');
const { emailSender } = require('@utils/emailSender');

const userController = {
  async getUserFromJWT(req, res, next) {
    const bearerHeader = req.headers.authorization;

    if (!bearerHeader) {
      return next(createError(403, 'forbidden'));
    }

    const jwt = bearerHeader.split(' ')[1];
    const { userIdx, deviceUdid } = JWT.verify(jwt, process.env.ENCRYPTIONKEY);

    req.user = await userService.getUserByIdx({ idx: userIdx });
    req.deviceUdid = deviceUdid;

    next();
  },

  async sendEmail(req, res, next) {
    const { email } = req.body;
    const user = await userService.getUserByEmail({ email });

    if (user && user.multi_device === false) {
      return next(createError(400, '멀티 디바이스 off'));
    }
    const emailCode = makeRandom(1, 6);

    if (!user) {
      await userService.addUser({ email, email_code: emailCode });
    }

    emailSender.sendiOSEmailCode({ email, emailCode });

    res.json({ message: 'OK' });
  },

  async verifyEmailCode(req, res, next) {
    const { code, email, device } = req.body;
    const user = await userService.getUserByEmail({ email });

    if (!user) {
      return next(createError(400, '존재하지 않는 사용자'));
    }

    if (code !== user.email_code) {
      return next(createError(400, '틀린 코드 입력'));
    }

    const createdDevice = await deviceService.addDevice({
      ...device,
      model_name: device.modelName,
      user_idx: user.idx,
    });
    const jwt = JWT.sign({ userIdx: user.idx, deviceUdid: createdDevice.udid }, process.env.ENCRYPTIONKEY);

    res.json({
      message: '성공요',
      user: {
        email: user.email,
        device: [...user.devices, createdDevice],
        multiDevice: user.multi_device,
      },
      data: { jwt },
    });
  },

  async updateEmail(req, res) {
    const { user } = req;
    const { email } = req.body;

    const updatedUser = await user.update({ email }, { returning: true });

    res.json({ email: updatedUser.email });
  },

  async updateMulti(req, res) {
    const { user } = req;
    const { multiDevice } = req.body;

    const updatedUser = await user.update({ multi_device: multiDevice }, { returning: true });

    res.json({ multiDevice: updatedUser.multi_device });
  },
};

module.exports = userController;
