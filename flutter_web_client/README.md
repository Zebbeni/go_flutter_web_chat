# flutter_web_client
This is an example flutter-for-web client to establish a websocket connection using Flutter.

# Running the Client

## Using localhost
- Both flutter_web_client and the server are set up to run on 8080. There are a couple options to avoid conflicts on this port:

### Option 1 (debug from VSCode)
- Run the websocket server (either `go run main.go` or build the docker image and run `docker run -p 8080:8080 -it go_websocket_server`)
- Run the client in VS Code using *Debug > Start Debugging*. This runs the client on a free (non-8080) port and opens a chrome window to that address.

### Option 2 (change ports)
- Change the server code to serve on 8081 (instead of 8080)
- Run the websocket server (either `go run main.go` or build the docker image and run `docker run -p 8080:8080 -it go_websocket_server`)
- Run `webdev serve` in flutter_web_client and wait for client to build
- Open a browser to localhost:8080