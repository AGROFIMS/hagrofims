#### Log in module ###
print("Load all modules")
USER <- reactiveValues(Logged = FALSE, username = NULL, id = NULL, list = NULL, fname = NULL, lname = NULL, org = NULL, country = NULL)

listCountries <- c('Aruba','Afghanistan','Angola','Anguilla','Albania','Andorra','United Arab Emirates','Argentina','Armenia','American Samoa','Antarctica','French Southern Territories','Antigua and Barbuda','Australia','Austria','Azerbaijan','Burundi','Belgium','Benin','Bonaire','Burkina Faso','Bangladesh','Bulgaria','Bahrain','Bahamas','Bosnia and Herzegowina','Belarus','Belize','Bermuda','Bolivia','Brazil','Barbados','Brunei','Bhutan','Burma','Bouvet Island','Botswana','Byelorusian SSR (Former)','Central African Republic','Canada','Cocos (Keeling) Islands','Switzerland','Chile','China','CIPHQ','Cote dIvoire','Cameroon','Congo','Congo','Cook Islands','Colombia','Comoros','Cape Verde','Costa Rica','Czechoslovakia (Former)','Cuba','Curacao','Christmas Island (Australia)','Cayman Islands','Cyprus','Czech Republic','German Democratic Republic','Germany','Djibouti','Dominica','Denmark','Dominican Republic','Algeria','Ecuador','Egypt','Eritrea','Western Sahara','Spain','Estonia','Ethiopia','Finland','Fiji','Falkland Islands (Malvinas)','France','Faroe Islands','Micronesia','Gabon','United Kingdom','Georgia','Ghana','Gibraltar','Guinea','Guadeloupe','Gambia','Guinea-Bissau','Equatorial Guinea','Greece','Grenada','Greenland','Guatemala','French Guiana','Guam','Guyana','Hong Kong','Heard and Mc Donald Islands','Honduras','Croatia','Haiti','Hungary','Indonesia','India','British Indian Ocean Territory','Ireland','Iran','Iraq','Iceland','Israel','Italy','Jamaica','Jordan','Japan','Kazakhstan','Kenya','Kyrgyzstan','Cambodia','Kiribati','Saint Kitts and Nevis','Korea','Kuwait','Lao People s Democratic Republic','Lebanon','Liberia','Libyan Arab Jamahiriya','Saint Lucia','Liechtenstein','Sri Lanka','Lesotho','Lithuania','Luxemburg','Latvia','Macau','Saint Martin (French part)','Macedonia','Morocco','Monaco','Moldova','Madagascar','Maldives','Mexico','Marshall Islands','Mali','Malta','Myanmar','Mongolia','Northern Mariana Islands','Mozambique','Mauritania','Montserrat','Martinique','Mauritius','Malawi','Malaysia','Mayotte','Namibia','New Caledonia','Niger','Norfolk Island','Nigeria','Nicaragua','Niue','Netherlands','Norway','Nepal','Nauru','Neutral Zone (Former)','New Zealand','Oman','Pakistan','Palestine','Panama','Pitcairn Islands','Peru','Philippines','Palau','Papua New Guinea','Poland','Puerto Rico','Korea','Portugal','Paraguay','French Polynesia','Qatar','Reunion','Romania','Russian Federation','Rwanda','Saudi Arabia','Serbia and Montenegro','Scotland','Sudan','Senegal','Singapore','Saint Helena','Svalbard and Jan Mayen Islands','Solomon Islands','Sierra Leone','El Salvador','San Marino','Somalia','Saint Pierre and Miquelon','Serbia','Sao Tome e Principe','Union of Soviet Socialist Republics (Former)','Surinam','Slovakia','Slovenia','Sweden','Swaziland','Seychelles','Syrian Arab Republic','Turks and Caicos Islands','Chad','Togo','Thailand','Tajikistan','Tokelau','Turkmenistan','East Timor','Tonga','Trinidad and Tobago','Tunisia','Turkey','Tuvalu','Taiwan','Tanzania','Uganda','Ukraine','United States Misc. Pacific Islands','unknown','Uruguay','United States of America','Uzbekistan','Vatican City State','Saint Vincent and the Grenadines','Venezuela','British Virgin Islands','Virgin Islands (US)','Viet Nam','Vanuatu','Wallis and Fortuna Islands_','Samoa','Yemen','Yugoslavia (Former)','South Africa','Zaire','Zambia','Zimbabwe'
)

output$uiUserProfile <- renderUI({
  if (USER$Logged == TRUE) {
    wellPanel(
      h2("My Profile"),
      disabled(textInput(inputId = "prfUsername", label="Email/Username", value=USER$username)),
      disabled(textInput(inputId = "prfName", label="Name", value=USER$fname)),
      disabled(textInput(inputId = "prfLname", label="Last name", value=USER$lname)),
      disabled(textInput(inputId = "prfOrg", label="Organization", value=USER$org)),
      disabled(textInput(inputId = "prfCountry", label="Country", value=USER$country))
    )
  }
})

