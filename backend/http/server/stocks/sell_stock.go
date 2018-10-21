package profile

import (
	"encoding/json"
	"fmt"
	"github.com/gorilla/context"
	"github.com/tillson/stock-investments/http/response"
	"github.com/tillson/stock-investments/models"
	"io"
	"net/http"
)

type SellStockInput struct {
	Ticker string
	Quantity uint
}
func NewSellStockInput(r io.Reader) (BuyStockInput, error) {
	var b BuyStockInput
	if err := json.NewDecoder(r).Decode(&b); err != nil {
		return b, err
	}
	return b, nil
}

func (r Stocks) sellStocks(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	user, ok := context.Get(req, "user").(models.User)
	if !ok {
		response.ServerError.Write(w)
		return
	}

	stockReq, err := NewSellStockInput(req.Body)
	if err != nil {
		response.ServerError.Write(w)
		return
	}

	tx, err := user.SellStock(stockReq.Ticker, stockReq.Quantity)
	if err == models.NotEnoughStocksErr{
		response.NewResponse(400, models.NotEnoughStocksErr).Write(w)
		return
	} else if err != nil {
		response.ServerError.Write(w)
		return
	}

	type transaction struct {
		Ticker string `json:"ticker"`
		PriceAtTime float64 `json:"price_at_time"`
		Type string `json:"type"`
		Quantity uint `json:"quantity"`
	}

	txx := transaction{
		Ticker: tx.Ticker,
		PriceAtTime: tx.PriceAtTime,
		Type: string(tx.Type),
		Quantity: tx.Quantity,
	}

	out, err := json.Marshal(txx)
	if err != nil {
		response.ServerError.Write(w)
		return
	}

	fmt.Fprint(w, string(out))

	response.Nil.Write(w)
}