const detailsRoute = require("express").Router();
const { userModel } = require("../models/user");
const { homeEntryModel } = require("../models/homeEntry");
const { localEntryModel } = require("../models/localEntry");
const dotenv = require("dotenv");
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
      return res.status(500).json({ status: false, message: "Could not update details" });
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
    return res.status(500).json({ status: false, message: "An error occurred", error: error.message });
  }
}


async function listHomeEntry(req, res, next) {
  try {
    const { email } = req.body;
    const user = await userModel.findOne({ email });

    if (!user) {
      res.status(500).json({ status: false, message: "User not found" });
      return;
    }

    const data = user.homeEntry.map(async (id) => {
      return await homeEntryModel.findById(id);
    });

    if (!data) {
      res.status(500).json({ status: false, message: "Data not found" });
      return;
    }

    const list = await Promise.all(data);

    res.json({ status: true, message: "Data found", listHomeEntry: list });
  } catch (error) {
    next(error);
  }
}

async function listLocalEntry(req, res, next) {
  try {
    const { email } = req.body;
    const user = await userModel.findOne({ email });

    if (!user) {
      res.status(500).json({ status: false, message: "User not found" });
      return;
    }

    const data = user.localEntry.map(async (id) => {
      return await localEntryModel.findById(id);
    });

    if (!data || data.length === 0) {
      res.status(500).json({ status: false, message: "Data not found" });
      return;
    }

    const list = await Promise.all(data);
    res.json({
      status: true,
      message: "Local entry found",
      listLocalEntry: list,
    });
  } catch (error) {
    next(error);
  }
}

async function getAllHomeList(req, res, next) {
  const homeEntry = await homeEntryModel.find({});
  if (!homeEntry) {
    res.status(500).json({ status: false, message: "could not fetch entries" });
    return;
  }

  res.json({ status: true, allHomeEntry: homeEntry });
}

async function getAllLocalList(req, res, next) {
  const localEntry = await localEntryModel.find({});
  if (!localEntry) {
    res.status(500).json({ status: true, message: "Could not fetch entries" });
    return;
  }

  res.json({ status: true, allLocalEntry: localEntry });
}

detailsRoute.post("/listHomeEntry", listHomeEntry);
detailsRoute.post("/listLocalEntry", listLocalEntry);
detailsRoute.post("/allHomeEntry", getAllHomeList);
detailsRoute.post("/allLocalEntry", getAllLocalList);
detailsRoute.post("/updateDetails", addDetails);

module.exports = {
  detailsRoute: detailsRoute,
};
