import { DataTypes } from "sequelize";
import sequelize from "../config/sequelize.js"

const User = sequelize.define("users", {
    user_id: {
        type: DataTypes.INTEGER.UNSIGNED,
        primaryKey: true,
        allowNull: false,
        autoIncrement: true,
    },
    name:{
        type: DataTypes.STRING(45),
        allowNull: false
    },
    last_name:{
        type: DataTypes.STRING(45),
        allowNull: false,
    },
    birth_date:{
        type: DataTypes.STRING(20),
        allowNull: true,
    },
    email:{
        type: DataTypes.STRING(60),
        allowNull:false,
        unique: true,
    },
    password:{
        type: DataTypes.STRING(100),
        allowNull: false,
    }
})

export default User;