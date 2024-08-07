package main

import (
	"log"
	"zippylolz/yougo/handlers"
	"zippylolz/yougo/routes"

	"github.com/gofiber/fiber/v2"
)

func main() {

	app := fiber.New()

	routes.RegisterRoutes(app)

	app.Static("/public", "./public")

	app.Use(handlers.NotFound)

	// Start the server on port 3000
	log.Fatal(app.Listen(":3000"))
}
