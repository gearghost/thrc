package dao

import (
	"database/sql"
	"fmt"
	"thrc/service/account/model"
	"time"
)

type AccountDAO struct {
	db *sql.DB
}

var (
	_CreateAccount             = "INSERT INTO t_account(`id`,`user_id`,`mobile`,`email`,`salt`,`password`,`remark`,`create_time`,`update_time`) values(?,?,?,?,?,?,?,?,?)"
	_CheckAccountExistByMobile = "SELECT COUNT(*) FROM t_account WHERE mobile = ?"
	_GetIdByMobile             = "SELECT id FROM t_account WHERE mobile = ?"
	_GetPasswordByMobile       = "SELECT password,salt FROM t_account WHERE mobile = ?"
	_GetPasswordById           = "SELECT password,salt FROM t_account WHERE id = ?"
	_GetUserIdById             = "SELECT user_id FROM t_account WHERE id = ?"
	_GetAccountByUID           = "SELECT * FROM t_account WHERE user_id = ?"
	_GetAccountByMobile        = "SELECT * FROM t_account WHERE mobile = ?"
)

func NewAccountDAO(database *sql.DB) *AccountDAO {
	if database == nil {
		return nil
	}
	return &AccountDAO{db: database}
}

func (a *AccountDAO) CreateAccount(account *model.Account) (int64, error) {
	result, err := a.db.Exec(_CreateAccount, account.Id, account.UserId,
		account.Mobile, account.Email, account.Salt,
		account.Password, account.Remark, account.CreateTime,
		account.UpdateTime)
	if err != nil {
		return -1, err
	}
	id, err := result.LastInsertId()
	if err != nil {
		return -1, err
	}
	return id, nil
}

func (a *AccountDAO) CheckAccountExistByMobile(mobile string) (int64, error) {
	rows, err := a.db.Query(_CheckAccountExistByMobile, mobile)
	if err != nil {
		return -1, err
	}
	var rowNum int64
	for rows.Next() {
		err := rows.Scan(&rowNum)
		if err != nil {
			continue
		}
	}
	rows.Close()
	return rowNum, nil
}

func (a *AccountDAO) GetIdByMobile(mobile string) (string, error) {
	rows, err := a.db.Query(_GetIdByMobile, mobile)
	if err != nil {
		return "", err
	}
	var id string
	for rows.Next() {
		err := rows.Scan(&id)
		if err != nil {
			continue
		}
	}
	rows.Close()
	return id, nil
}

func (a *AccountDAO) GetPasswordByMobile(mobile string) (string, string, error) {
	rows, err := a.db.Query(_GetPasswordByMobile, mobile)
	if err != nil {
		return "", "", err
	}
	var passwd, salt string
	for rows.Next() {
		err := rows.Scan(&passwd, &salt)
		if err != nil {
			continue
		}
	}
	rows.Close()
	return passwd, salt, err
}

func (a *AccountDAO) GetPasswordById(id string) (string, string, error) {
	rows, err := a.db.Query(_GetPasswordById, id)
	if err != nil {
		return "", "", err
	}
	var passwd, salt string
	for rows.Next() {
		err := rows.Scan(&passwd, &salt)
		if err != nil {
			continue
		}
	}
	rows.Close()
	return passwd, salt, err
}

func (a *AccountDAO) GetUserIdByID(id string) (string, error) {
	rows, err := a.db.Query(_GetUserIdById, id)
	if err != nil {
		return "", err
	}
	var userid string
	for rows.Next() {
		err := rows.Scan(&userid)
		if err != nil {
			continue
		}
	}
	rows.Close()
	return userid, nil
}

func (a *AccountDAO) GetAccountByUID(userid string) (*model.Account, error) {
	rows, err := a.db.Query(_GetAccountByUID, userid)
	if err != nil {
		return nil, err
	}
	var account model.Account
	for rows.Next() {
		err := rows.Scan(&account.Id, &account.UserId, &account.Mobile, &account.Email,
			&account.Salt, &account.Password, &account.Remark,
			&account.CreateTime, &account.UpdateTime)
		if err != nil {
			continue
		}
	}
	rows.Close()
	return &account, nil
}

func (a *AccountDAO) GetAccountByMobile(mobile string) (*model.Account, error) {
	rows, err := a.db.Query(_GetAccountByMobile, mobile)
	if err != nil {
		return nil, err
	}
	var account model.Account
	for rows.Next() {
		err := rows.Scan(&account.Id, &account.UserId, &account.Mobile, &account.Email,
			&account.Salt, &account.Password, &account.Remark,
			&account.CreateTime, &account.UpdateTime)
		if err != nil {
			continue
		}
	}
	rows.Close()
	return &account, nil
}

func (a *AccountDAO) UpdateAccountById(account *model.Account) (int64, error) {
	updatecmd := "UPDATE t_account SET "
	if account.Mobile != "" {
		updatecmd += fmt.Sprintf("mobile = '%s',", account.Mobile)
	}
	if account.Email != "" {
		updatecmd += fmt.Sprintf("email = '%s',", account.Email)
	}
	if account.Remark != "" {
		updatecmd += fmt.Sprintf("remark = '%s',", account.Remark)
	}
	var ids int64
	var err error
	if account.Id != "" {
		result, err := a.db.Exec(updatecmd+"update_time = ? WHERE id = ?", time.Now(), account.Id)
		if err != nil {
			return -1, err
		}
		ids, err = result.RowsAffected()
		if err != nil {
			return -1, err
		}
	}
	return ids, err
}

func (a *AccountDAO) UpdatePasswdById(password string, id string) (int64, error) {
	updatecmd := "UPDATE t_account SET "
	var ids int64
	if id != "" {
		if password != "" {
			updatecmd += fmt.Sprintf("password = '%s' WHERE id = '%s'", password, id)
			result, err := a.db.Exec(updatecmd)
			if err != nil {
				return -1, err
			}
			ids, err = result.RowsAffected()
			if err != nil {
				return -1, err
			}
		}
	}
	return ids, nil
}
