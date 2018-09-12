uiMaterialListMain <- function(){
  # actionButton("newML", "Refresh")
  # dt_myMaterialList <- reactive({updMaterialListTb()})
  dt_myMaterialList <- updMaterialListTb()
  names(dt_myMaterialList)  <- c("Owner", "File name", "Other name","File extension", "Date created", "Status", "Size (KB)")
  wellPanel(
    
    tags$script("$(document).on('click', 'button', function () {
                  Shiny.onInputChange('lastClickId',this.id);
                  Shiny.onInputChange('lastClick', Math.random())
});"),
    actionButton("btNewMaterialList", "New"),
    # DT::renderDataTable({dt_myMaterialList}),
    
    DT::renderDataTable({
      DT=dt_myMaterialList
      DT[["Actions"]]<-
        paste0('
             <div  role="group" aria-label="Basic example">
                <button type="button" class="btn btn-secondary delete" id=view_',1:nrow(dt_myMaterialList),'><i class="fa fa-eye"></i></button>
             </div>
             
             ')
      datatable(DT,
                escape=F)
    
    }),
    
    # dataTableOutput(dtMyML),
    actionButton("btAddMaterialList", "Add"),
    actionButton("btDelMaterialList", "Delete"),
    actionButton("btExpMaterialList", "Export")
  )
}


observeEvent(input$lastClick,{
               if (input$lastClickId%like%"view"){

                 row_to_view = as.numeric(gsub("view_","",input$lastClickId))
                 output$materialListScreen <- renderUI({
                   uiMaterialSublist()
                 })
               }
             }
)

uiMaterialListNew <- function(){
  wellPanel(
    
    actionButton("btBackToML", "Cancel"),
    br(),
    textInput("txNewMLName", "Name:"),
    textAreaInput("taMaterialList", "Enter Material List", rows=20, width="700px"),
    actionButton("btNewMLSave", "Save")
  )
}

uiMaterialSublist <- function(index){
  # getMaterialListContent(index)
  wellPanel(
    
    actionButton("btBackToML", "Cancel"),
    br(),
    textInput("txNewMSlName", "Name:"),
    textAreaInput("taMaterialSublist", "Enter Sublist", rows=20, width="700px"),
    actionButton("btNewSlSave", "Save")
  )
}


uiMaterialListAdd <- function(){
  wellPanel(
    
    actionButton("btBackToML", "Cancel"),
    br(),
    textAreaInput("taMaterialList", "Enter Material List", rows=20, width="700px"),
    actionButton("btNewMLSave", "Save")
  )
}