const userService = require('@services/iOS/user');
const deviceService = require('@services/iOS/device');
const createError = require('http-errors');
const JWT = require('jsonwebtoken');
const { makeRandom } = require('@utils/random');
const { emailSender } = require('@utils/emailSender');

const userController = {
  async getUserFromJWT(req, res, next) {
    const authorizationHeader = req.headers.authorization;

    if (!authorizationHeader) {
      return next(createError(403, '접근할 수 없는 요청입니다'));
    }

    const [authType, authToken] = authorizationHeader.split(' ');

    if (authType !== 'bearer' || !authToken) {
      return next(createError(403, '잘못된 Authorization 헤더입니다'));
    }

    const { userIdx, deviceUdid } = JWT.verify(authToken, process.env.ENCRYPTIONKEY);

    if (!userIdx || !deviceUdid) {
      return next(createError(403, '잘못된 jwt입니다'));
    }

    const user = await userService.getUserByIdx({ idx: userIdx });

    if (!user) {
      return next(createError(403, '잘못된 jwt입니다'));
    }

    req.user = user;
    req.deviceUdid = deviceUdid;

    next();
  },

  async getUser(req, res) {
    const { user } = req;
    const devices = user.devices.map((device) => {
      return {
        name: device.name,
        udid: device.udid,
        modelName: device.model_name,
        backup: device.backup,
      };
    });

    res.json({
      user: {
        email: user.email,
        multiDevice: user.multi_device,
        lastUpdate: user.last_update,
        devices,
      },
    });
  },

  async sendEmail(req, res, next) {
    const { email, device } = req.body;
    const [user, userDevice] = await Promise.all([
      userService.getUserByEmail({ email }),
      deviceService.getDeviceByUdid({ udid: device.udid }),
    ]);
    const isValidUserCondition = !user || user.multi_device === true;

    if (!isValidUserCondition && !userDevice) {
      return next(createError(403, '멀티 디바이스 off'));
    }

    const emailCode = makeRandom(1, 6);

    if (!user) {
      await userService.addUser({ email, email_code: emailCode });
    } else {
      await user.update({ email_code: emailCode });
    }

    emailSender.sendiOSEmailCode({ email, emailCode });

    res.json({ message: 'OK' });
  },

  async verifyEmailCode(req, res, next) {
    const { code, email, device } = req.body;
    const user = await userService.getUserByEmail({ email });

    if (!user) {
      return next(createError(400, '존재하지 않는 사용자입니다'));
    }

    if (code !== user.email_code) {
      return next(createError(400, '인증 코드가 틀렸습니다'));
    }

    let userDevice = user.devices.find((d) => d.udid === device.udid);

    if (!userDevice) {
      userDevice = await deviceService.addDevice({
        ...device,
        model_name: device.modelName,
        user_idx: user.idx,
      });
    }

    const jwt = JWT.sign({ userIdx: user.idx, deviceUdid: userDevice.udid }, process.env.ENCRYPTIONKEY);

    res.json({
      message: '성공요',
      data: { jwt },
    });
  },

  async updateEmail(req, res) {
    const { user } = req;
    const { email } = req.body;

    await user.update({ email }, { returning: true });

    res.json({ message: 'OK' });
  },

  async updateMulti(req, res) {
    const { user } = req;
    const { multiDevice } = req.body;

    await user.update({ multi_device: multiDevice }, { returning: true });

    res.json({ message: 'OK' });
  },
};

module.exports = userController;
