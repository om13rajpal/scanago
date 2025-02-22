package pkg

import (
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/om13rajpal/scanago/config"
	"github.com/om13rajpal/scanago/internal/models"
)

func GenerateToken(user models.User) (string, error) {
	claims := jwt.MapClaims{
		"username": user.Username,
		"email":    user.Email,
		"exp":      time.Now().Add(time.Hour * 2).Unix(),
	}

	claimToken := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	token, err := claimToken.SignedString([]byte(config.JWT_SECRET))

	if err != nil {
		return "", err
	}

	return token, nil
}
