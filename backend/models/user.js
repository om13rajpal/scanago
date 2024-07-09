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
    default: "1234567890",
  },

  rollNo: {
    type: String,
    default: "123456789",
  },

  name: {
    type: String,
    default: "Franklin",
  },

  branch: {
    type: String,
    default: "CSE",
  },

  room: {
    type: String,
    default: "001",
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
    default: "https://res.cloudinary.com/dvhwz7ptr/image/upload/v1720547605/pngwing.com_1_zk9ic6.png"
  }

});

const userModel = mongoose.model("user", userSchema);

module.exports = {
  userModel,
};
