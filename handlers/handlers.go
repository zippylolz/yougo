package handlers

import (
	"net/http"
	"zippylolz/yougo/components"
	"zippylolz/yougo/utils"

	"github.com/a-h/templ"
	"github.com/gofiber/fiber/v2"
)

func NotFound(c *fiber.Ctx) error {
	return utils.Render(c, components.Error404(), templ.WithStatus(http.StatusNotFound))
}
