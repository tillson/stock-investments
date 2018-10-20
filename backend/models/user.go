package models

import (
	"encoding/json"
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/jinzhu/gorm"
	"gitlab.com/t94j0/finance/config"
	"golang.org/x/crypto/bcrypt"
)

type User struct {
	gorm.Model

	db *gorm.DB

	Username     string `gorm:"unique"`
	PasswordHash []byte

	Name string
}

func NewUserFromID(id int, db *gorm.DB) (User, error) {
	var user User
	if err := db.Where("id = ?", id).First(&user).Error; err != nil {
		if !gorm.IsRecordNotFoundError(err) {
			return user, err
		}
	}

	user.db = db

	return user, nil
}

func NewUserFromUsername(username string, db *gorm.DB) (User, error) {
	var user User
	if err := db.Where("username = ?", username).First(&user).Error; err != nil {
		if !gorm.IsRecordNotFoundError(err) {
			return user, err
		}
	}

	user.db = db

	return user, nil
}

func NewUserList(db *gorm.DB, usernames ...string) ([]User, error) {
	users := make([]User, 0)
	for _, username := range usernames {
		var tmpU User
		if err := db.Where("username = ?", username).First(&tmpU).Error; err != nil {
			return users, err
		}
		tmpU.SetDB(db)
		users = append(users, tmpU)
	}
	return users, nil
}

func CreateUser(username, password string, db *gorm.DB) (User, error) {
	passwordHash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return User{}, err
	}

	user := User{
		Username:     username,
		PasswordHash: passwordHash,
	}

	if err := db.Create(&user).Error; err != nil {
		return User{}, err
	}

	return user, nil
}

// Exists returns true if the user exists
func (user *User) Exists() bool {
	return user.ID != 0
}

func (user *User) SetDB(db *gorm.DB) {
	user.db = db
}

func (user *User) JWTTokenJSON() (string, error) {
	token := jwt.NewWithClaims(config.GetJWTSigningMethod(), jwt.MapClaims{
		"id":  user.ID,
		"exp": time.Now().Add(24 * time.Hour).Unix(),
	})

	tokenString, err := token.SignedString([]byte(config.GetSecret()))
	if err != nil {
		return "", err
	}

	j := struct {
		AccessToken string `json:"access_token"`
	}{AccessToken: tokenString}

	out, err := json.Marshal(j)
	if err != nil {
		return "", err
	}

	return string(out), nil
}

func (user *User) ValidPassword(password string) (bool, error) {
	err := bcrypt.CompareHashAndPassword(user.PasswordHash, []byte(password))
	if err == bcrypt.ErrMismatchedHashAndPassword {
		return false, nil
	}
	if err != nil {
		return false, err
	}

	return true, nil
}

func (user *User) UpdatePassword(password string) error {
	passwordHash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	if err := user.db.Model(&user).Update("password_hash", passwordHash).Error; err != nil {
		return err
	}

	return nil
}
