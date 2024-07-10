const { sendMail } = require("../utils/mailer");
const dotenv = require("dotenv")
const mailRoute = require("express").Router()

dotenv.config();


async function sendMailToUser(req, res, next){
    const {endUser, name} = req.body;

    const mailOption = {
        from: process.env.EMAIL,
        to: endUser,
        subject: "Welcome to Scanago",
        text: `hello ${name}\nWe welcome you to scanago`
    }

    sendMail.sendMail(mailOption, (err, data)=>{
        if(err){
            console.error(err.stack);
            res.status(500).json({status: false, message:"error sending the mail"})
            return
        }

        res.json({status: true, message: `email sent\n${data.response}`})
        
    })
}

mailRoute.post("/sendMail", sendMailToUser);

module.exports = {
    mailRoute: mailRoute
}