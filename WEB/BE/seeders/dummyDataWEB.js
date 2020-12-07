const { encryptWithAES256 } = require('../utils/crypto');
const { getEncryptedPassword } = require('../utils/bcrypt');

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('users', [
      {
        idx: 1,
        email: encryptWithAES256({ Text: 'mon823@naver.com' }),
        name: encryptWithAES256({ Text: '문석암' }),
        birth: encryptWithAES256({ Text: '1998-08-23' }),
        phone: encryptWithAES256({ Text: '010-1234-1234' }),
      },
    ]);
    await queryInterface.bulkInsert('auths', [
      {
        idx: 1,
        id: 'testId1234',
        password: await getEncryptedPassword('test1234!'),
        secret_key: 'ABCDEF',
        state: '0',
        user_idx: 1,
      },
    ]);
    await queryInterface.bulkInsert('logs', [
      {
        idx: 1,
        device: encryptWithAES256({ Text: 'MAC Os' }),
        access_time: new Date('2020-11-19T09:52:39.000Z'),
        sid: encryptWithAES256({ Text: 'SDFEVNSDKJHEFSKJDHFEK' }),
        status: false,
        ip_address: encryptWithAES256({ Text: '127.0.0.1' }),
        location: encryptWithAES256({ Text: 'Ko' }),
        user_idx: 1,
      },
      {
        idx: 2,
        device: encryptWithAES256({ Text: 'MAC Os' }),
        access_time: new Date('2020-11-26T09:52:39.000Z'),
        sid: encryptWithAES256({ Text: 'vnajskfehkfjashef' }),
        status: true,
        ip_address: encryptWithAES256({ Text: '127.0.0.1' }),
        location: encryptWithAES256({ Text: 'Ko' }),
        user_idx: 1,
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('users', null, {});
    await queryInterface.bulkDelete('auths', null, {});
    await queryInterface.bulkDelete('logs', null, {});
  },
};
