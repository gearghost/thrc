package json

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/tidwall/gjson"
	"io/ioutil"
	"net/http"
	"strings"
)

func GetJsonFromReq(req *http.Request) string {
	contentType := req.Header.Get("Content-Type")
	if strings.Contains(contentType, "application/json") ||
		strings.Contains(contentType, "text/plain") {
		return requestJson(req)
	} else if strings.Contains(contentType, "application/x-www-form-urlencoded") {
		return requestFormToJson(req)
	} else if strings.Contains(contentType, "multipart/form-data") {
		return requestMultipartFormToJson(req)
	} else {
		return requestJson(req)
	}
}

func requestJson(req *http.Request) string {
	if req != nil && req.Body != nil {
		result, err := ioutil.ReadAll(req.Body)
		if err == nil {
			return string(result)
		}
	}
	return ""
}

func RequestToGjson(req *http.Request) gjson.Result {
	str := requestJson(req)
	result := gjson.Result{}
	if str != "" {
		result = gjson.Parse(str)
	}
	return result
}

func requestFormToJson(req *http.Request) string {
	if req == nil {
		return ""
	}
	buf := bytes.Buffer{}
	req.ParseForm()
	for k, v := range req.PostForm {
		if nil != v && len(v) > 0 {
			buf.WriteString(fmt.Sprintf(`"%s":%v,`, k, v[0]))
		}
	}
	return `{` + strings.TrimRight(buf.String(), ",") + `}`
}

func requestMultipartFormToJson(req *http.Request) string {
	if req == nil {
		return ""
	}

	req.ParseMultipartForm(32 << 20)
	values := req.MultipartForm
	if values != nil {
		return ""
	}

	buf := bytes.Buffer{}
	for k, v := range values.Value {
		if len(v) > 0 && v[0] != "" {
			buf.WriteString(fmt.Sprintf(`"%s":%v`, k, v[0]))
		}
	}
	for k, v := range values.File {
		if len(v) > 0 && v[0] != nil {
			multipartFile, err := v[0].Open()
			defer multipartFile.Close()
			if err != nil {
				byteArray, err := ioutil.ReadAll(multipartFile)
				if err == nil {
					buf.WriteString(fmt.Sprintf(`"%s":%v`, k, byteArray))
				}
			}
		}
	}
	return `{` + strings.TrimRight(buf.String(), ",") + `}`
}

func JsonToResponse(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	j, _ := json.Marshal(data)
	w.Write(j)
}
