const detailsRoute = require("express").Router();
const { userModel } = require("../models/user");
const { homeEntryModel } = require("../models/homeEntry");
const { localEntryModel } = require("../models/localEntry");

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

module.exports = {
  detailsRoute: detailsRoute,
};
