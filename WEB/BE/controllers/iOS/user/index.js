const userService = require('@services/iOS/user');
const createError = require('http-errors');

const userController = {
  async getUser(req, res, next) {
    // get email or idx from JWT
    // const user = await userSerivce.getUserByEmail({ email });
    // const user = await userSerivce.getUserByIdx({ idx });
    // req.user = user;
  },

  async sendEmail(req, res, next) {
    const { email } = req.body;
    const user = await userService.getUserByEmail({ email });

    if (user && user.multi_device === false) {
      return next(createError(400, '멀티 디바이스 off'));
    }

    if (!user) {
      await userService.addUser({ email });
    }

    /** @TODO email_code 설정, 이메일 보내기 */

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

    /** @TODO 디바이스 추가 */
    // const device = await deviceService.createDevice(device);

    res.json({
      message: '성공요',
      user: {
        email: user.email,
        device: [...user.devices, device],
        multiDevice: user.multi_device,
      },
      data: {},
    });
  },
};

module.exports = userController;
