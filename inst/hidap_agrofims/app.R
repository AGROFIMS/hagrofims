#### Librerias
### Librerias de CRAN que cargan por defecto:
library(d3heatmap)
library(shinysky)
library(data.table)
library(shinydashboard)
library(doBy)
library(tidyr)
library(DT)
library(date)
library(dplyr)
library(openxlsx)
library(qtlcharts)
library(leaflet)
library(withr)
library(dplyr)
library(purrr)
library(tibble)
library(knitr)
library(readxl)
library(countrycode)
library(DBI)
library(RMySQL)
library(spsurvey)
library(foreign)
library(tools)
library(stringr)
library(rprojroot)
library(factoextra)
library(ggrepel)
library(tibble)
library(stringi)
library(digest)
library(shiny)
library(datasets)

### Librerias de CIP-RIU (GITHUB) que cargan por defecto:
library(shinyTree)
library(agricolae)
library(brapi)
library(brapps)
library(fbdesign)
library(rhandsontable)
library(shinyjs)
library(st4gi)
library(fbsites)
library(shinyBS)
library(sbformula)
library(pepa)
library(shinyFiles)
library(rlist)
library(httr) # library for http requests, used to make POST request to the server
library(bsplus) # hidapNetwork
library(htmltools) # hidapnetwork
library(lubridate)
library(shinyalert) # new

### for maps rendering
library(ggmap) # devtools::install_github("dkahle/ggmap") ## use this version of ggmap
library(leaflet)
library(magrittr)
library(maps)
library(maptools)
library(raster)
library(rgeos)
library(sp)

### libraries for the "remember me" 
library(shinyStore) # install_github("trestletech/shinyStore")
library(PKI) # CRAN
library(shinyWidgets)
library(fbsession)
# library(shinyURL)
# library(fbmet)
# library(fbhelp)
# library(fbmlist)
# library(fbmet)
# library(fbcheck)
# library(fbmlist)
# library(fbopenbooks)
# library(fbanalysis)
# library(traittools)
# library(fbdocs)
# library(geneticdsg)
# package fbupdate
# library(remotes)
# library(fbupdate)
# library(shinyjs)
# library(shinyalert)
# packages for HiDAP network
# library(DT)
# library(shinyjs)
# library(shinydashboard)
# library(RMySQL)

####

# Llaves para encriptar las cookies: utilizado en el Remember me
privKey <- PKI.load.key(file="test.key")
pubKey <- PKI.load.key(file="test.key.pub")
#

# Codigo de Omar
# init default data: TODO make a function with better logic checking whats new
# from fbglobal get_base_dir
#dd = system.file("xdata/Default", package = "fbglobal")
#file.copy(from = dd, to = fbglobal::get_base_dir(""), recursive = TRUE)
# remove dependency on RTools by pointing to a zip.exe. NOTE: needs to be installed
# into HiDAP working dir by installer
#Sys.setenv("R_ZIPCMD" = file.path(Sys.getenv("HIDAP_HOME"), "zip.exe"))
#

# Carga las credenciales de la bd
source("www/loginModule/dbData.R", local = TRUE)
#

source("www/js/jsCode.R", local = TRUE)

