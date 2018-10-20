package profile

import (
	"encoding/json"
	"fmt"
	"github.com/gorilla/context"
	"github.com/tillson/stock-investments/http/response"
	"github.com/tillson/stock-investments/models"
	"net/http"
)

type Return struct {
	Name        string
	Username    string
	Balance     uint64
	PhoneNumber string
}

func (r Return) JSON() (string, error) {
	out, err := json.Marshal(r)
	if err != nil {
		return "", err
	}
	return string(out), err
}

func (r Profile) profileHandler(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	user, ok := context.Get(req, "user").(models.User)
	if !ok {
		response.ServerError.Write(w)
		return
	}

	userData := Return{
		Username:    user.Username,
		Name:        user.Name,
	}

	out, err := userData.JSON()
	if err != nil {
		response.ServerError.Write(w)
		return
	}

	fmt.Fprint(w, out)
}
