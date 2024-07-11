const { sendMail } = require("../utils/mailer");
const dotenv = require("dotenv");
const mailRoute = require("express").Router();
const jwt = require("jsonwebtoken");
const { generateToken } = require("../utils/jwt");
const { text } = require("express");
const { userModel } = require("../models/user");

dotenv.config();

async function sendMailToUser(req, res, next) {
  const { endUser, name } = req.body;

  const mailOption = {
    from: process.env.EMAIL,
    to: endUser,
    subject: "Welcome to Scanago",
    text: `hello ${name}\nWe welcome you to scanago`,
  };

  sendMail.sendMail(mailOption, (err, data) => {
    if (err) {
      console.error(err.stack);
      res
        .status(500)
        .json({ status: false, message: "error sending the mail" });
      return;
    }

    res.json({ status: true, message: `email sent\n${data.response}` });
  });
}

async function sendVerificationMail(req, res, next) {
  const { email } = req.body;

  var tokenData = {
    email: email,
  };

  const token = generateToken(tokenData, process.env.EMAIL_KEY, "0.1h");
  const verificationUrl = `${req.protocol}://${req.hostname}/verifyMail?token=${token}`;

  const mailOptions = {
    from: process.env.EMAIL,
    to: email,
    subject: "Verify your email",
    text: `Please verify your email by clicking the following link\n${verificationUrl}`,
  };

  sendMail.sendMail(mailOptions, (err, data) => {
    if (err) {
      console.error(err.stack);
      res
        .status(500)
        .json({ status: false, message: "error sending the mail" });
      return;
    }

    res.json({
      status: true,
      message: `your email has been sent ${data.response}`,
    });
  });
}

async function verifyMail(req, res, next){
    const {token} = req.query;

    jwt.verify(token, process.env.EMAIL_KEY,  async (err, response)=>{
        if(err){
            res.status(401).json({status: false, message: "invalid token"});
            return;
        }

        const {email} = response;
        const user = await userModel.findOneAndUpdate({
            email: email
        },{
            isVerified: true
        })

        if(!user){
            res.status(404).json({status: false, message: "user not found"});
            return;
        }

        res.send("Your email has been verified")
    })
}

mailRoute.post("/sendMail", sendMailToUser);
mailRoute.post("/sendVerificationMail", sendVerificationMail);
mailRoute.post("/verifyMail", verifyMail);

module.exports = {
  mailRoute: mailRoute,
};
