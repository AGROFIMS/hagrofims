source("www/sitesModule/ui_sites.R", local = TRUE)

register_google(key = "AIzaSyAPWYHA8LkSrhnr1XxBFHuJ3aWeqi-N5lQ")


observeEvent(input$mymap_click, {
  # print(input$mymap_click)
  lat  <- round(input$mymap_click$lat, 5)
  lon  <- round(input$mymap_click$lng, 5)
  
  updateTextInput(session, "inSiteLatitude", value = lat)
  updateTextInput(session, "inSiteLongitude", value = lon)
  
  leafletProxy("mymap") %>%
    clearMarkers() %>%
    addMarkers(lon, lat)
})



map1a = leaflet() %>%
  addTiles("https://{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png") %>%
  setView(lng = -4.04296, lat = 16.30796, zoom = 3) #%>%

observeEvent(input$btNewTrialSite, {
  output$trialScreen <- renderUI({
    uiTrialSiteNew()
  })
})

output$fbsites_ui_admin1 <-renderUI({


  cntry <- input$inSiteCountry
  admin1 <- get_admin_agrofims(sites_data = geodb, country = cntry)

  if(is.null(cntry)){
     admin1 <- ""
  }

  if (input$siteClickId %like% "siteEdit"){

    row_to_edit = as.numeric(gsub("siteEdit_","", input$siteClickId))

     vData <- dt$trialSites[row_to_edit,]

     selAdmin1 <- vData[[6]]

  } else{

    selAdmin1 <- ""
  }
  #print(vData)
  # selectizeInput("inSiteType", label="Site type",
  #                choices = mchoices,
  #                multiple  = TRUE ,
  #                options = list(maxItems = 1, placeholder ="Select one..."), selected= vData[[3]] ),
  #
  selectizeInput("inSiteAdmin1", label= "First-level administrative division",
                 choices = admin1,
                 multiple = TRUE,
                 options = list(maxItems = 1, placeholder = 'Select admin 1'),
                 selected= selAdmin1)
})


output$fbsites_ui_admin2 <-renderUI({

  cntry <- input$inSiteCountry
  admin1 <- input$inSiteAdmin1
  admin2 <- get_admin_agrofims(geodb, country = cntry, admin1 = admin1)

  if (input$siteClickId %like% "siteEdit"){

    row_to_edit = as.numeric(gsub("siteEdit_","", input$siteClickId))

    vData <- dt$trialSites[row_to_edit,]

    selAdmin2 <- vData[[7]]

  } else{

    selAdmin2<- ""
  }



  if(is.na(admin2) && is.null(admin1)){
    textInput("inSiteAdmin2_text", label = "Second-level administrative division", value= selAdmin2) #)vData[[7]])
  } else {

    selectizeInput("inSiteAdmin2", label= "Second-level administrative division", multiple = TRUE,
                   choices = admin2,
                   selected= selAdmin2,
                   options = list(maxItems = 1, placeholder = 'Select admin 2'))
  }



})


output$fbsites_ui_admin3 <-renderUI({

  cntry <- input$inSiteCountry
  admin1 <- input$inSiteAdmin1
  admin2 <- input$inSiteAdmin2
  admin3 <- get_admin_agrofims(geodb, country = cntry,
                                admin1 = admin1,
                                admin2 = admin2)

  if (input$siteClickId %like% "siteEdit"){

    row_to_edit = as.numeric(gsub("siteEdit_","", input$siteClickId))

    vData <- dt$trialSites[row_to_edit,]
    # print("print v Data")
    # print(vData)
    selAdmin3 <- vData[[8]]

  } else{

    selAdmin3 <- ""
  }

  if(is.na(admin3)){
  textInput("inSiteAdmin3_text", label = "Third-level administrative division", value= selAdmin3) #)vData[[7]])
  } else {

  selectizeInput("inSiteAdmin3", label= "Third-level administrative division", multiple = TRUE,
                 choices = admin3,
                 selected= selAdmin3,
                 options = list(maxItems = 1, placeholder = 'Select admin 3'))
  }

})


