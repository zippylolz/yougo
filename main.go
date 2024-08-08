package main

import (
	"log"
	"os"
	"zippylolz/yougo/handlers"
	"zippylolz/yougo/routes"

	fiberlog "github.com/gofiber/fiber/v2/log"

	"github.com/gofiber/fiber/v2"
)

func main() {

	// Logging
	f, err := os.OpenFile("test.log", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
	if err != nil {
		return
	}

	fiberlog.SetOutput(f)

	app := fiber.New()

	routes.RegisterRoutes(app)

	app.Static("/public", "./public")

	app.Use(handlers.NotFound)

	// Start the server on port 3000
	log.Fatal(app.Listen(":3000"))
}
