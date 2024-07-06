const mongoose = require("mongoose");

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

  phoneNo: {
    type: String,
    default: "8950291327",
  },

  rollNo: {
    type: String,
    default: "102316071",
  },

  name: {
    type: String,
    default: "Om Rajpal",
  },

  branch: {
    type: String,
    default: "CSE",
  },

  room: {
    type: String,
    default: "120",
  },

  homeEntry: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: "Home",
  }],
  
  localEntry: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: "local",
  }],

  image: {
    type: String,
    default: "https://res.cloudinary.com/dvhwz7ptr/image/upload/wahswfysi62covjwfzcd.webp"
  }

});

const userModel = mongoose.model("user", userSchema);

module.exports = {
  userModel,
};
