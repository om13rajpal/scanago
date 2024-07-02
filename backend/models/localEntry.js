const mongoose = require("mongoose");

const localEntrySchema = new mongoose.Schema({
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
    type: Date,
    required: true,
  },
});

const localEntryModel = mongoose.model("local", localEntrySchema);

module.exports = {
    localEntryModel
}
