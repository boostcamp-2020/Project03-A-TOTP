const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class USERS extends Model {
    static associate(models) {
      this.hasMany(models.devices, {
        foreignKey: 'user_idx',
        sourceKey: 'idx',
      });
      this.hasMany(models.tokens, {
        foreignKey: 'user_idx',
        sourceKey: 'idx',
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
      multi_device: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: true,
      },
      last_update: {
        type: DataTypes.DATE,
        allowNull: true,
        defaultValue: DataTypes.NOW,
      },
      email_code: {
        type: DataTypes.STRING(6),
        allowNull: true,
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
