const express = require("express");
const path = require("path");
const dotenv = require("dotenv");
const { connectMongo } = require("./db/db");
const { authRoute } = require("./routes/auth");
const { entryRouter } = require("./routes/entry");

const result = dotenv.config();

if (result.error) {
  throw result.error;
}

const app = express();

const port = process.env.PORT || 3000;

app.use(express.json());
app.use(authRoute);
app.use(entryRouter);

connectMongo();

app.listen(port, () => {
  console.log("your server has started");
});