ui <- dashboardPage(
  title="HIDAP AgroFims",
  
  dashboardHeader(
    title = "",
    #titleWidth = "250px",
    tags$li(class = "dropdown", tags$a(icon("question-circle"), "Help")),
    #tags$li(class = "dropdown", tags$a(uiOutput("help"))),
    tags$li(class = "dropdown", tags$a(uiOutput("userLoggedTextRight"))),
    dropdownMenuOutput("menuHeader")
  ),
  
  dashboardSidebar(
    #width = "250px",
    div(sidebarMenuOutput("menuUser")),
    sidebarMenu(
      id = "tabs",
      br(),
      sidebarMenuOutput("menu") # Menu is render in login.R when users logs in
    )
  ),

  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "css/custom.css")
    ),
    
    # Activa el acceso a profile, authentication, etc. desde el menu del header
    tags$head(
      tags$script(
        HTML("
          var openTab = function(tabName){
          	$('a', $('.sidebar')).each(function(){
          		if(this.getAttribute('data-value') == tabName){
          			this.click()
                  };
              });
          }
        ")
      )
    ),
    
    # Funciones javascript para el manejo de cookies en general
    tags$head(
      tags$script(src = "js/js.cookies.js")
    ),
    
    useShinyjs(),
    extendShinyjs(text = jscode),
    
    # Inicializa la libreria ShinyStore: utilizado en el Remenber me
    initStore("store", "shinyStore-haf", privKey), # Namespace must be unique to this application!
    
    tabItems(
      tabItem(
        tabName = "hnetwork",
        h2("Login or create HiDAP Network Account")
      ),
      tabItem(
        tabName = "sharedWithMe",
        h1("Files shared with me"),
        br(),
        DT::dataTableOutput("tabSharedWithMe"),
        actionButton("btUpdWithMe", "Update table"),
        actionButton("btDownload", "Add to My Files")
      ),
      tabItem(
        tabName = "sharedFromMe",
        h1("Files shared"),
        DT::dataTableOutput("tabSharedFromMe"),
        actionButton("btUpdFromMe", "Update Table")
      ),
      tabItem(
        tabName = "shareFile",
        h1("Share a file"),
        selectizeInput("userSelection" ,  width="500px", multiple = TRUE, choices = NULL, label="Select users to share with", options = list(maxOptions = 5 ,  placeholder = 'Select users')),
        DT::dataTableOutput("tabFilesToShare"),
        uiOutput('obsInput'),
        actionButton("btUpload", "Share")
      ),
      tabItem(tabName = "changePass",div(uiOutput("uiChangePass"), uiOutput("mssgChngPass"))),
      tabItem(tabName = "userProfile",div(uiOutput("uiUserProfile"))),
      tabItem(tabName = "register", div(uiOutput("registerMsg"), uiOutput("uiRegister") )),
      tabItem(tabName = "forgotPass", div(uiOutput("uiForgotPass"),uiOutput("pass") )),
      tabItem(tabName = "driveNet", uiOutput("driveScreen")),
      tabItem(tabName = "trialSite",  h1("Site information"), div(uiOutput("trialScreen"))),
      tabItem(tabName = "dashboard",
              img(src="images/banner_agrofims_v3.jpg", width = "100%", height="100%"),
              br(),
              br(),
              h2("HIDAP AgroFIMS v0.2.0"),
              p(class = "text-muted", style="text-align:justify",
                #paste("HiDAP is a Highly Interactive Data Analysis Platform originally meant to support clonal crop breeders at the <a href='http://www.cipotato.org' target='_new'>International Potato Center</a>. It is part of a continuous institutional effort to improve data collection, data quality, data analysis and open access publication. The recent iteration simultaneously also represents efforts to unify best practices from experiences in breeding data management of over 10 years, specifically with DataCollector and CloneSelector for potato and sweetpotato breeding, to address new demands for open access publishing and continue to improve integration with both corporate and community databases (such as biomart and sweetpotatobase) and platforms such as the <a href='https://research.cip.cgiar.org/gtdms/' target='_new'> Global Trial Data Management System (GTDMS)</a> at CIP. </br> One of the main new characteristics of the current software development platform established over the last two years is the web-based interface which provides also a highly interactive environment. It could be used both online and offline and on desktop as well as tablets and laptops. Key features include support for data capture, creation of field books, upload field books from and to accudatalogger, data access from breeding databases (e.g., <a href = 'http://germplasmdb.cip.cgiar.org/' target='_new'>CIP BioMart</a>, <a href='http://www.sweetpotatobase.org' target='_new'>sweetpotatobase</a> via <a href='http://docs.brapi.apiary.io/' target='_new'>breeding API</a>), data quality checks, single and multi-environmental data analysis, selection indices, and report generations. For users of DataCollector or CloneSelector many of the features are known but have been improved upon. Novel features include list management of breeding families, connection with the institutional pedigree database, interactive and linked graphs as well as reproducible reports. With the first full release by end of November 2016 we will include all characteristics from both DataCollector and CloneSelector. HIDAP, with additional support from <a href='https://sweetpotatogenomics.cals.ncsu.edu/' target='_new'>GT4SP</a>, <a href='http://www.rtb.cgiar.org/' target='_new'>RTB</a>, USAID, and <a href='http://cipotato.org/research/partnerships-and-special-projects/sasha-program/' target='_new'>SASHA</a>, is aimed to support the broader research community working on all aspects with primary focus on breeding, genetics, biotechnology, physiology and agronomy.")
                shiny::includeHTML("www/about_hidap.txt")
              ),
              br(),
              br(),

              fluidRow(
                column(
                  12, align="center",
                  div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="images/BIG_DATA.png", height=90, width=190)),
                  div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="images/CIAT.jpg", height=90, width=190)),
                  div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="CIPlogo_RGB.png", height=90, width=190)),
                  div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="images/IFPRI.jpg", height=90, width=190)),
                  div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="images/Bioversity.jpg", height=100, width=130))
                )
              ),
              br(),
              br(),
              br()
      ),

      fbdesign::ui_fieldbook_agrofims(name = "newFieldbookAgrofims"),
      fbsession::ui_session(name = "opensession"),
      fbanalysis::single_hdagrofims_ui(name="singleAnalysisReportAgrofims")#,
    ),

    tags$div(
      fluidRow(
        tags$footer(
          a(
            list(
              #tags$div(id = "test", img(src="cc_by.png"), "2018 International Potato Center. Av La Molina 1895, La Molina - Peru.")
              tags$div(id = "test", "Powered by HIDAP | Terms of Use & Privacy Policy")
            ),
            href="#"
          ),
          tags$style("footer {background-color: #222d32;height: 40px;position: absolute;bottom: 0;width: 100%;}"),
          tags$style("#test {color: #fff;padding-top: 9px;}")
        )
      )
    )

  )
)