output$uiChangePass <- renderUI({
  if (USER$Logged == TRUE) {
    wellPanel(
      h3("Password Change"),
      passwordInput("chngPassCurrent", "Current password: "),
      passwordInput("chngPassNew", "New password (at least 8 and at most 12 characters): "),
      passwordInput("chngPassNewRep", "Re-enter new password: "),
      actionButton("btChangePass", "Update")
    )
  }
})

output$mssgChngPass <- renderText("")

output$uiLogin <- renderUI({
  if (USER$Logged == FALSE) {
    wellPanel(
      h3("Start a new session!"),
      textInput("userName", "Username:"),
      passwordInput("passwd", "Password:"),
      br(),
      actionButton("Login", "Log in"),
      br(),
      br(),
      actionLink("ForgotPass", "Forgot your password?"),br(),
      "Not a user yet? ", actionLink("btCreate", "Create a new account.")
    )
  }
})


output$uiLogout <- renderUI({
  
  if (USER$Logged == TRUE) {
    USER$Logged <- FALSE
    wellPanel(
      h3("Logging Out ... ")
    )
  }
})


observeEvent(input$ForgotPass, {
  output$uiLogin <- renderUI({
    
    if (USER$Logged == FALSE) {
      
      wellPanel(
        h3("Forgot your password?"),
        # br(),
        p("Write down your email (username) you used to create your account and a password will be sent there."),
        textInput("userMailReset", "Email (username):"),
        br(),
        actionButton("ResetPass", "Reset my password"),
        br(), br(),
        "Not a user yet? ", actionLink("btCreate", "Create a new account."), br(),
        "Already have an account? " , actionLink("btLogin", "Log in "), " instead."
      )
    }
  })
  output$pass <- renderText("")
})

observeEvent(input$btLogin, {
  
  output$uiLogin <- renderUI({
    if (USER$Logged == FALSE) {
      wellPanel(
        h3("Start a new session!"),
        textInput("userName", "Username:"),
        passwordInput("passwd", "Password:"),
        br(),
        actionButton("Login", "Log in"),
        br(),br(),
        actionLink("ForgotPass", "Forgot your password?"),br(),
        "Not a user yet? ", actionLink("btCreate", "Create a new account.")
      )
    }
  })
  output$pass <- renderText("")
})

observeEvent(input$btCreate, {
  output$uiLogin <- renderUI({
    
    if (USER$Logged == FALSE) {
      wellPanel(
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
        textInput("newUsrLName", "* Last Name: "),
        textInput("newUsrOrg", "* Organization: "),
        selectizeInput("countrySelection", choices = listCountries, label="* Country", options = list(maxOptions = 5 , selected = NULL,  placeholder = 'Type country')), 
        actionButton("btCreateUser", "Create"), 
        br(), br(),
        actionLink("ForgotPass", "Forgot your password?"),br(),
        "Already have an account? " , actionLink("btLogin", "Log in "), " instead."
      )
    }
  })
  output$pass <- renderText("")
})


observeEvent(input$Login, {
  if (USER$Logged == FALSE && length(input$userName) > 0) {
    Username <- isolate(trimws(input$userName))
    inputPass <- trimws(input$passwd)
    Password <- digest(isolate(inputPass), "sha256", serialize = FALSE)
    validEmail <- validateEmail(Username)
    if(!as.logical(validEmail[1])){ 
      output$pass <- renderText(paste0("<font color='red'> <h4><b>", Username, ": </b> ", validEmail[2], "</h4> </font>"))
      return()
    }
    else if(nchar(inputPass) < 1){
      output$pass <- renderText(paste0("<font color='red'> <h4> Password is missing</h4> </font>"))
      return()
    }
    
    mydb = dbConnect(MySQL(), user=constUserDB, password=constPassDB, dbname=constDBName, host=constDBHost)
    userc = dbSendQuery(mydb, "select id, username, password, fname, lname, organization, country from users where available = 1")
    data1 = fetch(userc, n=-1)
    dbDisconnect(mydb)
    PASSWORD <- data.frame(Brukernavn = data1[,2], Passord = data1[,3])
    
    
    Id.username <- which(PASSWORD$Brukernavn == Username)
    
    if (length(Id.username) == 1) {
      if (PASSWORD[Id.username, 2] == Password) {
        USER$Logged <- TRUE
        USER$list <- paste(data1[,4], data1[,5], paste0("<", data1[,2], ">"))
        USER$id <- data1[Id.username, "id"]
        USER$username <- data1[Id.username, "username"]
        USER$fname <- data1[Id.username, "fname"]
        USER$lname <- data1[Id.username, "lname"]
        USER$org <- data1[Id.username, "organization"]
        USER$country <- data1[Id.username, "country"]
        output$pass <- renderText("")
        output$mssgChngPass <- renderText("")
      }
      else{
        output$pass <- renderText("<h3> Incorrect password! <h3> ")
      }
    } else  {
      output$pass <- renderText("<h3> User is not registered! <h3> ")
    }
  }
})