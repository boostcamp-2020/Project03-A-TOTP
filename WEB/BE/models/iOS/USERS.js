const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class USERS extends Model {
    static associate(models) {
      this.belongsTo(models.devices, {
        foreignKey: 'user_idx',
        targetKey: 'idx',
      });
      this.belongsTo(models.tokens, {
        foreignKey: 'user_idx',
        targetKey: 'idx',
      });
    }
  }
  USERS.init(
    {
      idx: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        unique: true,
        allowNull: false,
        autoIncrement: true,
      },
      email: {
        type: DataTypes.STRING,
        unique: true,
        allowNull: false,
      },
      name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      sequelize,
      modelName: 'users',
      timestamps: false,
    }
  );
  return USERS;
};
