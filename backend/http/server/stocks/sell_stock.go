package profile

import (
	"encoding/json"
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

	err = user.SellStock(stockReq.Ticker, stockReq.Quantity)
	if err == models.NotEnoughStocksErr{
		response.NewResponse(400, models.NotEnoughStocksErr).Write(w)
		return
	} else if err != nil {
		response.ServerError.Write(w)
		return
	}

	response.Nil.Write(w)
}