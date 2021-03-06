#### Librerias

#Remove warnings messages
suppressWarnings("DT")
suppressMessages("shiny")
suppressWarnings("dplyr")
suppressWarnings("plyr")
suppressWarnings("stats")
suppressWarnings("base")
suppressWarnings("shinydashboard")
suppressWarnings("purrr")
suppressWarnings("foreign")
suppressWarnings("agricolae")
suppressWarnings("GGally")
suppressWarnings("shinyjs")
suppressWarnings("lubridate")
suppressWarnings("shinyalert")
suppressWarnings("ggmap")
suppressWarnings("magrittr")
suppressWarnings("maps")
suppressWarnings("raster")
suppressWarnings("base64enc")
suppressWarnings("limSolve")
suppressWarnings("rowr")
suppressWarnings("aganalysis")
suppressMessages("rgeos")
suppressMessages("shinyjs")
suppressMessages("ggmap")
#TODO: the complete list of packages is listed in list_packages_agrofims

#library(d3heatmap)
library(shiny, warn.conflicts=FALSE)
library(shinysky, warn.conflicts=FALSE)
library(shinydashboard, warn.conflicts=FALSE)
library(doBy)
library(tidyr, warn.conflicts=FALSE)
library(DT, warn.conflicts=FALSE)
library(date)
library(dplyr, warn.conflicts=FALSE)
library(openxlsx, warn.conflicts=FALSE)
library(data.table, warn.conflicts=FALSE) 
library(leaflet)
library(withr)
library(purrr, warn.conflicts=FALSE)
library(tibble)
library(knitr)
library(readxl)
library(countrycode)
library(DBI)
library(RMySQL)
library(spsurvey)
library(foreign, warn.conflicts=FALSE)
library(tools)
library(stringr)
library(rprojroot)
library(factoextra)
library(ggrepel)
library(tibble)
library(stringi)
library(digest)
library(datasets)

### Librerias de CIP-RIU (GITHUB) que cargan por defecto:
library(shinyTree)
library(agricolae, warn.conflicts=FALSE)

library(agdesign)
library(rhandsontable)
library(shinyjs, warn.conflicts=FALSE)
library(st4gi)
library(fbsites)
library(shinyBS)

library(pepa)
library(shinyFiles)
library(rlist)
library(httr) # library for http requests, used to make POST request to the server
library(bsplus) # hidapNetwork
library(htmltools) # hidapnetwork
library(lubridate, warn.conflicts=FALSE)
library(shinyalert, warn.conflicts=FALSE) # new

### for maps rendering
library(ggmap) # devtools::install_github("dkahle/ggmap") ## use this version of ggmap
library(leaflet)
library(magrittr, warn.conflicts=FALSE)
library(maps, warn.conflicts=FALSE)
library(maptools)
library(raster, warn.conflicts=FALSE)
library(rgeos)
library(sp, warn.conflicts=FALSE)

### libraries for the "remember me" 
library(shinyStore) # install_github("trestletech/shinyStore")
library(PKI) # CRAN
library(shinyWidgets)
#library(agsession) 
library(qrencoder)
library(fbglobal)
####
library(geohash)
#library(fbanalysis)
library(pepa)
library(st4gi)
##
#library(shinyFeedback)
library(fastmap, warn.conflicts=FALSE)
library(limSolve, warn.conflicts=FALSE)
library(rowr, warn.conflicts=FALSE)
library(reticulate, warn.conflicts=FALSE)
library(aganalysis, warn.conflicts=FALSE)