output$fbsites_ui_admin4 <-renderUI({

  cntry <- input$inSiteCountry
  admin1 <- input$inSiteAdmin1
  admin2 <- input$inSiteAdmin2
  admin3 <- input$inSiteAdmin3

  admin4 <- get_admin_agrofims(geodb, country = cntry,
                                admin1 = admin1,
                                admin2 = admin2,
                                admin3 = admin3)

  if (input$siteClickId %like% "siteEdit"){

    row_to_edit = as.numeric(gsub("siteEdit_","", input$siteClickId))

    vData <- dt$trialSites[row_to_edit,]

    selAdmin4 <- vData[[9]] #admin4

  } else{

    selAdmin4 <- ""
  }




  if(is.na(admin4)){

  textInput("inSiteAdmin4_text", label = "Fourth-level administrative division", value= selAdmin4) #)vData[[7]])
  } else {

  selectizeInput("inSiteAdmin4", label= "Fourth-level administrative division", multiple = TRUE,
                 choices = admin4,
                 selected= selAdmin4,
                 options = list(maxItems = 1, placeholder = 'Select admin 4'))

  }
})

output$fbsites_ui_admin5 <-renderUI({

  cntry <- input$inSiteCountry
  admin1 <- input$inSiteAdmin1
  admin2 <- input$inSiteAdmin2
  admin3 <- input$inSiteAdmin3
  admin4 <- input$inSiteAdmin4


  admin5 <- get_admin_agrofims(geodb, country = cntry,
                               admin1 = admin1,
                               admin2 = admin2,
                               admin3 = admin3,
                               admin4 = admin4
                               )

  if (input$siteClickId %like% "siteEdit"){

    row_to_edit = as.numeric(gsub("siteEdit_","", input$siteClickId))

    vData <- dt$trialSites[row_to_edit,]

    selAdmin5 <- vData[[10]] #admin5

  } else{
    selAdmin5 <- ""

  }


  if(is.na(admin5)){

    textInput("inSiteAdmin5_text", label = "Fifth-level administrative division", value= selAdmin5) #)vData[[7]])

  } else {

    selectizeInput("inSiteAdmin5", label= "Fifth-level administrative division", multiple = TRUE,
                 choices = admin5,
                 selected= selAdmin5,
                 options = list(maxItems = 1, placeholder = 'Select admin 5'))
  }
})

observeEvent(input$goToMainSiteScreen, {
  output$trialScreen <- renderUI({
    uiTrialScreenMain()
    # click("btShowMap")
    
  })

})

observeEvent(input$mymap_radiobutton_type, {

  if(input$mymap_radiobutton_type == "Street map"){
    leafletProxy("mymap") %>%
      addTiles()
  }
  else if(input$mymap_radiobutton_type == "Geo map"){
    leafletProxy("mymap") %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap)
  }
  else{
    leafletProxy("mymap") %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE))
  }

})

observe({

  #After all this conditions has been made, the submit button will appear to save the information
  toggleState("btCreateSite", !
                # is.null(input$inSiteCountry) && str_trim(input$inSiteCountry, side = "both")!= "" &&
                is.null(input$inSiteCountry) && str_trim(input$inSiteCountry, side = "both")!= ""

                # !is.null(input$inSiteName) && str_trim(input$inSiteName, side = "both")!= "" &&

                #   !is.null(input$inSiteAdmin1) && str_trim(input$inSiteAdmin1, side = "both")!= "" &&
                # 
                #  ((!is.null(input$inSiteAdmin2) && str_trim(input$inSiteAdmin2, side = "both")!="" ) ||
                #    (!is.null(input$inSiteAdmin2_text) && str_trim(input$inSiteAdmin2_text, side = "both")!="")) &&
                # 
                # ((!is.null(input$inSiteAdmin3) && str_trim(input$inSiteAdmin3, side = "both")!="") ||
                #     (!is.null(input$inSiteAdmin3_text) && str_trim(input$inSiteAdmin3_text, side = "both")!=""))

                # ((!is.null(input$inSiteAdmin4) && str_trim(input$inSiteAdmin4, side = "both")!="") ||
                #    (!is.null(input$inSiteAdmin4_text) && str_trim(input$inSiteAdmin4_text, side = "both")!="") ) &&

                # ((!is.null(input$inSiteAdmin5) && str_trim(input$inSiteAdmin5, side = "both")!="")  ||
                #    (!is.null(input$inSiteAdmin5_text) && str_trim(input$inSiteAdmin5_text, side = "both")!="") ) &&

                # !is.null(input$inSiteNearestPlace) && str_trim(input$inSiteNearestPlace, side = "both")!= "" &&
                # !is.null(input$inSiteLatitude) && str_trim(input$inSiteLatitude, side = "both")!= ""  &&
                # !is.null(input$inSiteLongitude) && str_trim(input$inSiteLongitude, side = "both")!= ""

  )
})