############################################################

sv <- function(input, output,  session) ({
  
  #### Funcion que hace que contunue logeado
  observe({
    js$getcookie()
    if (!is.null(input$jscookie_user) &&
        input$jscookie_user != "") {
      checkCredentials(input$jscookie_user, input$jscookie_pass)
    }
  })
  ####
  
  #### Login
  session$userData$logged <- F
  session$userData$userId <- NULL
  session$userData$userLname <- NULL
  session$userData$userFname <- NULL
  session$userData$userMail <- NULL

  USER <- reactiveValues(Logged = FALSE, username = NULL, id = NULL, fname = NULL, lname = NULL, org=NULL, country=NULL)
  ####
  
  useShinyjs()
  extendShinyjs(text = jscode)



  # USER <- reactiveValues(Logged = FALSE, username = NULL, id = NULL, fname = NULL, lname = NULL, org=NULL, country=NULL)
  #### Modulo pendiente
  dt_myMaterialList <- reactiveValues()
  ####

  #### Files necesrios para el login
  source("www/loginModule/userMenuUi.R",local = TRUE)
  source("www/driveModule/drive.R", local = TRUE)
  source("www/sitesModule/sites.R", local = TRUE)
  source("www/loginModule/login.R", local = TRUE)
  ####
  
  #### Codigo de Omar
  values <- shiny::reactiveValues(crop = "sweetpotato", amode = "brapi")

  withProgress(message = 'Loading HiDAP', value = 0, {

  incProgress(1/25, detail = paste("..."))

  # fbcheck::fbcheck_server(input, output, session, values)

  #fbmlist::server_managerlist(input, output, session, values)
  fbmlist::server_managerlist_agrofims(input, output, session, values)
  #fbmlist::server_generate(input, output, session, values)
  fbmlist::server_generate_agrofims(input, output, session, values)
  #fbmlist::server_createlist(input, output, session, values)
  #fbmlist::server_parentlist(input, output, session, values)
  #fbmlist::server_distribution(input,output,session, values)

  incProgress(2/25, detail = paste("..."))


  fbdesign::server_design_agrofims(input, output, session, values)
  fbsession::server_session(input, output, session, values)
  # fbdesign::server_design_big(input, output, session, values)
  # fbopenbooks::fbopenbooks_server(input, output, session, values)
  fbanalysis::single_hdagrofims_server(input, output, session, values)
  # fbanalysis::dtr_server(input, output, session, values)
  #
  # fbanalysis::met_server(input, output, session, values)
  #
  # incProgress(3/25, detail = paste("..."))
  #
  # fbanalysis::elston_server(input, output, session, values)
  #
  # incProgress(4/25, detail = paste("..."))
  #
  # fbanalysis::pbaker_server(input, output, session, values)
  #
  # incProgress(5/25, detail = paste("..."))
  #
  # fbanalysis::droindex_server(input, output, session, values = values)
  #
  # fbanalysis::pvs_server(input, output, session, values)
  #
  # incProgress(6/25, detail = paste("..."))
  #
  # fbanalysis::genetic_server(input, output, session, values)
  #
  # incProgress(8/25, detail = paste("..."))
  #
  # fbanalysis::pvs_anova_server(input, output, session, values)
  #
  #
  # incProgress(9/25, detail = paste("..."))
  #
  # fbdocs::fbdocs_server(input, output, session, values)
  #
  # incProgress(10/25, detail = paste("..."))
  #
  # fbsites::server_addsite(input, output, session, values = values)
  # fbsites::server_site(input, output, session, values = values)
  #
  # incProgress(12/25, detail = paste("..."))
  #
  # fbupdate::fbupdate_server(input, output, session, values = values)
  #
  # incProgress(15/25, detail = paste("..."))
  #
  #
  #     incProgress(16/25, detail = paste("..."))

     incProgress(25/25, detail = paste("..."))
  #
   }) #end shiny progress bar
  #
  # ################## End NETWORK ######################################################################################

})

shinyApp(ui, sv)
