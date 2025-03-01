package pkg

import (
	"fmt"

	"github.com/om13rajpal/scanago/config"
	"gopkg.in/gomail.v2"
)

func SendMail(to string, subject string, body string) error {
	sender := gomail.NewDialer("smtp.gmail.com", 587, config.EMAIL, config.EMAILPASS)

	message := gomail.NewMessage()
	message.SetHeader("From", config.EMAIL)
	message.SetHeader("To", to)
	message.SetHeader("Subject", subject)
	message.SetBody("text/html", body)

	err := sender.DialAndSend(message)

	if err != nil {
		return err
	}

	fmt.Println("Email sent successfully")
	return nil
}
