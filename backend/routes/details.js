const detailsRoute = require("express").Router();
const { userModel } = require("../models/user");
const { homeEntryModel } = require("../models/homeEntry");
const { localEntryModel } = require("../models/localEntry");

async function listHomeEntry(req, res, next) {
  const { email } = req.body;
  const user = await userModel.findOne({ email });

  if (!user) {
    res.status(500).json({ status: false, message: "user not found" });
    return;
  }

  const data = user.homeEntry.map(async (id) => {
    return await homeEntryModel.findById(id);
  });

  if (!data) {
    res.status(500).json({ status: false, message: "data not found" });
    return;
  }
  const list = await Promise.all(data);

  res.json({ status: true, message: "data found", homeEntry: list });
}

async function listLocalEntry(req, res, next) {
  const { email } = req.body;
  const user = await userModel.findOne({ email });

  if (!user) {
    res.status(500).json({ status: false, message: "user not found" });
    return;
  }

  const data = user.localEntry.map(async (id) => {
    return await localEntryModel.findById(id);
  });

  if (!data) {
    res.status(500).json({ status: false, message: "data not found" });
    return;
  }

  const list = Promise.all(data);
  res.json({ status: true, message: "local entry found", localEntry: list });
}

detailsRoute.post("/listHomeEntry", listHomeEntry);
detailsRoute.post("/listLocalEntry", listLocalEntry);

module.exports = {
  detailsRoute: detailsRoute,
};
