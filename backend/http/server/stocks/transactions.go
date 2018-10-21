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

	type transaction struct {
		Ticker string `json:"ticker"`
		PriceAtTime float64 `json:"price_at_time"`
		Type string `json:"type"`
		Quantity uint `json:"quantity"`
	}

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

	transactions := make([]transaction, 0)
	for _, tx := range txs {
		transactions = append(transactions, transaction{
			Ticker: tx.Ticker,
			PriceAtTime: tx.PriceAtTime,
			Type: string(tx.Type),
			Quantity: tx.Quantity,
		})
	}

	out, err := json.Marshal(transactions)
	if err != nil {
		log.Println(err)
		response.ServerError.Write(w)
		return
	}

	fmt.Fprintln(w, string(out))
}
