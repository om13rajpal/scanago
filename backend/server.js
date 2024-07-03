const express = require("express");
const path = require("path");
const dotenv = require("dotenv");
const { connectMongo } = require("./db/db");
const { authRoute } = require("./routes/auth");
const { entryRouter } = require("./routes/entry");
const { detailsRoute } = require("./routes/details");


dotenv.config();

const app = express();

const port = process.env.PORT || 3000;

app.use(express.json());
app.use(authRoute);
app.use(entryRouter);
app.use(detailsRoute);

connectMongo();

app.listen(port, () => {
  console.log("your server has started");
});
