package datetime

import (
	"fmt"
	"strconv"
	"strings"
	"time"
)

const (
	timeLayout = "2006-01-02 15:04:05"
)

func StrToTime(str string) (time.Time, error) {
	loc, _ := time.LoadLocation("Local")
	t, err := time.ParseInLocation(timeLayout, str, loc)
	return t, err
}

func TimeToStr(formatTime time.Time) string {
	tmp := time.Date(formatTime.Year(), formatTime.Month(),
		formatTime.Day(), formatTime.Hour(),
		formatTime.Minute(), formatTime.Second(),
		formatTime.Nanosecond(), time.Local)
	str := tmp.Format(timeLayout)
	return strings.Split(str, " ")[0]

}

func TimeStrWithoutLine(formatTime time.Time) string {
	str := strings.Split(TimeToStr(formatTime), "-")
	return fmt.Sprintf("%s%s%s", str[0], str[1], str[2])
}

func GetAgeByBirthday(birthday string) string {
	birthdayStr := strings.Split(birthday, "-")
	birthYear, _ := strconv.Atoi(birthdayStr[0])
	age := time.Now().Year() - birthYear
	return strconv.Itoa(age)
}
