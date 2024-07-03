const { homeEntryModel } = require("../models/homeEntry");
const { localEntryModel } = require("../models/localEntry");
const { userModel } = require("../models/user");
const entryRouter = require("express").Router();

async function saveHomeEntry(req, res, next) {
  const { name, rollNo, email, phoneNo, room, branch, dateNtime, reason } = req.body;
  const homeEntry = await homeEntryModel({
    name,
    rollNo,
    email,
    phoneNo,
    room,
    branch,
    dateNtime,
    reason
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

  const updateUser = await userModel.findOneAndUpdate(
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
  res.json({ status: true, message: "home entry saved" });
}

async function saveLocalEntry(req, res, next) {
  const { name, rollNo, email, phoneNo, room, branch, dateNtime, reason } = req.body;
  const newEntry = await localEntryModel({
    name,
    rollNo,
    email,
    phoneNo,
    room,
    branch,
    dateNtime,
    reason
  });
  if (!newEntry) {
    res
      .status(500)
      .json({ status: false, message: "some error occured while making" });
    return;
  }

  const saveEntry = await newEntry.save();
  if (!saveEntry) {
    res
      .status(500)
      .json({ status: false, message: "some error occured while saving" });
  }

  const updateUser = await userModel.findOneAndUpdate(
    {
      email,
    },
    {
      $push: { localEntry: saveEntry._id },
    },
    {
      new: true,
    }
  );

  if (!updateUser) {
    res
      .status(500)
      .json({ status: false, message: "unable to update user entry" });
  }

  res.json({ status: true, message: "local entry saved" });
}

entryRouter.post("/homeEntry", saveHomeEntry);
entryRouter.post("/localEntry", saveLocalEntry);

module.exports = {
  entryRouter: entryRouter,
};
