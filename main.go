package main

import(
	"github.com/gin-gonic/gin"
	"html/template"
	"net/http"
	"strings"
)

func main(){
	//? Start Gin Engine for handling request and insert template files
	router := gin.Default()

	//? Setup function map for customize template function
	router.SetFuncMap(template.FuncMap{
		"upper": strings.ToUpper,
	})

	//? Load HTML pages from the defined folder to router
	router.LoadHTMLGlob("web/*.html")

	//? Specify the routing path
	//? The func(ctx *gin.Context) is where if user route "/", what should Gin does

	//? ctx.HTML would response the status is 200 (http.StatusOK)
	//? Route the request to index.html
	//? Then gin.H is to provide the "key":"value", 
	//? "key" is use for match the gomplate tag, "value" is the value of the key
	router.GET("/", func(ctx *gin.Context) {
		ctx.HTML(http.StatusOK, "index.html", gin.H{
			"content": "This is an index page...",
		})
	})

	router.GET("/about", func(ctx *gin.Context) {
		ctx.HTML(http.StatusOK, "about.html", gin.H{
			"content": "This is an about page...",
		})
	})

	//? Start to run the server with address and port
	router.Run("localhost:8080")
}
