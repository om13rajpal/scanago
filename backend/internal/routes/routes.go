package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/om13rajpal/scanago/internal/handlers"
)

func SetupRoutes() *gin.Engine{
	router := gin.Default()
	router.GET("/", handlers.HandleHome)
	return router
}