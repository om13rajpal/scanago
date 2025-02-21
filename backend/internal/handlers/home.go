package handlers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func HandleHome(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, gin.H{
		"message": "Scanago's Backend is up and running :)",
	})
}
