tabsetPanel(id= "",
            #abBox(height = NULL, width = 12,
            tabPanel("Fertilization details", value="tab111",
                     #fluidRow(
                     column(width = 12,
                            #br(),
                            h2("Fertilization details"),
                            fluidRow(
                              # box(title = "Fertilization details",
                              #     status = "primary",
                              #     solidHeader = TRUE,
                              #     width = 12, collapsible = TRUE,
                              column(width = 6,
                                     selectizeInput(inputId = "napplications", label = "Number of applications", multiple = TRUE, options = list(maxItems =1, placeholder ="Select one..."), choices = 1:5)
                              ),

                              box(
                                title = tagList(shiny::icon("edit"), "Application #1"), solidHeader = TRUE, status = "warning", width=12,
                                column(width = 6,
                                       fluidRow(
                                         fluidRow(
                                           column(width = 6,
                                                  textInput("fert_TotalQty1", label = "Fertilizer total quantity")
                                           ),
                                           column(width = 6,
                                                  selectizeInput("fert_TotalQty_unit1", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                    "kg/m2",
                                                    "kg/ha",
                                                    "t/ha")
                                                  )
                                           )
                                         )
                                       ),
                                       fluidRow(
                                         fluidRow(
                                           column(width = 6,
                                                  dateInput("fertilization_start_date", label ="Start date", format = "dd/mm/yyyy")
                                           ),
                                           column(width = 6,
                                                  dateInput("fertilization_end_date", label ="End date", format = "dd/mm/yyyy")
                                           )
                                         )
                                       ),

                                       fluidRow(
                                         fluidRow(
                                           column(width = 6,
                                                  selectizeInput("app1fTypeFertilizer", "Type of fertilizer", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."),
                                                                 choices=c("Inorganic", "Organic")
                                                  )
                                           ),
                                           column(width = 6,

                                                  conditionalPanel("input.app1fTypeFertilizer == 'Inorganic'",
                                                                   selectizeInput("typeInorganic",multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of inorganic fertilizer", choices =c(
                                                                     "Ammonium nitrate",
                                                                     "Ammonium nitrate sulfate",
                                                                     "Ammonium polyphosphate",
                                                                     "Ammonium sulfate",
                                                                     "Anhydrous ammonia",
                                                                     "Aqua ammonia",
                                                                     "Calcitic limestone",
                                                                     "Calcium ammonium nitrate solution",
                                                                     "Calcium hydroxide",
                                                                     "Calcium nitrate",
                                                                     "Diammnoium phosphate",
                                                                     "Dolomitic limestone",
                                                                     "Liquid phosphoric acid",
                                                                     "Monoammonium phosphate",
                                                                     "Potassium chloride",
                                                                     "Potassium nitrate",
                                                                     "Potassium sulfate",
                                                                     "Rock phosphate",
                                                                     "Single super phosphate",
                                                                     "Triple super phosphate",
                                                                     "Urea",
                                                                     "Urea ammonium nitrate solution",
                                                                     "Urea super granules")
                                                                   )
                                                  ),

                                                  conditionalPanel("input.app1fTypeFertilizer == 'Organic'",
                                                                   selectizeInput("typeOrganic", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of organic fertilizer", choices =c(
                                                                     "Alfalfa Meal",
                                                                     "Bagasse",
                                                                     "Biochar",
                                                                     "Blood meal",
                                                                     "Bone meal",
                                                                     "Chicken litter",
                                                                     "Compost",
                                                                     "Cottonseed Meal",
                                                                     "Farmyard manure",
                                                                     "Fish emulsion",
                                                                     "Fish manure",
                                                                     "Fish meal",
                                                                     "Green manure",
                                                                     "Guano",
                                                                     "Hydrolyzed Fish",
                                                                     "Liquid manure",
                                                                     "Oil cake",
                                                                     "Peat",
                                                                     "Spent mushroom compost",
                                                                     "Treated sewage sludge")
                                                                   )
                                                  )
                                           )
                                         ),

                                         fileInput("fert_picture", "Fertilizer picture", accept = c('image/png', 'image/jpeg')),
                                         selectizeInput("fert_appTechnique", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Application technique", choices =c(
                                           "Band application beneath surface",
                                           "Band application on surface",
                                           "Broadcast incorporated",
                                           "Contact placement",
                                           "Deep placement",
                                           "Fertigation",
                                           "Foliar application",
                                           "Injection",
                                           "Placed with seed",
                                           "Plough sole placement",
                                           "Side dressing",
                                           "Sub-soil placement",
                                           "Topdressing")
                                         ),
                                         textInput("fert_appDepth", label="Application depth", value = ""),
                                         fluidRow(
                                           column(width = 6,
                                                  textInput("fert_fert_recommendRate", label = "Fertilizer recommended rate")
                                           ),
                                           column(width = 6,
                                                  selectizeInput("fert_recommendRate_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                    "kg/m2",
                                                    "kg/ha",
                                                    "t/ha")
                                                  )
                                           )
                                         ),
                                         textInput("fert_percApplied", label="Percentage of fertilizer recommended rate applied", value = "")
                                       )
                                ),
                                column(width = 6,
                                       box(
                                         title = "Fertilizer implement", solidHeader = TRUE, status = "info", width=12,
                                         selectizeInput("fert_implement", "Implement", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                        choices = c(
                                                          "Airblast sprayer",
                                                          "Backpack sprayer",
                                                          "Boom sprayer",
                                                          "Broadcast spreader",
                                                          "Hand sprayer",
                                                          "Manure spreader",
                                                          "Slurry injector")
                                         ),
                                         fileInput("fert_implementPicture", "Picture", accept = c('image/png', 'image/jpeg')),
                                         textInput("fert_implementMake", "Implement make", value= ""),
                                         textInput("fert_implementModel", "Implement model", value= ""),
                                         selectizeInput("fert_animalTraction", "Animal traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                        choices = c(
                                                          "Buffalo",
                                                          "Camel",
                                                          "Donkey",
                                                          "Elephant",
                                                          "Horse",
                                                          "Mule",
                                                          "Ox / Bullock / Steer",
                                                          "Other")
                                         ),
                                         textInput("fert_humanPowered", "Human powered", value= ""),
                                         selectizeInput("fert_motorizedTraction", "Motorized traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                        choices = c(
                                                          "2 wheel tractor",
                                                          "4 wheel tractor",
                                                          "Other")
                                         ),
                                         textInput("fert_tractotFieldSpeed", "Tractor field speed", value= "")


                                       ),
                                       box(
                                         title = "Nutrient management event", solidHeader = TRUE, status = "info", width=12,
                                         selectizeInput("fert_nutrientConcApplied", "Nutrient concentration in fertilizer applied", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                        choices = c(
                                                          "Nitrogen",
                                                          "Phosphorus",
                                                          "Potassium",
                                                          "Nitrate",
                                                          "Ammonium",
                                                          "Calcium",
                                                          "Sulphur",
                                                          "Sulphur",
                                                          "Magnesium",
                                                          "Iron",
                                                          "Zinc",
                                                          "Copper",
                                                          "Boron",
                                                          "Molybdenum",
                                                          "Manganese",
                                                          "Chlorine")
                                         )
                                       )
                                )
                              ),



                              conditionalPanel("input.napplications == 2  |
                                               input.napplications == 3  |
                                               input.napplications == 4 |
                                               input.napplications == 5",
                                               box(
                                                 title = tagList(shiny::icon("edit"), "Application #2"), solidHeader = TRUE, status = "warning", width=12,
                                                 column(width = 6,
                                                        fluidRow(
                                                          fluidRow(
                                                            column(width = 6,
                                                                   textInput("fert_TotalQty2", label = "Fertilizer total quantity")
                                                            ),
                                                            column(width = 6,
                                                                   selectizeInput("fert_TotalQty_unit2", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                                     "kg/m2",
                                                                     "kg/ha",
                                                                     "t/ha")
                                                                   )
                                                            )
                                                          )
                                                        ),
                                                        fluidRow(

                                                          fluidRow(
                                                            column(width = 6,
                                                                   dateInput("fertilization_start_date2", label ="Start date", format = "dd/mm/yyyy")
                                                            ),
                                                            column(width = 6,
                                                                   dateInput("fertilization_end_date2", label ="End date", format = "dd/mm/yyyy")
                                                            )
                                                          )
                                                        ),

                                                        fluidRow(
                                                          fluidRow(
                                                            column(width = 6,
                                                                   selectizeInput("app2fTypeFertilizer", "Type of fertilizer", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."),
                                                                                  choices=c("Inorganic", "Organic")
                                                                   )
                                                            ),
                                                            column(width = 6,

                                                                   conditionalPanel("input.app2fTypeFertilizer == 'Inorganic'",
                                                                                    selectizeInput("typeInorganic2",multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of inorganic fertilizer", choices =c(
                                                                                      "Ammonium nitrate",
                                                                                      "Ammonium nitrate sulfate",
                                                                                      "Ammonium polyphosphate",
                                                                                      "Ammonium sulfate",
                                                                                      "Anhydrous ammonia",
                                                                                      "Aqua ammonia",
                                                                                      "Calcitic limestone",
                                                                                      "Calcium ammonium nitrate solution",
                                                                                      "Calcium hydroxide",
                                                                                      "Calcium nitrate",
                                                                                      "Diammnoium phosphate",
                                                                                      "Dolomitic limestone",
                                                                                      "Liquid phosphoric acid",
                                                                                      "Monoammonium phosphate",
                                                                                      "Potassium chloride",
                                                                                      "Potassium nitrate",
                                                                                      "Potassium sulfate",
                                                                                      "Rock phosphate",
                                                                                      "Single super phosphate",
                                                                                      "Triple super phosphate",
                                                                                      "Urea",
                                                                                      "Urea ammonium nitrate solution",
                                                                                      "Urea super granules")
                                                                                    )
                                                                   ),

                                                                   conditionalPanel("input.app2fTypeFertilizer == 'Organic'",
                                                                                    selectizeInput("typeOrganic2", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of organic fertilizer", choices =c(
                                                                                      "Alfalfa Meal",
                                                                                      "Bagasse",
                                                                                      "Biochar",
                                                                                      "Blood meal",
                                                                                      "Bone meal",
                                                                                      "Chicken litter",
                                                                                      "Compost",
                                                                                      "Cottonseed Meal",
                                                                                      "Farmyard manure",
                                                                                      "Fish emulsion",
                                                                                      "Fish manure",
                                                                                      "Fish meal",
                                                                                      "Green manure",
                                                                                      "Guano",
                                                                                      "Hydrolyzed Fish",
                                                                                      "Liquid manure",
                                                                                      "Oil cake",
                                                                                      "Peat",
                                                                                      "Spent mushroom compost",
                                                                                      "Treated sewage sludge")
                                                                                    )
                                                                   )
                                                            )
                                                          ),

                                                          fileInput("fert_picture2", "Fertilizer picture", accept = c('image/png', 'image/jpeg')),
                                                          selectizeInput("fert_appTechnique2", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Application technique", choices =c(
                                                            "Band application beneath surface",
                                                            "Band application on surface",
                                                            "Broadcast incorporated",
                                                            "Contact placement",
                                                            "Deep placement",
                                                            "Fertigation",
                                                            "Foliar application",
                                                            "Injection",
                                                            "Placed with seed",
                                                            "Plough sole placement",
                                                            "Side dressing",
                                                            "Sub-soil placement",
                                                            "Topdressing")
                                                          ),
                                                          textInput("fert_appDepth2", label="Application depth", value = ""),
                                                          fluidRow(
                                                            column(width = 6,
                                                                   textInput("fert_fert_recommendRate2", label = "Fertilizer recommended rate")
                                                            ),
                                                            column(width = 6,
                                                                   selectizeInput("fert_recommendRate_unit2", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                                     "kg/m2",
                                                                     "kg/ha",
                                                                     "t/ha")
                                                                   )
                                                            )
                                                          ),
                                                          textInput("fert_percApplied2", label="Percentage of fertilizer recommended rate applied", value = "")
                                                        )
                                                 ),
                                                 column(width = 6,
                                                        box(
                                                          title = "Fertilizer implement", solidHeader = TRUE, status = "info", width=12,
                                                          selectizeInput("fert_implement2", "Implement", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Airblast sprayer",
                                                                           "Backpack sprayer",
                                                                           "Boom sprayer",
                                                                           "Broadcast spreader",
                                                                           "Hand sprayer",
                                                                           "Manure spreader",
                                                                           "Slurry injector")
                                                          ),
                                                          fileInput("fert_implementPicture2", "Picture", accept = c('image/png', 'image/jpeg')),
                                                          textInput("fert_implementMake2", "Implement make", value= ""),
                                                          textInput("fert_implementModel2", "Implement model", value= ""),
                                                          selectizeInput("fert_animalTraction2", "Animal traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Buffalo",
                                                                           "Camel",
                                                                           "Donkey",
                                                                           "Elephant",
                                                                           "Horse",
                                                                           "Mule",
                                                                           "Ox / Bullock / Steer",
                                                                           "Other")
                                                          ),
                                                          textInput("fert_humanPowered2", "Human powered", value= ""),
                                                          selectizeInput("fert_motorizedTraction2", "Motorized traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "2 wheel tractor",
                                                                           "4 wheel tractor",
                                                                           "Other")
                                                          ),
                                                          textInput("fert_tractotFieldSpeed2", "Tractor field speed", value= "")


                                                        ),
                                                        box(
                                                          title = "Nutrient management event", solidHeader = TRUE, status = "info", width=12,
                                                          selectizeInput("fert_nutrientConcApplied2", "Nutrient concentration in fertilizer applied", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Nitrogen",
                                                                           "Phosphorus",
                                                                           "Potassium",
                                                                           "Nitrate",
                                                                           "Ammonium",
                                                                           "Calcium",
                                                                           "Sulphur",
                                                                           "Sulphur",
                                                                           "Magnesium",
                                                                           "Iron",
                                                                           "Zinc",
                                                                           "Copper",
                                                                           "Boron",
                                                                           "Molybdenum",
                                                                           "Manganese",
                                                                           "Chlorine")
                                                          )
                                                        )
                                                 )

                                               )


                              ),#end condpanel2
                              conditionalPanel("input.napplications == 3  |
                                               input.napplications == 4 |
                                               input.napplications == 5",
                                               box(
                                                 title = tagList(shiny::icon("edit"), "Application #3"), solidHeader = TRUE, status = "warning", width=12,
                                                 column(width = 6,
                                                        fluidRow(
                                                          fluidRow(
                                                            column(width = 6,
                                                                   textInput("fert_TotalQty3", label = "Fertilizer total quantity")
                                                            ),
                                                            column(width = 6,
                                                                   selectizeInput("fert_TotalQty_unit3", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                                     "kg/m2",
                                                                     "kg/ha",
                                                                     "t/ha")
                                                                   )
                                                            )
                                                          )
                                                        ),
                                                        fluidRow(

                                                          fluidRow(
                                                            column(width = 6,
                                                                   dateInput("fertilization_start_date3", label ="Start date", format = "dd/mm/yyyy")
                                                            ),
                                                            column(width = 6,
                                                                   dateInput("fertilization_end_date3", label ="End date", format = "dd/mm/yyyy")
                                                            )
                                                          )
                                                        ),

                                                        fluidRow(
                                                          fluidRow(
                                                            column(width = 6,
                                                                   selectizeInput("app3fTypeFertilizer", "Type of fertilizer", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."),
                                                                                  choices=c("Inorganic", "Organic")
                                                                   )
                                                            ),
                                                            column(width = 6,

                                                                   conditionalPanel("input.app3fTypeFertilizer == 'Inorganic'",
                                                                                    selectizeInput("typeInorganic3",multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of inorganic fertilizer", choices =c(
                                                                                      "Ammonium nitrate",
                                                                                      "Ammonium nitrate sulfate",
                                                                                      "Ammonium polyphosphate",
                                                                                      "Ammonium sulfate",
                                                                                      "Anhydrous ammonia",
                                                                                      "Aqua ammonia",
                                                                                      "Calcitic limestone",
                                                                                      "Calcium ammonium nitrate solution",
                                                                                      "Calcium hydroxide",
                                                                                      "Calcium nitrate",
                                                                                      "Diammnoium phosphate",
                                                                                      "Dolomitic limestone",
                                                                                      "Liquid phosphoric acid",
                                                                                      "Monoammonium phosphate",
                                                                                      "Potassium chloride",
                                                                                      "Potassium nitrate",
                                                                                      "Potassium sulfate",
                                                                                      "Rock phosphate",
                                                                                      "Single super phosphate",
                                                                                      "Triple super phosphate",
                                                                                      "Urea",
                                                                                      "Urea ammonium nitrate solution",
                                                                                      "Urea super granules")
                                                                                    )
                                                                   ),

                                                                   conditionalPanel("input.app3fTypeFertilizer == 'Organic'",
                                                                                    selectizeInput("typeOrganic3", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of organic fertilizer", choices =c(
                                                                                      "Alfalfa Meal",
                                                                                      "Bagasse",
                                                                                      "Biochar",
                                                                                      "Blood meal",
                                                                                      "Bone meal",
                                                                                      "Chicken litter",
                                                                                      "Compost",
                                                                                      "Cottonseed Meal",
                                                                                      "Farmyard manure",
                                                                                      "Fish emulsion",
                                                                                      "Fish manure",
                                                                                      "Fish meal",
                                                                                      "Green manure",
                                                                                      "Guano",
                                                                                      "Hydrolyzed Fish",
                                                                                      "Liquid manure",
                                                                                      "Oil cake",
                                                                                      "Peat",
                                                                                      "Spent mushroom compost",
                                                                                      "Treated sewage sludge")
                                                                                    )
                                                                   )
                                                            )
                                                          ),

                                                          fileInput("fert_picture3", "Fertilizer picture", accept = c('image/png', 'image/jpeg')),
                                                          selectizeInput("fert_appTechnique3", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Application technique", choices =c(
                                                            "Band application beneath surface",
                                                            "Band application on surface",
                                                            "Broadcast incorporated",
                                                            "Contact placement",
                                                            "Deep placement",
                                                            "Fertigation",
                                                            "Foliar application",
                                                            "Injection",
                                                            "Placed with seed",
                                                            "Plough sole placement",
                                                            "Side dressing",
                                                            "Sub-soil placement",
                                                            "Topdressing")
                                                          ),
                                                          textInput("fert_appDepth3", label="Application depth", value = ""),
                                                          fluidRow(
                                                            column(width = 6,
                                                                   textInput("fert_fert_recommendRate3", label = "Fertilizer recommended rate")
                                                            ),
                                                            column(width = 6,
                                                                   selectizeInput("fert_recommendRate_unit3", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                                     "kg/m2",
                                                                     "kg/ha",
                                                                     "t/ha")
                                                                   )
                                                            )
                                                          ),
                                                          textInput("fert_percApplied3", label="Percentage of fertilizer recommended rate applied", value = "")
                                                        )
                                                 ),
                                                 column(width = 6,
                                                        box(
                                                          title = "Fertilizer implement", solidHeader = TRUE, status = "info", width=12,
                                                          selectizeInput("fert_implement3", "Implement", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Airblast sprayer",
                                                                           "Backpack sprayer",
                                                                           "Boom sprayer",
                                                                           "Broadcast spreader",
                                                                           "Hand sprayer",
                                                                           "Manure spreader",
                                                                           "Slurry injector")
                                                          ),
                                                          fileInput("fert_implementPicture3", "Picture", accept = c('image/png', 'image/jpeg')),
                                                          textInput("fert_implementMake3", "Implement make", value= ""),
                                                          textInput("fert_implementModel3", "Implement model", value= ""),
                                                          selectizeInput("fert_animalTraction3", "Animal traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Buffalo",
                                                                           "Camel",
                                                                           "Donkey",
                                                                           "Elephant",
                                                                           "Horse",
                                                                           "Mule",
                                                                           "Ox / Bullock / Steer",
                                                                           "Other")
                                                          ),
                                                          textInput("fert_humanPowered3", "Human powered", value= ""),
                                                          selectizeInput("fert_motorizedTraction3", "Motorized traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "2 wheel tractor",
                                                                           "4 wheel tractor",
                                                                           "Other")
                                                          ),
                                                          textInput("fert_tractotFieldSpeed3", "Tractor field speed", value= "")


                                                        ),
                                                        box(
                                                          title = "Nutrient management event", solidHeader = TRUE, status = "info", width=12,
                                                          selectizeInput("fert_nutrientConcApplied3", "Nutrient concentration in fertilizer applied", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Nitrogen",
                                                                           "Phosphorus",
                                                                           "Potassium",
                                                                           "Nitrate",
                                                                           "Ammonium",
                                                                           "Calcium",
                                                                           "Sulphur",
                                                                           "Sulphur",
                                                                           "Magnesium",
                                                                           "Iron",
                                                                           "Zinc",
                                                                           "Copper",
                                                                           "Boron",
                                                                           "Molybdenum",
                                                                           "Manganese",
                                                                           "Chlorine")
                                                          )
                                                        )
                                                 )

                                               )


                              ),#end conPanel 3
                              conditionalPanel("input.napplications == 4 |
                                               input.napplications == 5",
                                               box(
                                                 title = tagList(shiny::icon("edit"), "Application #4"), solidHeader = TRUE, status = "warning", width=12,
                                                 column(width = 6,
                                                        fluidRow(
                                                          fluidRow(
                                                            column(width = 6,
                                                                   textInput("fert_TotalQty4", label = "Fertilizer total quantity")
                                                            ),
                                                            column(width = 6,
                                                                   selectizeInput("fert_TotalQty_unit4", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                                     "kg/m2",
                                                                     "kg/ha",
                                                                     "t/ha")
                                                                   )
                                                            )
                                                          )
                                                        ),
                                                        fluidRow(

                                                          fluidRow(
                                                            column(width = 6,
                                                                   dateInput("fertilization_start_date4", label ="Start date", format = "dd/mm/yyyy")
                                                            ),
                                                            column(width = 6,
                                                                   dateInput("fertilization_end_date4", label ="End date", format = "dd/mm/yyyy")
                                                            )
                                                          )
                                                        ),

                                                        fluidRow(
                                                          fluidRow(
                                                            column(width = 6,
                                                                   selectizeInput("app4fTypeFertilizer", "Type of fertilizer", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."),
                                                                                  choices=c("Inorganic", "Organic")
                                                                   )
                                                            ),
                                                            column(width = 6,

                                                                   conditionalPanel("input.app4fTypeFertilizer == 'Inorganic'",
                                                                                    selectizeInput("typeInorganic4",multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of inorganic fertilizer", choices =c(
                                                                                      "Ammonium nitrate",
                                                                                      "Ammonium nitrate sulfate",
                                                                                      "Ammonium polyphosphate",
                                                                                      "Ammonium sulfate",
                                                                                      "Anhydrous ammonia",
                                                                                      "Aqua ammonia",
                                                                                      "Calcitic limestone",
                                                                                      "Calcium ammonium nitrate solution",
                                                                                      "Calcium hydroxide",
                                                                                      "Calcium nitrate",
                                                                                      "Diammnoium phosphate",
                                                                                      "Dolomitic limestone",
                                                                                      "Liquid phosphoric acid",
                                                                                      "Monoammonium phosphate",
                                                                                      "Potassium chloride",
                                                                                      "Potassium nitrate",
                                                                                      "Potassium sulfate",
                                                                                      "Rock phosphate",
                                                                                      "Single super phosphate",
                                                                                      "Triple super phosphate",
                                                                                      "Urea",
                                                                                      "Urea ammonium nitrate solution",
                                                                                      "Urea super granules")
                                                                                    )
                                                                   ),

                                                                   conditionalPanel("input.app4fTypeFertilizer == 'Organic'",
                                                                                    selectizeInput("typeOrganic4", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of organic fertilizer", choices =c(
                                                                                      "Alfalfa Meal",
                                                                                      "Bagasse",
                                                                                      "Biochar",
                                                                                      "Blood meal",
                                                                                      "Bone meal",
                                                                                      "Chicken litter",
                                                                                      "Compost",
                                                                                      "Cottonseed Meal",
                                                                                      "Farmyard manure",
                                                                                      "Fish emulsion",
                                                                                      "Fish manure",
                                                                                      "Fish meal",
                                                                                      "Green manure",
                                                                                      "Guano",
                                                                                      "Hydrolyzed Fish",
                                                                                      "Liquid manure",
                                                                                      "Oil cake",
                                                                                      "Peat",
                                                                                      "Spent mushroom compost",
                                                                                      "Treated sewage sludge")
                                                                                    )
                                                                   )
                                                            )
                                                          ),

                                                          fileInput("fert_picture4", "Fertilizer picture", accept = c('image/png', 'image/jpeg')),
                                                          selectizeInput("fert_appTechnique4", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Application technique", choices =c(
                                                            "Band application beneath surface",
                                                            "Band application on surface",
                                                            "Broadcast incorporated",
                                                            "Contact placement",
                                                            "Deep placement",
                                                            "Fertigation",
                                                            "Foliar application",
                                                            "Injection",
                                                            "Placed with seed",
                                                            "Plough sole placement",
                                                            "Side dressing",
                                                            "Sub-soil placement",
                                                            "Topdressing")
                                                          ),
                                                          textInput("fert_appDepth4", label="Application depth", value = ""),
                                                          fluidRow(
                                                            column(width = 6,
                                                                   textInput("fert_fert_recommendRate4", label = "Fertilizer recommended rate")
                                                            ),
                                                            column(width = 6,
                                                                   selectizeInput("fert_recommendRate_unit4", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                                     "kg/m2",
                                                                     "kg/ha",
                                                                     "t/ha")
                                                                   )
                                                            )
                                                          ),
                                                          textInput("fert_percApplied4", label="Percentage of fertilizer recommended rate applied", value = "")
                                                        )
                                                 ),
                                                 column(width = 6,
                                                        box(
                                                          title = "Fertilizer implement", solidHeader = TRUE, status = "info", width=12,
                                                          selectizeInput("fert_implement4", "Implement", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Airblast sprayer",
                                                                           "Backpack sprayer",
                                                                           "Boom sprayer",
                                                                           "Broadcast spreader",
                                                                           "Hand sprayer",
                                                                           "Manure spreader",
                                                                           "Slurry injector")
                                                          ),
                                                          fileInput("fert_implementPicture4", "Picture", accept = c('image/png', 'image/jpeg')),
                                                          textInput("fert_implementMake4", "Implement make", value= ""),
                                                          textInput("fert_implementModel4", "Implement model", value= ""),
                                                          selectizeInput("fert_animalTraction4", "Animal traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Buffalo",
                                                                           "Camel",
                                                                           "Donkey",
                                                                           "Elephant",
                                                                           "Horse",
                                                                           "Mule",
                                                                           "Ox / Bullock / Steer",
                                                                           "Other")
                                                          ),
                                                          textInput("fert_humanPowered4", "Human powered", value= ""),
                                                          selectizeInput("fert_motorizedTraction4", "Motorized traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "2 wheel tractor",
                                                                           "4 wheel tractor",
                                                                           "Other")
                                                          ),
                                                          textInput("fert_tractotFieldSpeed4", "Tractor field speed", value= "")


                                                        ),
                                                        box(
                                                          title = "Nutrient management event", solidHeader = TRUE, status = "info", width=12,
                                                          selectizeInput("fert_nutrientConcApplied4", "Nutrient concentration in fertilizer applied", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Nitrogen",
                                                                           "Phosphorus",
                                                                           "Potassium",
                                                                           "Nitrate",
                                                                           "Ammonium",
                                                                           "Calcium",
                                                                           "Sulphur",
                                                                           "Sulphur",
                                                                           "Magnesium",
                                                                           "Iron",
                                                                           "Zinc",
                                                                           "Copper",
                                                                           "Boron",
                                                                           "Molybdenum",
                                                                           "Manganese",
                                                                           "Chlorine")
                                                          )
                                                        )
                                                 )

                                               )


                              ),#end conPanel 4
                              conditionalPanel("input.napplications == 5",
                                               box(
                                                 title = tagList(shiny::icon("edit"), "Application #5"), solidHeader = TRUE, status = "warning", width=12,
                                                 column(width = 6,
                                                        fluidRow(
                                                          fluidRow(
                                                            column(width = 6,
                                                                   textInput("fert_TotalQty5", label = "Fertilizer total quantity")
                                                            ),
                                                            column(width = 6,
                                                                   selectizeInput("fert_TotalQty_unit5", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                                     "kg/m2",
                                                                     "kg/ha",
                                                                     "t/ha")
                                                                   )
                                                            )
                                                          )
                                                        ),
                                                        fluidRow(

                                                          fluidRow(
                                                            column(width = 6,
                                                                   dateInput("fertilization_start_date5", label ="Start date", format = "dd/mm/yyyy")
                                                            ),
                                                            column(width = 6,
                                                                   dateInput("fertilization_end_date5", label ="End date", format = "dd/mm/yyyy")
                                                            )
                                                          )
                                                        ),

                                                        fluidRow(
                                                          fluidRow(
                                                            column(width = 6,
                                                                   selectizeInput("app5fTypeFertilizer", "Type of fertilizer", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."),
                                                                                  choices=c("Inorganic", "Organic")
                                                                   )
                                                            ),
                                                            column(width = 6,

                                                                   conditionalPanel("input.app5fTypeFertilizer == 'Inorganic'",
                                                                                    selectizeInput("typeInorganic5",multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of inorganic fertilizer", choices =c(
                                                                                      "Ammonium nitrate",
                                                                                      "Ammonium nitrate sulfate",
                                                                                      "Ammonium polyphosphate",
                                                                                      "Ammonium sulfate",
                                                                                      "Anhydrous ammonia",
                                                                                      "Aqua ammonia",
                                                                                      "Calcitic limestone",
                                                                                      "Calcium ammonium nitrate solution",
                                                                                      "Calcium hydroxide",
                                                                                      "Calcium nitrate",
                                                                                      "Diammnoium phosphate",
                                                                                      "Dolomitic limestone",
                                                                                      "Liquid phosphoric acid",
                                                                                      "Monoammonium phosphate",
                                                                                      "Potassium chloride",
                                                                                      "Potassium nitrate",
                                                                                      "Potassium sulfate",
                                                                                      "Rock phosphate",
                                                                                      "Single super phosphate",
                                                                                      "Triple super phosphate",
                                                                                      "Urea",
                                                                                      "Urea ammonium nitrate solution",
                                                                                      "Urea super granules")
                                                                                    )
                                                                   ),

                                                                   conditionalPanel("input.app3fTypeFertilizer == 'Organic'",
                                                                                    selectizeInput("typeOrganic5", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Type of organic fertilizer", choices =c(
                                                                                      "Alfalfa Meal",
                                                                                      "Bagasse",
                                                                                      "Biochar",
                                                                                      "Blood meal",
                                                                                      "Bone meal",
                                                                                      "Chicken litter",
                                                                                      "Compost",
                                                                                      "Cottonseed Meal",
                                                                                      "Farmyard manure",
                                                                                      "Fish emulsion",
                                                                                      "Fish manure",
                                                                                      "Fish meal",
                                                                                      "Green manure",
                                                                                      "Guano",
                                                                                      "Hydrolyzed Fish",
                                                                                      "Liquid manure",
                                                                                      "Oil cake",
                                                                                      "Peat",
                                                                                      "Spent mushroom compost",
                                                                                      "Treated sewage sludge")
                                                                                    )
                                                                   )
                                                            )
                                                          ),

                                                          fileInput("fert_picture5", "Fertilizer picture", accept = c('image/png', 'image/jpeg')),
                                                          selectizeInput("fert_appTechnique5", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select type..."), label ="Application technique", choices =c(
                                                            "Band application beneath surface",
                                                            "Band application on surface",
                                                            "Broadcast incorporated",
                                                            "Contact placement",
                                                            "Deep placement",
                                                            "Fertigation",
                                                            "Foliar application",
                                                            "Injection",
                                                            "Placed with seed",
                                                            "Plough sole placement",
                                                            "Side dressing",
                                                            "Sub-soil placement",
                                                            "Topdressing")
                                                          ),
                                                          textInput("fert_appDepth5", label="Application depth", value = ""),
                                                          fluidRow(
                                                            column(width = 6,
                                                                   textInput("fert_fert_recommendRate5", label = "Fertilizer recommended rate")
                                                            ),
                                                            column(width = 6,
                                                                   selectizeInput("fert_recommendRate_unit5", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select unit ..."), label ="Unit", choices =c(
                                                                     "kg/m2",
                                                                     "kg/ha",
                                                                     "t/ha")
                                                                   )
                                                            )
                                                          ),
                                                          textInput("fert_percApplied5", label="Percentage of fertilizer recommended rate applied", value = "")
                                                        )
                                                 ),
                                                 column(width = 6,
                                                        box(
                                                          title = "Fertilizer implement", solidHeader = TRUE, status = "info", width=12,
                                                          selectizeInput("fert_implement5", "Implement", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Airblast sprayer",
                                                                           "Backpack sprayer",
                                                                           "Boom sprayer",
                                                                           "Broadcast spreader",
                                                                           "Hand sprayer",
                                                                           "Manure spreader",
                                                                           "Slurry injector")
                                                          ),
                                                          fileInput("fert_implementPicture5", "Picture", accept = c('image/png', 'image/jpeg')),
                                                          textInput("fert_implementMake5", "Implement make", value= ""),
                                                          textInput("fert_implementModel5", "Implement model", value= ""),
                                                          selectizeInput("fert_animalTraction5", "Animal traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Buffalo",
                                                                           "Camel",
                                                                           "Donkey",
                                                                           "Elephant",
                                                                           "Horse",
                                                                           "Mule",
                                                                           "Ox / Bullock / Steer",
                                                                           "Other")
                                                          ),
                                                          textInput("fert_humanPowered5", "Human powered", value= ""),
                                                          selectizeInput("fert_motorizedTraction5", "Motorized traction", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "2 wheel tractor",
                                                                           "4 wheel tractor",
                                                                           "Other")
                                                          ),
                                                          textInput("fert_tractotFieldSpeed5", "Tractor field speed", value= "")


                                                        ),
                                                        box(
                                                          title = "Nutrient management event", solidHeader = TRUE, status = "info", width=12,
                                                          selectizeInput("fert_nutrientConcApplied5", "Nutrient concentration in fertilizer applied", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."),
                                                                         choices = c(
                                                                           "Nitrogen",
                                                                           "Phosphorus",
                                                                           "Potassium",
                                                                           "Nitrate",
                                                                           "Ammonium",
                                                                           "Calcium",
                                                                           "Sulphur",
                                                                           "Sulphur",
                                                                           "Magnesium",
                                                                           "Iron",
                                                                           "Zinc",
                                                                           "Copper",
                                                                           "Boron",
                                                                           "Molybdenum",
                                                                           "Manganese",
                                                                           "Chlorine")
                                                          )
                                                        )
                                                 )

                                               )


                              )#end conPanel 5

                              #)#end box
)
)
#)

),
tabPanel("Nutrient amount applied", value="tab222",
         #fluidRow(
         column(width = 12,
                #br(),
                h2("Nutrient amount applied"),
                fluidRow(
                  # box(title = "Nutrient amount applied",
                  #     status = "primary",
                  #     solidHeader = TRUE,
                  #     width = 12, collapsible = TRUE,
                  #fluidRow(
                  column(width = 6,
                         # box(
                         #   title = "Nutrient amount applied", solidHeader = TRUE, status = "info", width=12,
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_NitroTotalAmount", label = "Nitrogen total amount")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_NitroTotalAmount_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         textInput("nutrient_NitroNumApps", label="Nitrogen number of applications", value=""),

                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_PhosTotalAmount", label = "Phosphorus total amount")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_PhosTotalAmount_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         textInput("nutrient_PhosNumApps", label="Phosphorus number of applications", value=""),

                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_PotTotalAmount", label = "Potassium total amount")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_PotTotalAmount_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         textInput("nutrient_PotNumApps", label="Potassium number of applications", value=""),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_AmountMicroApplied", label = "Amount of micronutrient applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_AmountMicroApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_NitAmount", label = "Nitrate amount")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_NitAmount_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_AmoAmount", label = "Ammonium amount")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_AmoAmount_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_CalcAmount", label = "Calcium amount")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_CalcAmount_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_SulphAmountApplied", label = "Sulphur amount applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_SulphAmountApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_MagnAmountApplied", label = "Magnesium amount applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_MagnAmountApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_IronAmountApplied", label = "Iron amount applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_IronAmountApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_ZincAmountApplied", label = "Zinc amount applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_ZincAmountApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,######
                                  textInput("nutrient_CopperAmountApplied", label = "Copper amount applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_CopperAmountApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_BoronAmountApplied", label = "Boron amount applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_BoronAmountApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_MolybAmountApplied", label = "Molybdenum amount applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_MolybAmountApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_ManganAmountApplied", label = "Manganese amount applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_ManganAmountApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         ),
                         fluidRow(
                           column(width = 6,
                                  textInput("nutrient_ChlorAmountApplied", label = "Chlorine amount applied")
                           ),
                           column(width = 6,
                                  selectizeInput("nutrient_ChlorAmountApplied_unit", multiple = TRUE, options = list(maxItems = 1, placeholder = "Select one..."), label ="Unit", choices =c(
                                    "kg/m2",
                                    "kg/ha",
                                    "t/ha")
                                  )
                           )
                         )



                         #)

                  )
                  #)
                  #)#end box
                )
         )
         #)
)
)
