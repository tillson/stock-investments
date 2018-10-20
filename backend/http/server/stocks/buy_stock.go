package profile

import (
	"encoding/json"
	"github.com/gorilla/context"
	"github.com/tillson/stock-investments/http/response"
	"github.com/tillson/stock-investments/models"
	"io"
	"net/http"
)

type BuyStockInput struct {
	Ticker string
	Quantity uint
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
		response.ServerError.Write(w)
		return
	}

	if err := user.BuyStock(stockReq.Ticker, stockReq.Quantity); err != nil {
		response.ServerError.Write(w)
		return
	}

	response.Nil.Write(w)
}