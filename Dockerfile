

# RUN apk add --no-cache go

# COPY <<EOF ./main.go
# package yougo

# import "fmt"

# func main() {
#   fmt.Println("hello, world")
# }
# EOF

# COPY . .

# RUN go build -o /bin/hello ./main.go

# # Build final image to deploy
# # FROM alpine:latest
# FROM scratch

# # RUN apk add --no-cache yt-dlp

# COPY --from=go-builder /bin/hello /bin/hello

# CMD ["/bin/hello"]

# # Build go app
FROM alpine:latest as yt-dlp

RUN apk add --no-cache yt-dlp


# STEP 1 build executable binary
FROM golang:alpine AS builder

RUN adduser -D -g '' appuser
RUN mkdir /app

WORKDIR /app

# copy go mod and sum files
COPY go.mod .
COPY go.sum .

RUN go mod download

# copy the source code
COPY main.go .

# build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o /go/bin/app .

RUN chmod 0555 /go/bin/app

# STEP 2 build a small image
# start from scratch
FROM scratch

WORKDIR /app

COPY --from=builder /etc/passwd /etc/passwd

USER appuser

# Copy in yt-dlp
COPY --from=yt-dlp /bin/yt-dlp /bin/yt-dlp
# Copy our static executable
COPY --from=builder /go/bin/app ./app_binary

EXPOSE 5000

CMD ["./app_binary"]