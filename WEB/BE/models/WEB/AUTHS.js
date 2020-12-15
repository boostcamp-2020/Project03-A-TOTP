const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class AUTHS extends Model {
    static associate(models) {
      this.belongsTo(models.users, {
        foreignKey: 'user_idx',
        targetKey: 'idx',
      });
      this.hasMany(models.logs, { foreignKey: 'auth_id', sourceKey: 'id' });
    }
  }
  AUTHS.init(
    {
      idx: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        unique: true,
        allowNull: false,
        autoIncrement: true,
      },
      id: {
        type: DataTypes.STRING,
        unique: true,
        allowNull: false,
      },
      password: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      secret_key: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      is_verified: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: 0,
      },
      last_totp: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
    },
    {
      sequelize,
      modelName: 'auths',
      timestamps: false,
    }
  );
  return AUTHS;
};
