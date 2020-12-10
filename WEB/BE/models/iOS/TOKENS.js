const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class TOKENS extends Model {
    static associate(models) {
      this.belongsTo(models.users, {
        foreignKey: 'user_idx',
        targetKey: 'idx',
      });
    }
  }
  TOKENS.init(
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
        allowNull: false,
        unique: true,
      },
      key: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      color: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      icon: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      is_main: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
      },
    },
    {
      sequelize,
      modelName: 'tokens',
      timestamps: false,
    }
  );
  return TOKENS;
};
