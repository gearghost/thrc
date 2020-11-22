package dao

import (
	"database/sql"
	"errors"
	"fmt"
	"thrc/service/user/model"
	"thrc/tools/datetime"
	"time"
)

type UserDAO struct {
	db *sql.DB
}

var (
	_CreateUser      = "INSERT INTO t_user(`user_id`,`name`,`mobile`,`email`,`sex`,`birthday`,`age`,`avatar_url`,`remark`,`register_time`,`update_time`) values(?,?,?,?,?,?,?,?,?,?,?)"
	_GetUserByUID    = "SELECT name,mobile,email,sex,birthday,age,avatar_url,remark,register_time,update_time FROM t_user WHERE user_id = ?"
	_GetUserByMobile = "SELECT name,mobile,email,sex,birthday,age,avatar_url,remark,register_time,update_time FROM t_user WHERE mobile = ?"
)

func NewUserDAO(database *sql.DB) *UserDAO {
	if database == nil {
		return nil
	}
	return &UserDAO{db: database}
}

func (u *UserDAO) CreateUser(user *model.User) (int64, error) {
	age := datetime.GetAgeByBirthday(user.Birthday)
	result, err := u.db.Exec(_CreateUser, user.UserId, user.Name,
		user.Mobile, user.Email,
		user.Sex, user.Birthday, age, user.AvatarURL,
		user.Remark, time.Now(), time.Now())
	if err != nil {
		return -1, err
	}
	id, err := result.LastInsertId()
	if err != nil {
		return -1, err
	}
	return id, nil
}

func (u *UserDAO) GetUserByUID(userid string) (*model.User, error) {
	rows, err := u.db.Query(_GetUserByUID, userid)
	if err != nil {
		return nil, err
	}
	var user model.User
	for rows.Next() {
		err := rows.Scan(&user.Name, &user.Mobile, &user.Email, &user.Sex, &user.Birthday, &user.Age, &user.AvatarURL, &user.Remark, &user.RegisterTime, &user.UpdateTime)
		if err != nil {
			continue
		}
	}
	rows.Close()
	return &user, nil
}

func (u *UserDAO) GetUserByMobile(mobile string) (*model.User, error) {
	rows, err := u.db.Query(_GetUserByMobile, mobile)
	if err != nil {
		return nil, err
	}
	var user model.User
	for rows.Next() {
		err := rows.Scan(&user.Name, &user.Mobile, &user.Email, &user.Sex, &user.Birthday, &user.Age, &user.AvatarURL, &user.Remark, &user.RegisterTime, &user.UpdateTime)
		if err != nil {
			continue
		}
	}
	rows.Close()
	return &user, nil
}

func (u *UserDAO) UpdateUserByUID(user *model.User, userid string) (int64, error) {
	updatecmd := "UPDATE t_user SET "
	if user.Name != "" {
		updatecmd += fmt.Sprintf("name = '%s',", user.Name)
	}
	if user.Mobile != "" {
		updatecmd += fmt.Sprintf("mobile = '%s',", user.Mobile)
	}
	if user.Email != "" {
		updatecmd += fmt.Sprintf("email = '%s',", user.Email)
	}
	if user.Sex != "" {
		updatecmd += fmt.Sprintf("sex = '%s',", user.Sex)
	}
	if user.Birthday != "" {
		updatecmd += fmt.Sprintf("birthday = '%s',", user.Birthday)
		age := datetime.GetAgeByBirthday(user.Birthday)
		updatecmd += fmt.Sprintf("age='%s',", age)
	}
	if user.AvatarURL != "" {
		updatecmd += fmt.Sprintf("avatar_url = '%s',", user.AvatarURL)
	}
	if user.Remark != "" {
		updatecmd += fmt.Sprintf("remark = '%s',", user.Remark)
	}
	var ids int64
	if userid != "" {
		result, err := u.db.Exec(updatecmd+"update_time = ? WHERE user_id = ?", time.Now(), userid)
		if err != nil {
			return -1, err
		}
		ids, err = result.RowsAffected()
		if err != nil {
			return -1, err
		}
	} else {
		return -1, errors.New("userid must not be empty")
	}
	return ids, nil
}