# observe({print(sitesValues$clickToEdit)})
output$mymap <- renderLeaflet({
  ZOOM=2
  LAT=0
  LONG=0
 
    # Get latitude and longitude
    if( is.null(input$inSiteCountry) && is.null(input$input$inSiteAdmin1) && is.null(input$input$inSiteAdmin2) && is.null(input$input$inSiteAdmin3) ){
      ZOOM=2
      LAT=0
      LONG=0
    }
    else {
        minput <- if(is.null(input$inSiteCountry)) "" else input$inSiteCountry
        ZOOM=4
        
        if(!is.null(input$inSiteAdmin1) && input$inSiteAdmin1 != "NA"){
         
          minput <- paste0(minput," ", input$inSiteAdmin1)
          ZOOM <- ZOOM + 2
        }
        if(!is.null(input$inSiteAdmin2) && input$inSiteAdmin2 != "NA"){
          minput <- paste0(minput," ", input$inSiteAdmin2)
          ZOOM <- ZOOM + 2
        }
        if(!is.null(input$inSiteAdmin3) && input$inSiteAdmin3 != "NA"){
          minput <- paste0(minput," ", input$inSiteAdmin3)
          ZOOM <- ZOOM + 2
        }
        
        target_pos=geocode(minput)
        LAT=target_pos$lat
        LONG=target_pos$lon
        
  
        # if (isolate(sitesValues$clickToEdit == T)){
        #   row_to_edit = as.numeric(gsub("siteEdit_","", input$siteClickId))
        #   vData <- dt$trialSites[row_to_edit,]
        #   
        #   
        #   LAT <- as.numeric(vData[[13]])
        #   LONG <- as.numeric(vData[[14]])
        #   
        #   sitesValues$clickToEdit <- F
        #   ZOOM = 8
        #   
        # } 
      
    }
    updateTextInput(session, "inSiteLatitude", value = LAT)
    updateTextInput(session, "inSiteLongitude", value = LONG)
  
  
  
  
  map_type <- isolate(input$mymap_radiobutton_type)
  
   
  
  if(map_type == "Street map"){
    leaflet() %>% 
      setView(lng=LONG, lat=LAT, zoom=ZOOM ) %>%
        addTiles() %>%
    addMarkers(LONG, LAT)
  }
  else if(map_type == "Geo map"){
    leaflet() %>% 
      setView(lng=LONG, lat=LAT, zoom=ZOOM ) %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap)  %>%
      addMarkers(LONG, LAT)
  }else{
    leaflet() %>%
      setView(lng=LONG, lat=LAT, zoom=ZOOM ) %>%

      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(LONG, LAT)
  }
  
  # leaflet() %>% 
  #   setView(lng=LONG, lat=LAT, zoom=ZOOM ) %>%
  #   
  #   addProviderTiles(providers$Stamen.TonerLite,
  #                    options = providerTileOptions(noWrap = TRUE)
  #   )
  #    %>%
  #   # addTiles() %>%
  #   addMarkers(LONG, LAT)
  
})


