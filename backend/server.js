const express = require("express");
const mongoose = require("mongoose");
const path = require('path');
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const route = require("express").Router();
const zod = require("zod");
const dotenv = require("dotenv")

const result = dotenv.config({ path: path.resolve(__dirname, '../.env') });

if (result.error) {
  throw result.error;
}

const app = express();

const port = process.env.PORT || 3000;
const secretKey = process.env.SECRET_KEY

app.use(express.json());
app.use("/", route);

app.get("/", (req, res) => {
  res.send("server is working properly");
});

mongoose
  .connect(process.env.MONGODB_URI)
  .then(() => {
    console.log("MONGODB connected");
  })
  .catch((e) => {
    console.log("error connecting to mongoose\n", e);
  });

const userSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
});

const userModel = mongoose.model("user", userSchema);

function generateToken(tokenData, secretKey, expiretime) {
  return jwt.sign(tokenData, secretKey, { expiresIn: expiretime });
}

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

function validateInput(data) {
  const schema = zod.object({
    email: zod.string().email(),
    password: zod.string().min(6),
  });

  const response = schema.safeParse(data);
  return response;
}

async function register(req, res, next) {
  try {
    const data = req.body;
    const response = validateInput(data);
    if (response.success) {
      const user = await registerUser(data.email, data.password);
      if (user) {
        const tokenData = {
          _id: user._id,
          email: user.email,
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
          const tokenData = { _id: user.id, email: user.email };
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

app.listen(port);
