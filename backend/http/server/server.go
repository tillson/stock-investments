package server

import (
	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
	"github.com/stripe/stripe-go"
	"gitlab.com/t94j0/finance/config"
	"gitlab.com/t94j0/finance/http/middleware"
	"gitlab.com/t94j0/finance/http/server/authentication"
	"gitlab.com/t94j0/finance/http/server/bank"
	"gitlab.com/t94j0/finance/http/server/message"
	"gitlab.com/t94j0/finance/http/server/profile"
	"net/http"
)

type Server struct {
	router *mux.Router
}

var db *gorm.DB

func NewServer(mDb *gorm.DB) *Server {
	router := mux.NewRouter()
	db = mDb
	stripe.Key = config.GetStripeSecret()
	return &Server{router: router}
}

func (s *Server) InitializeHandlers() {
	m := middleware.New(db)

	authRouter := s.router.PathPrefix("/auth").Subrouter()
	auth := authentication.Authentication{Router: authRouter, DB: db}
	auth.InitializeHandlers()

	profileRouter := s.router.PathPrefix("/profile").Subrouter()
	profileRouter.Use(m.GetUserMiddleware)
	profileHdlr := profile.Profile{Router: profileRouter, DB: db}
	profileHdlr.InitializeHandlers()

	bankRouter := s.router.PathPrefix("/bank").Subrouter()
	bankRouter.Use(m.GetUserMiddleware)
	bankHdlr := bank.Bank{Router: bankRouter, DB: db}
	bankHdlr.InitializeHandlers()

	messageRouter := s.router.PathPrefix("/messages").Subrouter()
	messageRouter.Use(m.GetUserMiddleware)
	msg := message.Message{Router: messageRouter, DB: db}
	msg.InitializeHandlers()

	s.router.Use(m.LoggingMiddleware)
}

func (s *Server) Serve(port string) error {
	return http.ListenAndServe(port, s.router)
}
