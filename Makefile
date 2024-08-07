ifneq (,$(wildcard ./.env))
    include .env
    export
endif

airVersion = v1.52.3
templProxy = 7331

MAIN_PATH = tmp/bin/main
SYNC_ASSETS_COMMAND =	@go run github.com/air-verse/air@$(airVersion) \
	--build.cmd "templ generate --notify-proxy" \
	--build.bin "true" \
	--build.delay "100" \
	--build.exclude_dir "node_modules" \
	--build.include_dir "public" \
	--build.include_ext "js,css" \
	--screen.clear_on_rebuild true \
	--log.main_only true

templ:
	@templ generate --watch --proxy="http://localhost:$(templProxy)" --open-browser=false

server:
	@go run github.com/air-verse/air@$(airVersion) \
	--build.cmd "go build --tags dev -o ${MAIN_PATH} ." \
	--build.bin "${MAIN_PATH}" --build.delay "100" \
	--build.exclude_dir "node_modules" \
	--build.include_ext "go" \
	--build.stop_on_error "false" \
	--misc.clean_on_exit true \
	--screen.clear_on_rebuild true \
	--log.main_only true

tailwind:
	@npm run tailwind

sync_assets:
	${SYNC_ASSETS_COMMAND}

build:
	@npm run build:tailwind
	@templ generate
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o bin/app_prod main.go
	@echo "compiled you application with all its assets to a single binary => bin/app_prod"

dev:
	@make -j4 templ server tailwind sync_assets