# Llaves para encriptar las cookies: utilizado en el Remember me
privKey <- PKI.load.key(file="test.key")
pubKey <- PKI.load.key(file="test.key.pub")
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
    
    tags$head(
     
     includeHTML(("www/analytics/google-analytics.html"))
    ),
    
    useShinyjs(),
    extendShinyjs(text = jscode),
    
    # Inicializa la libreria ShinyStore: utilizado en el Remenber me
    initStore("store", "shinyStore-haf", privKey), # Namespace must be unique to this application!
    
    tabItems(
      tabItem(
        tabName = "hnetwork",
        h2("Login or create HIDAP Network Account")
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
      tabItem(tabName = "term2", div(uiOutput("uiTerm2"),uiOutput("termm") )),
      tabItem(tabName = "driveNet", uiOutput("driveScreen")),
      tabItem(tabName = "trialSite",  h1("Site information"), div(uiOutput("trialScreen"))),
      
      tabItem(tabName = "documentation",
              br(),
              br(),
              #h2("HIDAP AgroFIMS v0.2.1"),
              h2("Documentation"),
              p(class = "text-muted", style="text-align:justify",
                #paste("HIDAP is a Highly Interactive Data Analysis Platform originally meant to support clonal crop breeders at the <a href='http://www.cipotato.org' target='_new'>International Potato Center</a>. It is part of a continuous institutional effort to improve data collection, data quality, data analysis and open access publication. The recent iteration simultaneously also represents efforts to unify best practices from experiences in breeding data management of over 10 years, specifically with DataCollector and CloneSelector for potato and sweetpotato breeding, to address new demands for open access publishing and continue to improve integration with both corporate and community databases (such as biomart and sweetpotatobase) and platforms such as the <a href='https://research.cip.cgiar.org/gtdms/' target='_new'> Global Trial Data Management System (GTDMS)</a> at CIP. </br> One of the main new characteristics of the current software development platform established over the last two years is the web-based interface which provides also a highly interactive environment. It could be used both online and offline and on desktop as well as tablets and laptops. Key features include support for data capture, creation of field books, upload field books from and to accudatalogger, data access from breeding databases (e.g., <a href = 'http://germplasmdb.cip.cgiar.org/' target='_new'>CIP BioMart</a>, <a href='http://www.sweetpotatobase.org' target='_new'>sweetpotatobase</a> via <a href='http://docs.brapi.apiary.io/' target='_new'>breeding API</a>), data quality checks, single and multi-environmental data analysis, selection indices, and report generations. For users of DataCollector or CloneSelector many of the features are known but have been improved upon. Novel features include list management of breeding families, connection with the institutional pedigree database, interactive and linked graphs as well as reproducible reports. With the first full release by end of November 2016 we will include all characteristics from both DataCollector and CloneSelector. HIDAP, with additional support from <a href='https://sweetpotatogenomics.cals.ncsu.edu/' target='_new'>GT4SP</a>, <a href='http://www.rtb.cgiar.org/' target='_new'>RTB</a>, USAID, and <a href='http://cipotato.org/research/partnerships-and-special-projects/sasha-program/' target='_new'>SASHA</a>, is aimed to support the broader research community working on all aspects with primary focus on breeding, genetics, biotechnology, physiology and agronomy.")
                shiny::includeHTML("www/agrofims_documentation.txt")
              ),
              br(),
              br()
      
      ),
      
      # tabItem(tabName = "term",
      #         shiny::includeHTML("www/term_hidap.txt"),
      #         br(),
      #         br()
      # ),
      
      tabItem(tabName = "dashboard",
              img(src="images/banner_agrofims_v3.jpg", width = "100%", height="100%"),
              br(),
              br(),
              #h2("HIDAP AgroFIMS v0.2.1"),
              h2("HIDAP AgroFIMS"),
              p(class = "text-muted", style="text-align:justify",
                #paste("HIDAP is a Highly Interactive Data Analysis Platform originally meant to support clonal crop breeders at the <a href='http://www.cipotato.org' target='_new'>International Potato Center</a>. It is part of a continuous institutional effort to improve data collection, data quality, data analysis and open access publication. The recent iteration simultaneously also represents efforts to unify best practices from experiences in breeding data management of over 10 years, specifically with DataCollector and CloneSelector for potato and sweetpotato breeding, to address new demands for open access publishing and continue to improve integration with both corporate and community databases (such as biomart and sweetpotatobase) and platforms such as the <a href='https://research.cip.cgiar.org/gtdms/' target='_new'> Global Trial Data Management System (GTDMS)</a> at CIP. </br> One of the main new characteristics of the current software development platform established over the last two years is the web-based interface which provides also a highly interactive environment. It could be used both online and offline and on desktop as well as tablets and laptops. Key features include support for data capture, creation of field books, upload field books from and to accudatalogger, data access from breeding databases (e.g., <a href = 'http://germplasmdb.cip.cgiar.org/' target='_new'>CIP BioMart</a>, <a href='http://www.sweetpotatobase.org' target='_new'>sweetpotatobase</a> via <a href='http://docs.brapi.apiary.io/' target='_new'>breeding API</a>), data quality checks, single and multi-environmental data analysis, selection indices, and report generations. For users of DataCollector or CloneSelector many of the features are known but have been improved upon. Novel features include list management of breeding families, connection with the institutional pedigree database, interactive and linked graphs as well as reproducible reports. With the first full release by end of November 2016 we will include all characteristics from both DataCollector and CloneSelector. HIDAP, with additional support from <a href='https://sweetpotatogenomics.cals.ncsu.edu/' target='_new'>GT4SP</a>, <a href='http://www.rtb.cgiar.org/' target='_new'>RTB</a>, USAID, and <a href='http://cipotato.org/research/partnerships-and-special-projects/sasha-program/' target='_new'>SASHA</a>, is aimed to support the broader research community working on all aspects with primary focus on breeding, genetics, biotechnology, physiology and agronomy.")
                shiny::includeHTML("www/about_hidap.txt")
              ),
              br(),
              br(),

              fluidRow(
                column(
                  12, align="center",
                  div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="images/BIG_DATA.png", height=90, width=190)),
                  #div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="images/CIAT.jpg", height=90, width=190)),
                  div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="images/alliancef_banner.png", height=90, width=190)),
                  div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="CIPlogo_RGB.png", height=90, width=190)),
                  div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="images/IFPRI.jpg", height=90, width=190))
                  #div(style="display: inline-block; padding-left: 30px; padding-right: 30px; padding-top: 15px; padding-bottom: 15px;",img(src="images/Bioversity.jpg", height=100, width=130))
                )
              ),
              br(),
              br(),
              br()
      ),
      agdesign::ui_sites_agrofims(name="newSiteAgrofims"),
      agdesign::ui_listsites_agrofims(name="listSitesAgrofims"),
      agdesign::ui_fieldbook_agrofims(name = "newFieldbookAgrofims"),
      #agsession::ui_session(name = "openFieldbook"),
      agdesign::ui_mobile_agrofims(name  = "uimobileagrofims"),
      #fbanalysis::single_hdagrofims_ui(name="singleAnalysisReportAgrofims"),
      aganalysis::single_hdagrofims_ui(name="singleAnalysisReportAgrofims"),
      #aganalysis::trend_hdagrofims_ui(name= "trendAnalysisReportAgrofims"),
      #fbanalysis::trend_hdagrofims_ui(name= "trendAnalysisReportAgrofims"),
      agdesign::ui_session_agrofims(name = "uisessionagrofims")
    ),

    tags$div(
      fluidRow(
        tags$footer(tags$div(id = "test", HTML('Powered by HIDAP| '), a(href = "#shiny-tab-term2", "Privacy Policy & Terms of Use", "data-toggle"="tab"), (' | agrofims@cgiar.org')),
          # a(onclick = "openTab('userProfile')",
          #   list(
          #     #tags$div(id = "test", img(src="cc_by.png"), "2018 International Potato Center. Av La Molina 1895, La Molina - Peru.")
          #     #tags$div(id = "test", "Powered by HIDAP | Terms of Use & Privacy Policy | agrofims@cgiar.org", tags$a(href="www.rstudio.com", "Click here!"))#,
          #     tags$div(id = "test", HTML('Powered by HIDAP | <a href="www.rstudio.com">Terms of Use & Privacy Policy</a> | agrofims@cgiar.org'))#,
          #     #tags$div(id = "test2", "agrofims@cgiar.org ")
          #   )#,
          #   #href="#"
          # ),
          #tags$style("footer {background-color: #222d32;height: 40px;position: absolute;bottom: 0;width: 84%;}"),
          tags$style("footer {background-color: #222d32;height: 40px;bottom: 0;width: 100%;position: absolute;}"),
          tags$style("#test {color: #fff;padding-top: 9px;float:left}"),
          tags$style("#test2 {color: #fff;padding-top: 9px;text-align:right}")
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

  withProgress(message = 'Loading HIDAP', value = 0, {

  incProgress(1/25, detail = paste("..."))

  # fbcheck::fbcheck_server(input, output, session, values)

  #fbmlist::server_managerlist(input, output, session, values)
  #fbmlist::server_managerlist_agrofims(input, output, session, values)
  #fbmlist::server_generate(input, output, session, values)
  #fbmlist::server_generate_agrofims(input, output, session, values)
  #fbmlist::server_createlist(input, output, session, values)
  #fbmlist::server_parentlist(input, output, session, values)
  #fbmlist::server_distribution(input,output,session, values)

  incProgress(2/25, detail = paste("..."))

  agdesign::server_sites_agrofims(input, output, session, values)
  agdesign::server_listsites_agrofims(input, output, session, values)
  agdesign::server_design_agrofims(input, output, session, values)
  #agsession::server_session(input, output, session, values)
  #agdesign::server_session_agrofims(input, output, session, values)
  agdesign::server_mobile_agrofims(input, output, session, values)
  # fbopenbooks::fbopenbooks_server(input, output, session, values)
  #fbanalysis::single_hdagrofims_server(input, output, session, values)
  aganalysis::single_hdagrofims_server(input, output, session, values)
  #aganalysis::trend_hdagrofims_server(input, output, session, values = values)
  #fbanalysis::trend_hdagrofims_server(input, output, session, values = values)
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

shinyApp(ui, sv, enableBookmarking = "url")
