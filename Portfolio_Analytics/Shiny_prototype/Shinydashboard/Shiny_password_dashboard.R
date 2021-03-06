rm(list = ls())
library(shiny)
library(shinydashboard)
# loading modules 
source("global.R")

Logged = FALSE;
my_username <- "test"
my_password <- "test"

ui1 <- function(){
  tagList(
    div(id = "login",
        wellPanel(textInput("userName", "Username"),
                  passwordInput("passwd", "Password"),
                  br(),actionButton("Login", "Log in"))),
    tags$style(type="text/css", "#login {font-size:10px;   text-align: left;position:absolute;top: 40%;left: 50%;margin-top: -100px;margin-left: -150px;}")
  )}

#DJR: Tag List needed
ui2 <- function(){tagList(tabPanel("Test","Hallo"))}



ui = (htmlOutput("page"))




server = (function(input, output,session) {
  
  USER <- reactiveValues(Logged = Logged)
  
  observe({ 
    if (USER$Logged == FALSE) {
      if (!is.null(input$Login)) {
        if (input$Login > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          Id.username <- which(my_username == Username)
          Id.password <- which(my_password == Password)
          if (length(Id.username) > 0 & length(Id.password) > 0) {
            if (Id.username == Id.password) {
              USER$Logged <- TRUE
            } 
          }
        } 
      }
    }    
  })
  
  
  
  #LoginPage
  observe({
    if (USER$Logged == FALSE) {
      
      output$page <- renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui1())))
      })
    }
    
    
    
    
    
    
   #Main Page 
    if (USER$Logged == TRUE) 
    {
      callModule(tableTest, "test")
      output$page <- renderUI({
        div(class="outer",do.call(navbarPage,c(inverse=TRUE,title = "Contratulations you got in!",ui2())))
        
        
        
        
        
      })
      print(ui)
    }
  })
})

runApp(list(ui = ui, server = server))