filesDirectory <- "./user_files/"

source("www/driveModule/ui_drive.R", local = TRUE)

updDriveTb <- function() {
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
