const express = require("express");
const dotenv = require("dotenv");
const rateLimit = require("express-rate-limit");
const { connectMongo } = require("./db/db");
const { authRoute } = require("./routes/auth");
const { entryRouter } = require("./routes/entry");
const { detailsRoute } = require("./routes/details");
const sanitize = require("express-mongo-sanitize");
const { mailRoute } = require("./routes/mail");
const { userDetailsRoute } = require("./routes/userDetails");

dotenv.config();

const app = express();

const port = process.env.PORT || 3000;

app.use(express.json());

const limiter = rateLimit({
  windowMs: 1 * 60 * 1000,
  max: 30,
  message: "Too many requests from this ip, try again after 1min",
});

app.use(limiter);
app.use(sanitize());

connectMongo();

app.use(authRoute);
app.use(entryRouter);
app.use(detailsRoute);
app.use(mailRoute);
app.use(userDetailsRoute);

app.get("/", (req, res) => {
  res.send("Welcome to Scanago. The backend is up and working properly :D");
});

app.use((req, res, next) => {
  res.status(404).json({ status: false, message: "this route does not exist" });
});

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ status: false, message: "internal server error" });
});

app.listen(port, () => {
  console.log("your server has started");
});
