package main

import (
	"github.com/om13rajpal/scanago/config"
	"github.com/om13rajpal/scanago/internal/database"
	"github.com/om13rajpal/scanago/internal/routes"
)

func main() {
	config.LoadConfig()
	database.ConnectMongo()

	router := routes.SetupRoutes()
	router.Run(":" + config.PORT)
}
