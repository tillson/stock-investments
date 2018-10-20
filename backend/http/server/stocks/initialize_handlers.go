package profile

import (
	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
)

type Stocks struct {
	Router *mux.Router
	DB     *gorm.DB
}

func (r Profile) InitializeHandlers() {
	r.Router.
		HandleFunc("/", r.getStocks).
		Methods("GET")
}
