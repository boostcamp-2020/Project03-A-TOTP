const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class USERS extends Model {
    static associate(models) {
      this.hasOne(models.auths, {
        foreignKey: 'user_idx',
        sourceKey: 'idx',
      });
      this.hasMany(models.logs, { foreignKey: 'user_idx', sourceKey: 'idx' });
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
      birth: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      phone: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      sequelize,
      modelName: 'users',
      timestamps: false,
    },
  );
  return USERS;
};
