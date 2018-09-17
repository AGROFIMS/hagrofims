columnNames <- c("id", "Site ID", "Type", "Name", "Country","First level admin", "Second level admin", "Third level admin","Fourth level admin" , "Village", "Nearest populated place", "Elevation", "Latitude", "Longitude","Creation date")


# sitesValues <- NULL
# sitesValues$counFirstChose <- F
# sitesValues$adm1FirstChose <- F
# sitesValues$adm2FirstChose <- F
# sitesValues$adm3FirstChose <- F


dt <- reactiveValues()

uiTrialScreenMain <- function(){
  aux <- updTrialSites()
  names(aux) <- columnNames
  dt$trialSites <- aux

    fluidRow(
      tags$script("$(document).on('click', 'button', function () {
                  Shiny.onInputChange('siteClickId',this.id);
                  Shiny.onInputChange('siteClick', Math.random())
    });"),
      box(
        #shinysky::showshinyalert(session, "alert_hagroSites", paste("New site has been successfully added"), styleclass = "success"),
        # title = " List site information",
        title = tagList(shiny::icon("list-ol"), "List site information"),
        status = "primary", solidHeader = TRUE,
        collapsible = TRUE, width = 12,
        
        # actionButton("btNewTrialSite", "Add New Site",  style="color: #fff; background-color: #35b872;", icon = icon("plus-circle")),
        actionButton("btNewTrialSite", "Add New Site",  class = "btn-primary",style="color: #fff;", icon = icon("plus-circle")),
        # shinysky::shinyalert("alert_SI_created", FALSE, auto.close.after = 4),
        br(),br(),br(),
        dataTableOutput("Sites_table")
      ),
      box(
        title = "Map",
        # title = tagList(shiny::icon("list-ol"), "List Site information"),
        status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
        # actionButton("btShowMap", "View sites",  class = "btn-primary",style="color: #fff;"),br(), br(),
        column( width = 12,
                leafletOutput("mymap1a", "100%", "550px")
                # leaflet() %>%
                #   addTiles() %>%  # Add default OpenStreetMap map tiles
                #   # addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
                #   setView(lng = -4.04296, lat = 16.30796, zoom = 2) #%>%
        )
        
      ),
      box(solidHeader = FALSE, width = 12)
  )
}




output$Sites_table <- renderDataTable({

    DT=dt$trialSites
    
    if(nrow(dt$trialSites) > 0){
      DT[["Actions"]]<-
        paste0('
               <div  role="group" aria-label="Basic example">
                  <button type="button" class="btn btn-secondary view" id=siteView_',1:nrow(dt$trialSites),'><i class="fa fa-eye"></i></button>
                  <button type="button" class="btn btn-secondary edit" id=siteEdit_',1:nrow(dt$trialSites),'><i class="fa fa-edit"></i></button>
                   <button type="button" class="btn btn-secondary delete" id=siteDelete_',1:nrow(dt$trialSites),'><i class="fa fa-trash"></i></button>
               </div>

               ')
    }
    datatable(DT,
              escape=F,
              selection = "none",
              options = list(
                scrollX = TRUE,
                pageLength = 10,
                columnDefs = list(list(visible=FALSE, targets=c(1, 12, 13, 14, 15)))
              ))

  # })
})




uiTrialSiteNew <- function(pData = NULL){
  strCreate = "Create"
  strCreateId = "btCreateSite"
  boxTitle <- "Create Site information"
  boxIcon <- "plus-circle"
  veg <- NULL
  if(is.null(pData)){
    vData <- vector("list", 15)
  }
  else{
    vData <- pData
    strCreate <- "Save"
    strCreateId <- "btUpdateSite"
    boxTitle <- "Update Site information"
    boxIcon  <- "edit"
   # veg <-  strsplit(vData[[13]], ',')[[1]]
  }


  mchoices = c("Farmer field", "Experiment station field", "Greenhouse/screenhouse", "Government forest", "Private forest", "Pasture", "Water body")
  fluidRow(
    shinydashboard::box(
    title = tagList(shiny::icon(boxIcon), boxTitle),
    status = "primary", solidHeader = TRUE,
    collapsible = TRUE, width = 12,
    
    box(
      title = "Site name", solidHeader = TRUE, status = "warning", width=12,
      column(width = 4, 
             disabled(textInput("inSiteID", label="Site ID", value = vData[[2]] )),
             selectizeInput("inSiteType", label="Site type", choices = mchoices, multiple  = TRUE , options = list(maxItems = 1, placeholder ="Select one..."), selected= vData[[3]] ),
             textInput("inSiteName", label = "Site name", value=vData[[4]])
      )
    ),
    
     
    box(
      title = "Site location", solidHeader = TRUE, status = "warning", width=12,
      column(4, 
             selectizeInput("inSiteCountry", label="Country name", multiple = TRUE,
                            choices = unique(geodb$NAME_0),
                            selected= vData[[5]],
                            options = list(maxItems = 1, placeholder = 'Select country... ')),
             
             #textInput("inSiteAdmin1", label = "Site, first-level administrative division name", value=vData[[6]]),
             
             uiOutput("fbsites_ui_admin1"),
             uiOutput("fbsites_ui_admin2"),
             uiOutput("fbsites_ui_admin3"),
             uiOutput("fbsites_ui_admin4"),
             uiOutput("fbsites_ui_admin5"),
             textInput("inSiteNearestPlace", label = "Nearest populated place", value=vData[[11]]), 
             shiny::numericInput(inputId = "inSiteElevation" ,label = "Site elevation (meters)", value = vData[[12]] )
             
             ), 
      column( width = 8,
              br(),
              HTML("<center>"),
              radioButtons("mymap_radiobutton_type", "Map view type", c("Default", "Street map", "Geo map"), selected="Default",inline = T),
              HTML("</center>"),
              
              leafletOutput("mymap"), 
              fluidRow(
                column(width = 6, 
                       shiny::numericInput(inputId = "inSiteLatitude" , label = "Site latitude (in decimal degrees)", value = vData[[13]] )
                ),
                column( width = 6,
                        shiny::numericInput(inputId = "inSiteLongitude" , label = "Site longitude (in decimal degrees)", value = vData[[14]] )
                        )
              )
      )
    ),
      
    column(width = 12,
      useShinyalert(),
      actionButton(strCreateId, strCreate, class = "btn-primary",style="color: #fff;"),
      actionButton("goToMainSiteScreen", "Cancel")#,
    )
      
    
  )#end box
  ,
  box(solidHeader = FALSE, width = 12)
  )#end fluidrow

}
