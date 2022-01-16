package main

import (
	"fmt"
	"net/http"
	"time"
)

//一个http请求  响应一个时间
func main() {
	http.HandleFunc("/time", func(rw http.ResponseWriter, r *http.Request) {
		timeStr := time.Now().In(time.FixedZone("CST", 8*3600)).Format("2006-01-02 15:04:05") + "测试内容"
		fmt.Println(timeStr)
		rw.Write([]byte(timeStr))
	})
	port := 9000
	fmt.Printf("listen %d server started!!!\r\n", port)
	err := http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
	if err != nil {
		fmt.Println(err)
	}
}
