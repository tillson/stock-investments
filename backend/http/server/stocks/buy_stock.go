package profile

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"

	"github.com/gorilla/context"
	"github.com/tillson/stock-investments/http/response"
	"github.com/tillson/stock-investments/models"
)

type BuyStockInput struct {
	Ticker   string `json:"ticker"`
	Quantity uint   `json:"quantity"`
}

func NewBuyStockInput(r io.Reader) (BuyStockInput, error) {
	var b BuyStockInput
	if err := json.NewDecoder(r).Decode(&b); err != nil {
		return b, err
	}
	return b, nil
}

func (r Stocks) buyStocks(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	user, ok := context.Get(req, "user").(models.User)
	if !ok {
		response.ServerError.Write(w)
		return
	}

	stockReq, err := NewBuyStockInput(req.Body)
	if err != nil {
		log.Println(err)
		response.ServerError.Write(w)
		return
	}

	tx, err := user.BuyStock(stockReq.Ticker, stockReq.Quantity)
	if err == models.NotEnoughMoneyErr {
		response.NewResponse(400, models.NotEnoughMoneyErr).Write(w)
		return
	} else if err != nil {
		log.Println(err)
		response.ServerError.Write(w)
		return
	}

	type transaction struct {
		Ticker      string  `json:"ticker"`
		PriceAtTime float64 `json:"price_at_time"`
		Type        string  `json:"type"`
		Quantity    uint    `json:"quantity"`
	}

	txx := transaction{
		Ticker:      tx.Ticker,
		PriceAtTime: tx.PriceAtTime,
		Type:        string(tx.Type),
		Quantity:    tx.Quantity,
	}

	out, err := json.Marshal(txx)
	if err != nil {
		response.ServerError.Write(w)
		return
	}

	fmt.Fprint(w, string(out))
}
