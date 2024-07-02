const { homeEntryModel } = require("../models/homeEntry");
const { localEntryModel } = require("../models/localEntry");
const { userModel } = require("../models/user");
const entryRouter = require("express").Router();

async function saveHomeEntry(req, res, next) {
  const { name, rollNo, email, phoneNo, room, branch, dateNtime } = req.body;
  const homeEntry = await homeEntryModel({
    name,
    rollNo,
    email,
    phoneNo,
    room,
    branch,
    dateNtime,
  });

  if (!homeEntry) {
    res.status(500).json({
      status: true,
      message: "some error occured while making the entry",
    });
    return;
  }

  const successRes = await homeEntry.save();
  if (!successRes) {
    res.json(500).json({
      status: false,
      message: "some error occured while saving the entry",
    });
    return;
  }

  const updateUser = userModel.findOneAndUpdate(
    { email },
    {
      $push: { homeEntry: successRes._id },
    },
    {
      new: true,
    }
  );
  if (!updateUser) {
    res.status(500).json({
      status: false,
      message: "some error occured while updating the user",
    });
    return;
  }
  res.json({ status: true, message: "data saved" });
}

entryRouter.post("/homeEntry", saveHomeEntry);

module.exports = {
  entryRouter: entryRouter,
};