observeEvent(input$btCreateSite, {
  if(validateNewList()){

    vSiteType <- input$inSiteType         #var1
    vSiteNama <- input$inSiteName         #var2
    vCountry  <- input$inSiteCountry      #var3
    vAdmin1   <- input$inSiteAdmin1       #var4


    flag_admin2 <- get_admin_agrofims(geodb, country = vCountry, admin1 = vAdmin1 )

    if(is.na(flag_admin2)){
      vAdmin2   <- input$inSiteAdmin2_text       #var5
    } else {
      vAdmin2   <- input$inSiteAdmin2
    }

    flag_admin3 <- get_admin_agrofims(geodb, country = vCountry, admin1 = vAdmin1, admin2 = vAdmin2)
    
    # print(flag_admin3)
    
    if(is.na(flag_admin3)){
      vAdmin3   <- input$inSiteAdmin3_text       #var5
    } else {
      vAdmin3   <- input$inSiteAdmin3
    }

    # print(vCountry)
    # print(vAdmin1)
    # print(vAdmin2)
    # print(vAdmin3)

    flag_admin4 <- get_admin_agrofims(geodb, country = vCountry, admin1 = vAdmin1, admin2 = vAdmin2, admin3 = vAdmin3)
    
    # print(flag_admin4)
    


    if(is.na(flag_admin4)){
      vAdmin4   <- input$inSiteAdmin4_text       #var5
    } else {
      vAdmin4   <- input$inSiteAdmin4
    }

    flag_admin5 <- get_admin_agrofims(geodb, country = vCountry,  admin1 = vAdmin1, admin2 = vAdmin2, admin3 = vAdmin3, admin4 = vAdmin4)

    if(is.na(flag_admin5)){
      vVillage   <- input$inSiteAdmin5_text       #var5
    } else {
      vVillage   <- input$inSiteAdmin5
    }

    vElevation <- input$inSiteElevation #var7
    vLatitud  <- input$inSiteLatitude   #var8
    vLongitude  <- input$inSiteLongitude   #var8
    vNearest <- input$inSiteNearestPlace #var 11
    # vDescNotes <- input$inSiteDescNotes #var10

    # validate(
    #   need(input$inSiteLatitude!= "", "Please insert latitude")
    # )
    #
    # validate(
    #   need(input$inSiteLongitude!= "", "Please insert longitude")
    # )
    #
    # validate(
    #   need(input$inSiteElevation!= "", "Please insert eleveation")
    # )


    vSiteId <-  stri_rand_strings(1, 5,  '[A-Z]') #var12

    date  <- as.character(Sys.time(), "%Y%m%d%H%M%S")
    createDate <-as.character(Sys.time(), "%Y-%m-%d %H:%M:%S")

    mydb = dbConnect(MySQL(), user=constUserDB, password=constPassDB, dbname=constDBName, host=constDBHost)
    # insQry=  paste0("insert into user_sites ( " ,
    #                 " var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 ,var11, var12, var13, created, user_id) values('")
    insQry=  paste0('insert into user_sites ( ' ,
                    ' var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 ,var11, var12, var13, created, user_id) values("')
    insQry= paste0(insQry, vSiteType)
    insQry= paste(insQry, vSiteNama, vCountry, vAdmin1, vAdmin2, vAdmin3, vElevation, vLatitud, vLongitude, vVillage,  vNearest, vSiteId, vAdmin4, createDate, sep="\",\"")
    # insQry= paste0(insQry, "', " , USER$id, ")")
    insQry= paste0(insQry, "\", " , USER$id, ")")
    qryUsers = dbSendQuery(mydb, insQry)
    dbDisconnect(mydb)
    updateSiteRDS()

    shinyalert("Success", "New site has been successfully added", type = "success")
    #shinysky::showshinyalert(session, "alert_hagroSites", paste("New site has been successfully added"), styleclass = "success")

    output$trialScreen <- renderUI({
      uiTrialScreenMain()
    })

    # shinysky::showshinyalert(session, "alert_SI_created", paste("SUCCESS: You successfully created a new site"), styleclass = "success")
  }
  else{
    ## TO DO
    ## what to do if the input is not valid.
  }
})

