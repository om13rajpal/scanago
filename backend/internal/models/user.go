package models

import "go.mongodb.org/mongo-driver/v2/bson"

type User struct {
	Id       bson.ObjectID `json:"_id,omitempty" bson:"_id,omitempty"`
	Username string        `json:"username,omitempty" bson:"username,omitempty" validate:"min=6,max=12"`
	Password string        `json:"password,omitempty" bson:"password,omitempty" validate:"min=6,max=12"`
	Email    string        `json:"email,omitempty" bson:"email,omitempty" validate:"email"`
}