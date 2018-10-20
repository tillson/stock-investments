package profile

import (
	"encoding/json"
	"io"
	"net/http"
	"time"
)

type GetStocksInput struct {
	Identifiers []string `json:"identifiers"`
}

func NewGetStocksInput(r io.Reader) (GetStocksInput, error){
	var gsi GetStocksInput
	if err := json.NewDecoder(r).Decode(&gsi); err != nil {
		return gsi, err
	}
	return gsi, nil
}

type StockHistory struct {
	Time time.Time
	Price float64
}

type GetStocksOutput struct {
	Ticker string `json:"ticker"`
	Stocks []StockHistory `json:"stocks"`
}

func (g GetStocksOutput) JSON() (string, error)  {
	data, err := json.Marshal(g)
	if err != nil {
		return "", err
	}
	return string(data), nil
}

// Accept: application/json GET "https://www.blackrock.com/tools/hackathon/security-data?identifiers=IXN"
func (r Stocks) getStocks(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "application/json")
}
