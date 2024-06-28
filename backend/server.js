const express = require("express");
const mongoose = require("mongoose");
const path = require("path");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const route = require("express").Router();
const zod = require("zod");
const dotenv = require("dotenv");
const { connectMongo } = require("./db/db");
const {authRoute} = require("./routes/auth");
const auth = require("./routes/auth");

const result = dotenv.config({ path: path.resolve(__dirname, "../.env") });

if (result.error) {
  throw result.error;
}

const app = express();

const port = process.env.PORT || 3000;

app.use(express.json());
app.use(authRoute)

connectMongo();

app.listen(port, () => {
  console.log("your server has started");
});
