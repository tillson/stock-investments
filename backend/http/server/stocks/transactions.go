package profile

import (
	"encoding/json"
	"fmt"
	"github.com/gorilla/context"
	"github.com/tillson/stock-investments/http/response"
	"github.com/tillson/stock-investments/models"
	"log"
	"net/http"
)

func (r Stocks) getTransactions(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	user, ok := context.Get(req, "user").(models.User)
	if !ok {
		response.ServerError.Write(w)
		return
	}

	txs, err := user.GetTransactions()
	if err != nil {
		log.Println(err)
		response.ServerError.Write(w)
		return
	}

	out, err := json.Marshal(txs)
	if err != nil {
		log.Println(err)
		response.ServerError.Write(w)
		return
	}

	fmt.Fprintln(w, string(out))
}
