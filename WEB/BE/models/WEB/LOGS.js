const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class LOGS extends Model {
    static associate(models) {
      this.belongsTo(models.auths, {
        foreignKey: 'auth_id',
        targetKey: 'id',
      });
    }
  }
  LOGS.init(
    {
      idx: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        unique: true,
        allowNull: false,
        autoIncrement: true,
      },
      device: {
        type: DataTypes.STRING,
        unique: false,
        allowNull: false,
      },
      access_time: {
        type: DataTypes.DATE,
        allowNull: false,
        defaultValue: DataTypes.NOW,
      },
      sid: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      is_logged_out: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
      },
      ip_address: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      location: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      sequelize,
      modelName: 'logs',
      timestamps: false,
    }
  );
  return LOGS;
};
