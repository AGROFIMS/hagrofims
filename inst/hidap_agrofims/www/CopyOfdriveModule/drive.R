filesDirectory <- "./user_files/"


source("www/driveModule/ui_drive.R", local = TRUE)

updMaterialListTb <- function() {
  mydb = dbConnect(MySQL(), user=constUserDB, password=constPassDB, dbname=constDBName, host=constDBHost)
  strQry = paste0("SELECT owner_id,
                   file_pub_name,
                   file_serv_name,
                   file_extension,
                   created_at,
                   creation_type,
                   size
                   FROM user_files
                   WHERE owner_id = ", USER$id,
                    " order by created_at DESC")
  qryMyfiles = dbSendQuery(mydb,strQry)
  myFiles = fetch(qryMyfiles, n=-1)
  df_withMe <<- data.frame(myFiles)
  dbDisconnect(mydb)

  return(df_withMe)
}


getMaterialListContent <- function(id) {

 print(dt_myMaterialList()[1])
}


observeEvent(input$btNewMaterialList, {
  output$driveScreen <- renderUI({
    uiMaterialListNew()
  })

})

observeEvent(input$btBackToML, {
  output$driveScreen <- renderUI({
    uiMaterialListMain()
  })
})


## when user clicks to save new list
observeEvent(input$btNewMLSave, {
  newList <- str_split(input$taMaterialList,"\\n")[[1]]
  newList <- stringr::str_trim(newList,side = "both")
  fileName <- input$txNewMLName
  if(validateNewList()){
    ranStr <-  stri_rand_strings(1, 15,  '[a-zA-Z0-9]')
    date  <- as.character(Sys.time(), "%Y%m%d%H%M%S")
    createDate <-as.character(Sys.time(), "%Y-%m-%d %H:%M:%S")
    servName <- paste(date, ranStr, str_pad(USER$id, 4, pad = "0"), sep="-") # file name in the server,
    servNamePath <- paste0(filesDirectory, servName)

    write.table(newList, file=servNamePath, sep="\n")
    file <- file.info(servNamePath)
    ext <- "txt" #file extension

    mydb = dbConnect(MySQL(), user=constUserDB, password=constPassDB, dbname=constDBName, host=constDBHost)
    insQry= "insert into user_files (file_pub_name, file_serv_name, file_extension, created_at, creation_type, size, owner_id) values('"
    insQry= paste0(insQry, fileName)
    insQry= paste(insQry, servName, ext, createDate, "Created",  file[[1]], sep="','")
    insQry= paste0(insQry, "',",  USER$id, ")")

    print(insQry)
    qryUsers = dbSendQuery(mydb, insQry)
    dbDisconnect(mydb)
    output$driveScreen <- renderUI({
      uiMaterialListMain()
    })

  }
  else{
    ## TO DO
    ## what to do if the input is not valid.
  }

})


## when user clicks "add"
observeEvent(input$btAddMaterialList, {
  output$driveScreen <- renderUI({
    uiMaterialListNew()
  })
})

### to do: function to validate new list input
validateNewList <- function(){
  return(TRUE)
}
