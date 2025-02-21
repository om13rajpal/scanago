package config

import (
	"fmt"
	"os"

	"github.com/joho/godotenv"
)

var (
	PORT       string
	MONGO_URI  string
	JWT_SECRET string
)

func LoadConfig() {
	err := godotenv.Load()

	if err != nil {
		fmt.Println("Error loading .env file")
	}

	PORT = GetEnv("PORT", "3000")
	MONGO_URI = GetEnv("MONGO_URI", "mongodb://localhost:27017")
	JWT_SECRET = GetEnv("JWT_SECRET", "golang")
}

func GetEnv(key string, fallback string) string {
	value, exists := os.LookupEnv(key)

	if exists {
		return value
	}

	return fallback
}
