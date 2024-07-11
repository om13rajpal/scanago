const userDetailsRoute = require("express").Router();
const dotenv = require("dotenv");
const { userModel } = require("../models/user");
const { generateToken } = require("../utils/jwt");

dotenv.config();
const secretKey = process.env.SECRET_KEY || "lol";

async function addDetails(req, res, next) {
  try {
    const { email, name, phoneNo, room, Rollno, branch, image } = req.body;
    const user = await userModel.findOne({ email });

    if (!user) {
      return res.status(404).json({ status: false, message: "User not found" });
    }

    const updatedUser = await userModel.findOneAndUpdate(
      { email },
      {
        name,
        phoneNo,
        room,
        Rollno,
        branch,
        image,
      },
      { new: true }
    );

    if (!updatedUser) {
      return res
        .status(500)
        .json({ status: false, message: "Could not update details" });
    }

    const tokenData = {
      _id: updatedUser._id,
      email: updatedUser.email,
      name: updatedUser.name,
      rollNo: updatedUser.rollNo,
      branch: updatedUser.branch,
      phoneNo: updatedUser.phoneNo,
      room: updatedUser.room,
      image: updatedUser.image,
    };

    const token = generateToken(tokenData, secretKey, "1h");

    return res.status(200).json({
      status: true,
      message: "Details updated successfully",
      token: token,
    });
  } catch (error) {
    return res.status(500).json({
      status: false,
      message: "An error occurred",
      error: error.message,
    });
  }
}

async function updateDetails(req, res, next) {
  const { email, name, phoneNo, room, Rollno, branch, image } = req.body;
  const updateFields = {};

  if (name) updateFields.name = name;
  if (phoneNo) updateFields.phoneNo = phoneNo;
  if (room) updateFields.room = room;
  if (Rollno) updateFields.rollno = Rollno;
  if (branch) updateFields.branch = branch;
  if (image) updateFields.image = image;

  console.log(updateFields);

  const updatedUser = await userModel.findOneAndUpdate(
    { email: email },
    updateFields,
    { new: true }
  );

  if (!updatedUser) {
    res
      .status(500)
      .json({ status: false, message: "Could not update details" });
    return;
  }

  const tokenData = {
    _id: updatedUser._id,
    email: updatedUser.email,
    name: updatedUser.name,
    rollNo: updatedUser.rollNo,
    branch: updatedUser.branch,
    phoneNo: updatedUser.phoneNo,
    room: updatedUser.room,
    image: updatedUser.image,
  };

  const token = generateToken(tokenData, secretKey, "1h");

  res.json({ status: true, message: "details updated", token: token });
}

userDetailsRoute.post("/updateDetails", addDetails);
userDetailsRoute.post("/updateNewDetails", updateDetails);

module.exports = {
  userDetailsRoute: userDetailsRoute,
};
