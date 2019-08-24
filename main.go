package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/websocket"
)

var (
	upgrader = websocket.Upgrader{
		ReadBufferSize:  1024,
		WriteBufferSize: 1024,
		// TODO: CheckOrigin should validate a request header and only return true
		// for trusted connections to prevent cross-site request forgery.
		CheckOrigin: func(r *http.Request) bool { return true },
	}
)

func main() {
	setupRoutes()
	log.Println("Serving on 8080...")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func setupRoutes() {
	http.HandleFunc("/", homePage)           // simple http endpoint
	http.HandleFunc("/ws", webSocketHandler) // endpoint to create a websocket connection
}

func homePage(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Home Page")
}

func webSocketHandler(w http.ResponseWriter, r *http.Request) {
	// upgrade the request to a websocket connection
	ws, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println("Error establishing websocket:", err)
		return
	}

	// reader runs until it disconnects from the websocket.
	reader(ws)
}

// reader continually reads and responds to a single websocket connection.
// Returns only upon receiving an error reading / writing to the connection.
//
// Messages are received and transmitted as slices of bytes.
func reader(ws *websocket.Conn) {
	log.Println("Got a connection")

	for {
		messageType, messageBytes, err := ws.ReadMessage()
		if err != nil {
			log.Println("Error reading from client:", err)
			return
		}

		response := "Received client message: '" + string(messageBytes) + "'"
		log.Println(response)

		if err := ws.WriteMessage(messageType, []byte(response)); err != nil {
			log.Println("Error writing to client:", err)
			return
		}
	}
}
