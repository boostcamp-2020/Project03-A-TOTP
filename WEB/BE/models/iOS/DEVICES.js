const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class DEVICES extends Model {
    static associate(models) {
      this.belongsTo(models.users, {
        foreignKey: 'user_idx',
        targetKey: 'idx',
      });
    }
  }
  DEVICES.init(
    {
      idx: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        unique: true,
        allowNull: false,
        autoIncrement: true,
      },
      device_name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      last_access_time: {
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
      modelName: 'devices',
      timestamps: false,
    },
  );
  return DEVICES;
};
