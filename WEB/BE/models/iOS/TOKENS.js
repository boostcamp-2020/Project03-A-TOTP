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
      toekn_name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      target_url: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      key: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      sequelize,
      modelName: 'tokens',
      timestamps: false,
    },
  );
  return TOKENS;
};
