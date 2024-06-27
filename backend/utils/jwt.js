const jwt = require("jsonwebtoken")

function generateToken(tokenData, secretKey, expiretime) {
  return jwt.sign(tokenData, secretKey, { expiresIn: expiretime });
}

module.exports = {
    generateToken
}