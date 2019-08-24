# This is a multi-stage Dockerfile with two stages: builder and production.
# Start with a golang image that can build our full executable
FROM golang:1.12.9 AS builder
# Create an /app directory to put the project code
RUN mkdir /app
ADD . /app
WORKDIR /app
# Build our application's binary executable
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# The lightweight scratch image to run our app in.
FROM alpine:latest as production
# Copy the output from our builder stage to our production stage
COPY --from=builder /app .
# Kick off our newly compiled binary executable
CMD ["./main"]