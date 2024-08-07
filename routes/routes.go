package routes

import (
	"fmt"
	"zippylolz/yougo/components"
	"zippylolz/yougo/utils"

	"github.com/gofiber/fiber/v2"
)

func RegisterRoutes(app *fiber.App) {

	app.Get("/", func(c *fiber.Ctx) error {
		comp := components.Home()
		return utils.Render(c, comp)
	})

	// app.Get("/hello", func(c *fiber.Ctx) error {
	// 	name := c.Query("name", "Randy")
	// 	return utils.Render(c, components.Hello(name))
	// })

	app.Get("/videos/:v", func(c *fiber.Ctx) error {
		video := c.Params("v", "12345")
		msg := fmt.Sprintf("Page for video %s.", video)
		return c.SendString(msg)
	})

}
