const mongoose = require("mongoose");
const dotenv = require("dotenv");
const path = require("path");


dotenv.config({ path: path.resolve(__dirname, "../.env") });

function connectMongo() {
  mongoose
    .connect(process.env.MONGODB_URI)
    .then(() => {
      console.log("MONGODB connected");
    })
    .catch((e) => {
      console.log("some error occured while connecting to mongodb\n", e);
    });
}

module.exports = {
  connectMongo,
};
