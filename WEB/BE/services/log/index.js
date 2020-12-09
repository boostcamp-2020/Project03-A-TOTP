const Sequelize = require('sequelize');

const { Op } = Sequelize;
const logsModel = require('@models/sequelizeWEB.js').logs;

const logService = {
  async insert({ params }) {
    const query = params;
    try {
      const result = await logsModel.create(query);
      return result;
    } catch (e) {
      throw new Error(e);
    }
  },

  async update({ sid, isLoggedOut }) {
    try {
      const query = {
        is_logged_out: isLoggedOut,
        sid: null,
      };
      const where = { sid };

      const result = await logsModel.update(query, { where });
      return result;
    } catch (e) {
      throw new Error(e);
    }
  },
  async getlogsByid({ id, num }) {
    try {
      const offset = 6 * (num - 1);
      const result = await logsModel.findAndCountAll({
        where: {
          auth_id: {
            [Op.like]: id,
          },
        },
        order: [['access_time', 'DESC']],
        limit: 6,
        offset,
        attributes: [
          ['idx', 'key'],
          ['access_time', 'time'],
          'device',
          ['ip_address', 'ip'],
          'location',
          ['is_logged_out', 'isLoggedIn'],
          ['sid', 'sessionId'],
        ],
      });
      return result;
    } catch (e) {
      throw new Error(e);
    }
  },
};

module.exports = logService;
