package main

import (
	"fmt"

	"gitlab.com/t94j0/finance/db"
	"gitlab.com/t94j0/finance/http/server"
)

func main() {
	finDb, err := db.Initialize()
	if err != nil {
		panic(err)
	}
	defer finDb.Close()

	svr := server.NewServer(finDb)
	svr.InitializeHandlers()
	fmt.Println("listening on port :8080")
	if err := svr.Serve(":8080"); err != nil {
		panic(err)
	}
}
