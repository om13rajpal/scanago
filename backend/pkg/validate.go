package pkg

import (
	"github.com/go-playground/validator/v10"
	"github.com/om13rajpal/scanago/internal/models"
)

func ValidateUser(user models.User) (bool, error) {
	validator := validator.New()

	err := validator.Struct(user)

	if err != nil {
		return false, err
	}

	return true, nil
}