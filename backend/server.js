const express = require("express");
const dotenv = require("dotenv");
const rateLimit = require("express-rate-limit");
const { connectMongo } = require("./db/db");
const { authRoute } = require("./routes/auth");
const { entryRouter } = require("./routes/entry");
const { detailsRoute } = require("./routes/details");
const sanitize = require("express-mongo-sanitize")


dotenv.config();

const app = express();

const port = process.env.PORT || 3000;

app.use(express.json());

app.set('trust proxy', false);

const limiter = rateLimit({
  windowMs: 5 * 60 * 1000,
  max: 100,
  message: "Too many requests from this ip, try again after 5mins"
})

app.use(limiter);

app.use(authRoute);
app.use(entryRouter);
app.use(detailsRoute);

app.use(sanitize());

connectMongo();


app.get("/", (req, res)=>{
  res.send("Welcome to Scanago. The backend is up and working properly :D")
})

app.listen(port, () => {
  console.log("your server has started");
});