observeEvent(input$btUpdateSite, {
  if(validateNewList()){

    vSiteType <- input$inSiteType       #var1
    vSiteName <- input$inSiteName       #var2
    vCountry  <- input$inSiteCountry    #var3

    vAdmin1   <- input$inSiteAdmin1     #var4

    # vAdmin2   <- input$inSiteAdmin2     #var5
    #
    # vAdmin3   <- input$inSiteAdmin3     #
    # vAdmin3   <- input$inSiteAdmin3_text
    #
    # vAdmin4   <- input$inSiteAdmin4     #
    # vAdmin4   <- input$inSiteAdmin4_text

    flag_admin2 <- get_admin_agrofims(geodb, country = vCountry, admin1 = vAdmin1 )
    
    if(!is.na(flag_admin2)){
      vAdmin2   <- input$inSiteAdmin2       #var
    } else {
      vAdmin2   <- input$inSiteAdmin2_text
    }
    
    # print(paste0(vAdmin2, " admin 2"))

    flag_admin3 <- get_admin_agrofims(geodb, country = vCountry, admin1 = vAdmin1, admin2 = vAdmin2)

    if(!is.na(flag_admin3)){
      vAdmin3   <- input$inSiteAdmin3       #var5
    } else {
      vAdmin3   <- input$inSiteAdmin3_text
    }

    flag_admin4 <- get_admin_agrofims(geodb, country = vCountry, admin1 = vAdmin1, admin2 = vAdmin2, admin3 = vAdmin3)

    if(!is.na(flag_admin4)){
      vAdmin4   <- input$inSiteAdmin4       #var13
    } else {
      vAdmin4   <- input$inSiteAdmin4_text
    }

    flag_admin5 <- get_admin_agrofims(geodb, country = vCountry,  admin1 = vAdmin1, admin2 = vAdmin2, admin3 = vAdmin3, admin4 = vAdmin4)

    if(!is.na(flag_admin5)){
      vVillage   <- input$inSiteAdmin5       #var10
    } else {
      vVillage   <- input$inSiteAdmin5_text  #var10
    }

    # vAdmin3   <- input$inSiteAdmin3     #
    # vAdmin3   <- input$inSiteAdmin3_text
    #
    # vAdmin4   <- input$inSiteAdmin4     #
    # vAdmin4   <- input$inSiteAdmin4_text

    # vVillage   <- input$inSiteAdmin5     #
    # vVillage   <- input$inSiteAdmin5_text

    #vVillage  <- input$inSiteVillage    #var6

    # vVillage   <- input$inSiteAdmin5     #var6
    # vVillage   <- input$inSiteAdmin5_text  #var6
    #
    #vVillage  <- input$inSiteVillage    #var6


    vElevation <- input$inSiteElevation #var7
    vLatitud  <- input$inSiteLatitude   #var8
    vLongitude <- input$inSiteLongitude #var9
    # vVegetation <- paste(input$inSiteVegetation, collapse = ",") #var11
    vNearest <- input$inSiteNearestPlace #var11
    # vDescNotes <- input$inSiteDescNotes #var10


    vSiteId <-  input$inSiteID #var12

    date  <- as.character(Sys.time(), "%Y%m%d%H%M%S")
    modifyDate <-as.character(Sys.time(), "%Y-%m-%d %H:%M:%S")


    mydb = dbConnect(MySQL(), user=constUserDB, password=constPassDB, dbname=constDBName, host=constDBHost)
    updQry=  paste0("update user_sites set" ,
                    " var1 = \"", vSiteType, "\", ",
                    " var2 = \"", vSiteName, "\", ",
                    " var3 = \"", vCountry, "\", ",
                    " var4 = \"", vAdmin1, "\", ",
                    " var5 = \"", vAdmin2, "\", ",
                    " var6 = \"", vAdmin3, "\", ",
                    " var7 = \"", vElevation, "\", ",
                    " var8 = \"", vLatitud, "\", ",
                    " var9 = \"", vLongitude, "\", ",
                    " var10 = \"", vVillage, "\", ",
                    " var11 = \"", vNearest, "\", ",
                    " var13= \"", vAdmin4, "\", ",
                    " modified = \"", modifyDate, "\" ",
                    "where user_id = " , USER$id, " " ,
                    "and var12 = \"", vSiteId , "\"")
                    # " var6 = '", vAdmin4, "', ",
                    # " var7 = '", vElevation, "', ",
                    # " var8 = '", vLatitud, "', ",
                    # " var9 = '", vLongitude, "', ",
                    # " var10 = '", vVillage, "', ",
                    # " var11 = '", vNearest, "', ",
                    # " modified = '", modifyDate, "' ",
                    # "where user_id = " , USER$id, " " ,
                    # "and var12 = '", vSiteId , "'")

    qryUsers = dbSendQuery(mydb, updQry)
    dbDisconnect(mydb)
    updateSiteRDS()
    shinyalert("Success", "Site was successfully updated", type = "success")
    output$trialScreen <- renderUI({
      uiTrialScreenMain()
    })


  }
  else{
    ## TO DO
    ## what to do if the input is not valid.
  }
})

