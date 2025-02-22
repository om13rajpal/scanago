package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/om13rajpal/scanago/internal/handlers"
)

func SetupRoutes() *gin.Engine{
	gin.SetMode(gin.ReleaseMode)

	router := gin.Default()
	router.SetTrustedProxies(nil)
	router.GET("/", handlers.HandleHome)
	router.POST("/signup", handlers.Signup)
	router.POST("/login", handlers.Login)
	
	return router
}