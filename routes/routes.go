package routes

import (
	"fmt"
	"zippylolz/yougo/components"
	"zippylolz/yougo/utils"

	"github.com/gofiber/fiber/v2"
)

func RegisterRoutes(app *fiber.App) {

	app.Get("/", func(c *fiber.Ctx) error {
		return utils.Render(c, components.Home())
	})

	app.Get("/videos/:v", func(c *fiber.Ctx) error {
		video := c.Params("v", "12345")
		msg := fmt.Sprintf("Page for video %s.", video)
		return c.SendString(msg)
	})
}
