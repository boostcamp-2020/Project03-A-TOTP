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
      name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      udid: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      model_name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      backup: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
      },
    },
    {
      sequelize,
      modelName: 'devices',
      timestamps: false,
    }
  );
  return DEVICES;
};
