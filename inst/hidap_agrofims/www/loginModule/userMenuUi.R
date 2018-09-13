output$uiUserProfile <- renderUI({
  if (USER$Logged == TRUE) {
    fluidRow(
      box(
        title = tagList(shiny::icon("user"), "My profile"),
        status = "primary", solidHeader = TRUE,
        collapsible = TRUE, width = 12,
        column(width = 6,
          disabled(textInput(inputId = "prfUsername", label="Email/Username", value=USER$username)),
          disabled(textInput(inputId = "prfName", label="Name", value=USER$fname)),
          disabled(textInput(inputId = "prfLname", label="Last name", value=USER$lname)),
          disabled(textInput(inputId = "prfOrg", label="Organization", value=USER$org)),
          disabled(textInput(inputId = "prfCountry", label="Country", value=USER$country))
        )
      )
    )
  }
})

output$uiChangePass <- renderUI({
  if (USER$Logged == TRUE) {
    fluidRow(
      box(
        title = tagList(shiny::icon("lock"), "Change password"),
        status = "primary", solidHeader = TRUE,
        collapsible = TRUE, width = 12,
        column(width = 6,
          h3("Password Change"),
          passwordInput("chngPassCurrent", "Current password: "),
          passwordInput("chngPassNew", "New password (at least 8 and at most 12 characters): "),
          passwordInput("chngPassNewRep", "Re-enter new password: "),
          actionButton("btChangePass", "Update")
        )#end column
      ) #end box
    )#end fluidrow
  }
})

output$uiRegister <- renderUI({

  if (USER$Logged == FALSE) {
    removeModal()
    fluidRow(
      box(
        title = tagList(shiny::icon("user"), "Create account"),
        status = "primary", solidHeader = TRUE,
        collapsible = TRUE, width = 12,
        column(width = 6,
            h3("New Account"),
            p("Fields with (*) must be completed"),
            textInput("newUsrMail", "* Email Address (username): ") %>%
              shinyInput_label_embed(
                icon("info") %>%
                  bs_embed_tooltip(title = "Alphanumeric (lower and uppercase) and _.-+ Only",  placement = "top")
              ),

            passwordInput("newUsrPass", "* Password (at least 8 and at most 12 characters): ") %>%
              shinyInput_label_embed(
                icon("info") %>%
                  bs_embed_tooltip(title = "Alphanumeric (lower and uppercase) and \n ;_-,.#@?!%&* Only")
              ),
            passwordInput("newUsrPassRepeat", "* Re-enter Password: "),
            textInput("newUsrFName", "* Name: "),
            textInput("newUsrLName", "* Lastname: "),
            textInput("newUsrOrg", "* Organization: "),
            selectizeInput("countrySelection", choices = listCountries, label="* Country", options = list(maxOptions = 5 , selected = NULL,  placeholder = 'Select Country')),
            actionButton("btCreateUser", "Create"),
            br(), br(),
            # actionLink("ForgotPass", "Forgot your password?"),br(),
            a( "Forgot your password?", href="#shiny-tab-forgotPass","data-toggle"="tab"),
            br(),
            "Already have an account? " , actionLink("btLogIn2", "Log in "), " instead."
        ) #end column
      )#end box
    )#end
  }


})
output$registerMsg <- renderText("")

output$uiForgotPass <- renderUI({
  if (USER$Logged == FALSE) {
    removeModal()
    fluidRow(
      box(
        title = tagList(shiny::icon("lock"), "Password reset"),
        status = "primary", solidHeader = TRUE,
        collapsible = TRUE, width = 12,
        column(width = 6,
          h3("Forgot your password?"),
          # br(),
          p("Write down your email (username) you used to create your account and a password will be sent there."),
          textInput("userMailReset", "Email (username):"),
          br(),
          actionButton("ResetPass", "Reset my password"),
          br(), br(),
          "Not a user yet? ", a( "Create an account.", href="#shiny-tab-register","data-toggle"="tab"),
          br(),
          "Already have an account? " , actionLink("btLogIn3", "Log in "), " instead."
        )#end column
      )#end box
    )#end fluidrow
  }
})

# each login link must have its own reactive function
observeEvent(input$btLogIn2, {
  showModal(loginModalMenu())
})
observeEvent(input$btLogIn3, {
  showModal(loginModalMenu())
})