output$mymap1a <- renderLeaflet(
 
  
  leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    # addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
    setView(lng = -4.04296, lat = 16.30796, zoom = 2) %>%
    addMarkers(data = mauxf())
)

mauxf <- function(){
  mdata <- as.data.frame(lapply(dt$trialSites[,13:14], as.numeric))
  # mdata[["popup"]] <- lapply(dt$trialSites[,1], as.character)
  mdata[["popup"]] <- dt$trialSites[,2]
  names(mdata) <- c("latitude", "longitude", "popup")
  # print(mdata)
  return(mdata)
}

# observeEvent(input$btShowMap, {
# 
#   output$mymap1a <- renderLeaflet(
#     leaflet() %>%
#       addTiles() %>%  # Add default OpenStreetMap map tiles
#       # addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
#       setView(lng = -4.04296, lat = 16.30796, zoom = 2) #%>%
#   )
#   updateMarkers()
# })


# updateMarkers <- function(){
#   
#   len <- nrow(dt$trialSites)
#   leafletProxy("mymap1a") %>%
#           addMarkers(lng=as.numeric(dt$trialSites[1,13]), lat=as.numeric(dt$trialSites[1,14]))
#   isolate({
#     # leafletProxy("mymap1a") %>% clearMarkers()
#     for (i in 1:len){
#       leafletProxy("mymap1a") %>%
#         addMarkers(lng=as.numeric(dt$trialSites[i,13]), lat=as.numeric(dt$trialSites[i,14]))
#     }
#   })
# }

# df1 = data.frame(
#   lat = dt$trialSites[,13],
#   lng = dt$trialSites[,14]
# )
# 
#   output$mymap1a <- renderLeaflet(
#     
#     print(df1),
#     leaflet() %>%
#           addTiles(df1) %>%  # Add default OpenStreetMap map tiles
#           # addMarkers(data = df)  %>%
#           setView(lng = -4.04296, lat = 16.30796, zoom = 2) #%>%
#   )

