package main

import(
	"github.com/gin-gonic/gin"
	"html/template"
	"net/http"
	"strings"
)

func main(){
	router := gin.Default()

	router.SetFuncMap(template.FuncMap{
		"upper": strings.ToUpper,
	})

	router.LoadHTMLGlob("web/*.html")

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

	router.Run("localhost:8083")
	
}
