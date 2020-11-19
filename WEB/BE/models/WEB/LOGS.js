const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class LOGS extends Model {
    static associate(models) {
      this.hasOne(models.users, { foreignKey: 'user_idx', sourceKey: 'idx' });
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
