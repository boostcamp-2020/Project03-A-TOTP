module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('users', [
      {
        idx: 1,
        email: 'mon823@naver.com',
        name: '문석암',
        birth: '980823',
        phone: '010-1234-5678',
      },
    ]);
    await queryInterface.bulkInsert('auths', [
      {
        idx: 1,
        id: 'testid',
        password: 'pass',
        secret_key: 'test',
        state: '0',
        user_idx: 1,
      },
    ]);
    await queryInterface.bulkInsert('logs', [
      {
        idx: 1,
        device: 'test',
        access_time: new Date('2020-11-19T09:52:39.000Z'),
        ip_address: 'test',
        location: 'test',
        user_idx: 1,
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('users', null, {});
    await queryInterface.bulkInsert('auths', null, {});
    await queryInterface.bulkInsert('logs', null, {});
  },
};
