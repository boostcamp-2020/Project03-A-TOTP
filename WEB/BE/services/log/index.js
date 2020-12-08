// logs 테이블변경 후 적용해야합니다.
const logsModel = require('@models/sequelizeWEB.js').logs;

const logService = {
  async insert({ sid, status }) {
    const query = { sid, status };
    try {
      const result = await logsModel.create(query);
      return result;
    } catch (e) {
      throw new Error(e);
    }
  },

  async update({ sid, isLoggedOut }) {
    try {
      const query = { is_logged_out: isLoggedOut };
      const where = { sid };

      const result = await logsModel.update(query, { where });
      return result;
    } catch (e) {
      throw new Error(e);
    }
  },
  async getlogsByid({ id }) {
    try {
      const result = await logsModel.findOne({ where: { id } });
      return result;
    } catch (e) {
      throw new Error(e);
    }
  },
};

module.exports = logService;
