package database

import (
	"context"
	"fmt"
	"time"

	"github.com/om13rajpal/scanago/config"
	"go.mongodb.org/mongo-driver/v2/mongo"
	"go.mongodb.org/mongo-driver/v2/mongo/options"
)

var UserCollection *mongo.Collection

func ConnectMongo() {
	clientOptions := options.Client().ApplyURI(config.MONGO_URI)

	client, err := mongo.Connect(clientOptions)

	if err != nil {
		fmt.Println("Error connecting to MongoDB", err)
		return
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	err = client.Ping(ctx, nil)

	if err != nil {
		fmt.Println("Error pinging MongoDB", err)
		return
	}

	UserCollection = client.Database("scanago").Collection("users")
	fmt.Println("Connected to MongoDB")

}
