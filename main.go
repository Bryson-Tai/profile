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
	router.LoadHTMLGlob("page/*.html")

	//? Specify the routing path
	//? The func(ctx *gin.Context) is where if user route "/", what should Gin does
	router.GET("/", indexHandler)
	router.GET("/about", aboutHandler)

	//? Start to run the server with address and port
	router.Run("localhost:8080")
}

//? 1. ctx.HTML would response the status is 200 (http.StatusOK)
//? 2. Route the request to index.html
//? 3.1. Then gin.H is to provide the "key":"value", 
//? 3.2. "key" is use for match the gomplate tag, "value" is the value of the key
func indexHandler(ctx *gin.Context){
	ctx.HTML(http.StatusOK, "index.html", gin.H{
		"content": "This is an index page...",
	})
}

func aboutHandler(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "about.html", gin.H{
		"content": "This is an about page...",
	})
}