func (u *UserDAO) UpdateUserByMobile(user *model.User, mobile string) (int64, error) {
	updatecmd := "UPDATE t_user SET "
	if user.Name != "" {
		updatecmd += fmt.Sprintf("name = '%s',", user.Name)
	}
	if user.Mobile != "" {
		updatecmd += fmt.Sprintf("mobile = '%s',", user.Mobile)
	}
	if user.Email != "" {
		updatecmd += fmt.Sprintf("email = '%s',", user.Email)
	}
	if user.Sex != "" {
		updatecmd += fmt.Sprintf("sex = '%s',", user.Sex)
	}
	if user.Birthday != "" {
		updatecmd += fmt.Sprintf("birthday = '%s',", user.Birthday)
		age := datetime.GetAgeByBirthday(user.Birthday)
		updatecmd += fmt.Sprintf("age='%s',", age)
	}
	if user.AvatarURL != "" {
		updatecmd += fmt.Sprintf("avatar_url = '%s',", user.AvatarURL)
	}
	if user.Remark != "" {
		updatecmd += fmt.Sprintf("remark = '%s',", user.Remark)
	}
	var ids int64
	if mobile != "" {
		result, err := u.db.Exec(updatecmd+"update_time = ? WHERE mobile = ?", time.Now(), mobile)
		if err != nil {
			return -1, err
		}
		ids, err = result.RowsAffected()
		if err != nil {
			return -1, err
		}
	} else {
		return -1, errors.New("mobile must not be empty")
	}
	return ids, nil
}

func (u *UserDAO) UpdateUserByEmail(user *model.User, email string) (int64, error) {
	updatecmd := "UPDATE t_user SET "
	if user.Name != "" {
		updatecmd += fmt.Sprintf("name = '%s',", user.Name)
	}
	if user.Mobile != "" {
		updatecmd += fmt.Sprintf("mobile = '%s',", user.Mobile)
	}
	if user.Email != "" {
		updatecmd += fmt.Sprintf("email = '%s',", user.Email)
	}
	if user.Sex != "" {
		updatecmd += fmt.Sprintf("sex = '%s',", user.Sex)
	}
	if user.Birthday != "" {
		updatecmd += fmt.Sprintf("birthday = '%s',", user.Birthday)
		age := datetime.GetAgeByBirthday(user.Birthday)
		updatecmd += fmt.Sprintf("age='%s',", age)
	}
	if user.AvatarURL != "" {
		updatecmd += fmt.Sprintf("avatar_url = '%s',", user.AvatarURL)
	}
	if user.Remark != "" {
		updatecmd += fmt.Sprintf("remark = '%s',", user.Remark)
	}
	var ids int64
	if email != "" {
		result, err := u.db.Exec(updatecmd+"update_time = ? WHERE email = ?", time.Now(), email)
		if err != nil {
			return -1, err
		}
		ids, err = result.RowsAffected()
		if err != nil {
			return -1, err
		}
	} else {
		return -1, errors.New("email must not be empty")
	}
	return ids, nil
}

func (u *UserDAO) UpdateAvatarByUID(avatarURL string, userid string) (int64, error) {
	var ids int64
	if avatarURL != "" && userid != "" {
		updatecmd := fmt.Sprintf("UPDATE t_user SET avatar_url = '%s',update_time = NOW() WHERE user_id = '%s'", avatarURL, userid)
		result, err := u.db.Exec(updatecmd)
		if err != nil {
			return -1, err
		}
		ids, err = result.RowsAffected()
		if err != nil {
			return -1, err
		}
	} else {
		return -1, errors.New("avatar or userid must not be empty")
	}

	return ids, nil
}
