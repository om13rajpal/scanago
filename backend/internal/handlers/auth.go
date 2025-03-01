package handlers

import (
	"context"
	"fmt"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/om13rajpal/scanago/internal/database"
	"github.com/om13rajpal/scanago/internal/models"
	"github.com/om13rajpal/scanago/pkg"
	"go.mongodb.org/mongo-driver/v2/bson"
)

func Signup(c *gin.Context) {
	var user models.User

	err := c.BindJSON(&user)

	if err != nil {
		c.IndentedJSON(http.StatusBadRequest, gin.H{"status": false, "error": err.Error()})
		return
	}

	inputValid, err := pkg.ValidateUser(user)

	if !inputValid {
		c.IndentedJSON(http.StatusBadRequest, gin.H{"status": false, "error": err.Error()})
		return
	}

	hashedPassword, err := pkg.HashPassword(user.Password)

	if err != nil {
		c.IndentedJSON(http.StatusInternalServerError, gin.H{"status": false, "error": err.Error()})
		return
	}

	user.Password = hashedPassword

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	result, err := database.UserCollection.InsertOne(ctx, user)

	if err != nil {
		c.IndentedJSON(http.StatusInternalServerError, gin.H{"status": false, "error": err.Error()})
		return
	}

	token, err := pkg.GenerateToken(user)

	if err != nil {
		c.IndentedJSON(http.StatusInternalServerError, gin.H{"status": false, "error": err.Error()})
		return
	}
	err = pkg.SendMail(user.Email, "Welcome to Scanago", "Welcome to Scanago, your account has been created successfully.")
	if err != nil {
		fmt.Println("Error sending email")
	}
	
	c.IndentedJSON(http.StatusOK, gin.H{"status": true, "message": "User created successfully", "data": result, "token": token})

}

func Login(c *gin.Context) {
	var user models.User
	err := c.BindJSON(&user)

	if err != nil {
		c.IndentedJSON(http.StatusBadRequest, gin.H{"status": false, "error": err.Error()})
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	var foundUser models.User
	userData := database.UserCollection.FindOne(ctx, bson.M{"username": user.Username}).Decode(&foundUser)

	if userData != nil {
		c.IndentedJSON(http.StatusNotFound, gin.H{"status": false, "error": "User not found"})
		return
	}

	isValidPassword := pkg.CheckPassword(user.Password, foundUser.Password)

	if !isValidPassword {
		c.IndentedJSON(http.StatusUnauthorized, gin.H{"status": false, "error": "Invalid password"})
		return
	}

	token, err := pkg.GenerateToken(foundUser)
	if err != nil {
		c.IndentedJSON(http.StatusInternalServerError, gin.H{"status": false, "error": err.Error()})
		return
	}

	c.IndentedJSON(http.StatusOK, gin.H{"status": true, "message": "Login successful", "token": token, "user": foundUser})
}
