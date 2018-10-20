package config

import "github.com/dgrijalva/jwt-go"

var (
	path       = "/tmp/test.db"
	secret     = "DoYouBelieveInLifeAfterLove123!!!%!*%%"
	debug      = false
	jwtSigning = jwt.SigningMethodHS256
)

var DB = "postgres://postgres:thisisabadpassword@35.185.44.193/stocks?sslmode=disable"

func GetDebug() bool {
	return debug
}

func GetSecret() string {
	return secret
}

func GetPath() string {
	return path
}

func GetJWTSigningMethod() jwt.SigningMethod {
	return jwtSigning
}
