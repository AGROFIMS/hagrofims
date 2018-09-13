uiDriveMain <- function(){
  dt_myDrive <- updDriveTb()
  names(dt_myDrive)  <- c("Owner", "File name", "Other name","File extension", "Date created", "Status", "Size (KB)")
  wellPanel(

    tags$script("$(document).on('click', 'button', function () {
                  Shiny.onInputChange('driveTabClickId',this.id);
                  Shiny.onInputChange('driveTabClick', Math.random())
});"),

    DT::renderDataTable({
      DT=dt_myDrive
      DT[["Actions"]]<-
        paste0('
             <div  role="group" aria-label="Basic example">
                <button type="button" class="btn btn-secondary delete" id=view_',1:nrow(dt_myDrive),'><i class="fa fa-eye"></i></button>
             </div>

             ')
      datatable(DT,
                escape=F,
                selection = "none")

    })
  )
}


observeEvent(input$driveTabClick,{
     if (input$driveTabClickId%like%"view"){
       row_to_view = as.numeric(gsub("view_","",input$driveTabClickId))
     }
   }
)

