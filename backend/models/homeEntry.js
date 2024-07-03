const mongoose = require("mongoose");

const homeEntrySchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  rollNo: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  phoneNo: {
    type: String,
    required: true,
  },
  room: {
    type: String,
    required: true,
  },
  branch: {
    type: String,
    required: true,
  },
  dateNtime: {
    type: String,
    required: true,
  },
  reason: {
    type: String,
    required: true,
  },
});

const homeEntryModel = mongoose.model("home", homeEntrySchema);

module.exports = {
  homeEntryModel,
};
