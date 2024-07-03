const route = require("express").Router();
const bcrypt = require("bcrypt");
const { validateInput } = require("../utils/zod");
const { generateToken } = require("../utils/jwt");
const { userModel } = require("../models/user");
const path = require("path");
const dotenv = require("dotenv");

dotenv.config();
const secretKey = process.env.SECRET_KEY || "lol";

async function registerUser(email, password) {
  try {
    const salt = await bcrypt.genSalt(10);
    const hashPass = await bcrypt.hash(password, salt);
    const createUser = await userModel({ email, password: hashPass });
    const save = await createUser.save();
    return save;
  } catch (error) {
    console.log(error);
  }
}

async function register(req, res, next) {
  try {
    const data = req.body;
    const response = validateInput(data);
    if (response.success) {
      const user = await registerUser(data.email, data.password);
      if (user) {
        const tokenData = {
          _id: user.id,
          email: user.email,
          name: user.name,
          rollNo: user.rollNo,
          branch: user.branch,
          phoneNo: user.phoneNo,
          room: user.room
        };
        const token = generateToken(tokenData, secretKey, "1h");

        res.json({ status: true, token: token });
      } else {
        res
          .status(400)
          .json({ status: false, message: "Failed to register user" });
      }
    } else {
      res.status(411).json({ status: false, message: "Wrong Input type" });
    }
  } catch (error) {
    console.log(error);
  }
}

async function findUser(email) {
  try {
    return await userModel.findOne({ email });
  } catch (error) {
    console.log(error);
  }
}
async function login(req, res, next) {
  try {
    const data = req.body;
    const response = validateInput(data);

    if (response.success) {
      const user = await findUser(data.email);
      if (user) {
        if (await bcrypt.compare(data.password, user.password)) {
          const tokenData = {
            _id: user.id,
            email: user.email,
            name: user.name,
            rollNo: user.rollNo,
            branch: user.branch,
            phoneNo: user.phoneNo,
            room: user.room
          };
          const token = generateToken(tokenData, secretKey, "1h");

          res.json({ status: true, token: token });
        } else {
          res
            .status(401)
            .json({ status: false, message: "email/password doesnt match" });
        }
      } else {
        res.status(411).json({ status: false, message: "user not found" });
      }
    } else {
      res.status(411).json({ status: false, message: "wrong input type" });
    }
  } catch (error) {}
}

route.post("/register", register);
route.post("/login", login);

module.exports = {
  authRoute: route,
};
