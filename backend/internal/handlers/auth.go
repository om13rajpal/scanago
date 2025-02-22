package handlers

import (
	"context"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/om13rajpal/scanago/internal/database"
	"github.com/om13rajpal/scanago/internal/models"
	"github.com/om13rajpal/scanago/pkg"
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

	c.IndentedJSON(http.StatusOK, gin.H{"status": true, "message": "User created successfully", "data": result, "token": token})

}
