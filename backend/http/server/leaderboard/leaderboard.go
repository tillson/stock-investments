package profile

import (
	"net/http"
)

func (l Leaderboard) leaderboardHandler(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "application/json")

}