updateSiteRDS <- function(){
  mydb = dbConnect(MySQL(), user=constUserDB, password=constPassDB, dbname=constDBName, host=constDBHost)

  strQry = paste0("SELECT
                  id,
                  user_id,
                   var12,
                   var1,
                   var2,
                   var3,
                   var4,
                   var5,
                   var6,
                   var7,
                   var8,
                   var9,
                   var10,
                   var11,
                   var13,
                   created
                   FROM user_sites
                   order by created DESC, id DESC")
  qryMySites = dbSendQuery(mydb,strQry)
  allSites = fetch(qryMySites, n=-1)
  df_allSites <- data.frame(allSites)
  # "/home/obenites/HIDAP_SB_1.0.0/hidap/inst/hidap_agrofims"

  headers_sites <- c("id","userId", "shortn", "Type" , "local", "cntry", "adm1", "adm2", "admin3", "elev", "latd" , "lond", "village", "nearpop" , "admin4", "date_creation")
  names(df_allSites) <- headers_sites
  path <- fbglobal::get_base_dir()
  path <- file.path(path, "table_sites_agrofims.rds")
  print(path)
  # saveRDS(df_allSites, file = "/home/obenites/HIDAP_SB_1.0.0/hidap/inst/hidap_agrofims/www/internal_files/table_sites_agrofims.rds")
  saveRDS(df_allSites, file = path)

  dbDisconnect(mydb)
}

observeEvent(input$siteClick,{


  # leaflet("mymap1a") %>%
  #   addMarkers(lng=-7.611575, lat=-72.552344, popup="The birthplace")


  if (input$siteClickId%like%"siteView"){

    row_to_view = as.numeric(gsub("siteView_","",input$siteClickId))
    # print(paste0("view:", row_to_view))
    showModal(modalViewSite(row_to_view))
  }
  else if (input$siteClickId%like%"siteEdit"){

    row_to_edit = as.numeric(gsub("siteEdit_","",input$siteClickId))
    output$trialScreen <- renderUI({
      uiTrialSiteNew(dt$trialSites[row_to_edit,])
    })
    # sitesValues$clickToEdit <- T
  }

  else if (input$siteClickId%like%"siteDelete"){

    row_to_delete = as.numeric(gsub("siteDelete_","",input$siteClickId))
    # dt$trialSites <- dt$trialSites[-row_to_delete, ]

    dt$trialSites <- deleteSite(row_to_delete)
    names(dt$trialSites) <- columnNames
    shinyalert("Success", "Site was successfully deleted", type = "success")
    # updateMarkers()
  }
})


modalViewSite <- function(pSiteID){
  nm <- names(dt$trialSites)
  len <- length(nm)
  vals  <- dt$trialSites[pSiteID,]
  ml <- c(vals[[2]])
  for (i in 3:len){
    ml <-c(ml, vals[[i]])
  }
  list <-data.frame(Variable = names(vals[,-1]),  Value = ml)

  modalDialog(
    fluidPage(
      h3(strong("Site information"),align="center"),
      hr(),
      HTML("<center>"),
      renderTable(list, align = "rl"),
      HTML("</center>")

    )
  )
}


deleteSite <- function(pSiteID){

  dbId <- dt$trialSites[pSiteID,1]
  mydb = dbConnect(MySQL(), user=constUserDB, password=constPassDB, dbname=constDBName, host=constDBHost)
  strQry = paste0("DELETE FROM user_sites
                   WHERE user_id = ", USER$id,
                  " AND id = " , dbId)

  qryMyfiles = dbSendQuery(mydb,strQry)
  dbDisconnect(mydb)
  updateSiteRDS()
  return(updTrialSites())
  # dt$trialSites <- dt$trialSites[-pSiteID,]

}

updTrialSites <- function() {
  mydb = dbConnect(MySQL(), user=constUserDB, password=constPassDB, dbname=constDBName, host=constDBHost)
  strQry = paste0("SELECT
                  id,
                   var12,
                   var1,
                   var2,
                   var3,
                   var4,
                   var5,
                   var6,
                   var13,
                   var10,
                   var11,
                   var7,
                   var8,
                   var9,
                   
                   created
                   FROM user_sites
                   WHERE user_id = ", USER$id,
                  " order by created DESC, id DESC")
  qryMyfiles = dbSendQuery(mydb,strQry)
  myFiles = fetch(qryMyfiles, n=-1)
  df_withMe <- data.frame(myFiles)
  dbDisconnect(mydb)
  return(df_withMe)
}


### to do: function to validate new site inputs
validateNewList <- function(){
  return(TRUE)
}
