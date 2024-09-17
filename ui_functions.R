### this page contains the ui functions so the ui.R script just has to call the functions (pretty neat)

#### Input tab ####
stock_analysis <- function(){
  tabItem("stock",
          fluidRow(
            titlePanel(h2("Stock analysis", align = "center")), # Title of the page
            box(title = "Parameters", status = "success", width = 3, solidHeader = TRUE,
                textInput("ticker", "Ticker"),
                sliderInput("dateRange", "Select Date Range:",
                            min = as.Date("2000-01-01"),
                            max = Sys.Date(),
                            value = c(as.Date("2000-01-01"), Sys.Date()),
                            timeFormat = "%Y-%m-%d",
                            step = 1,
                            animate = animationOptions(interval = 1000, loop = FALSE)),
                actionButton("graph", "Generate graphs", class = "btn-success")
                )# end of box
            , mainPanel(plotOutput("stock_graph"),
                        plotOutput("stock_volume"))
        ) #END: Fluid row
  ) #END: Tablitem
} # END:input_tab


##### custom portfolio vs s&p 500 #####
custom_portfolio_tab <- function() {
  tabItem("custom_portfolio",
          fluidRow(
            titlePanel(h2("Custom portfolio vs S&P 500", align = "center")), # end of title page
            box(title = "Enter your stocks", status = "success", width = 3, solidHeader = TRUE,
                textInput("stocks", "Input your stocks (comma separated)"),
                textInput("weighting", "Input the percentage of each stock (e.g., 0.2, 0.5, 0.3)"),
                textInput("initial", "Input your initial investment in £"),
                sliderInput("date", "Select Date Range:",
                            min = as.Date("2000-01-01"),
                            max = Sys.Date(),
                            value = c(as.Date("2000-01-01"), Sys.Date()),
                            timeFormat = "%Y-%m-%d",
                            step = 1,
                            animate = animationOptions(interval = 1000, loop = FALSE)),
                actionButton("plot_portfolio", "Generate portfolio", class = "btn-success")
                ) # end of box
            , mainPanel(plotOutput("custom_vs_sp500"),
                        plotOutput("custom_return"),
                        plotOutput("custom_portfolio")
                        )
          ) # end of fluid row
          ) # end of tab item
}

##### Results page ####
# risk_tab <- function() {
#   tabItem("risks",
#            fluidRow(
#              titlePanel(h2("Output results", align = "center")),
#              box(status = "success", width = 12, 
#                 p("Here, you will find the following results:"),
#                 div(p("1. Result tables", style = "font-weight: bold; display: inline;"),
#                  p("Here is some table that will produce some results or something.", style = "display: inline;")),
#                 br(),
#                 div( p("2. Another table:", style = "font-weight: bold; display: inline;"),
#                     p("Your bioapp may produce more than one result table. ", style = "display: inline;"),
#                     a("HYPERLINK", href="", style = "display: inline;"),
#                     p(". This hyperlink does nothing as there is no url to a webpage in the href parameter, 
#                     however clicking this hyperlink takes you back to the Input tab for some reason....Interesting.",
#                       style = "display: inline;"),
#                     p("When explaining your other results table you may wish to describe what the results
#                       table is showing. You can also colour code your words to highlight
#                       some of the outputs:", style = "display: inline;"), p("suboutput 1", style = "color: blue; display: inline;"),
#                     p("suboutput 2", style = "color: #FF00FF; display: inline;"),
#                     p("suboutput 3", style = "color: #00CCCC; display: inline;")),
#                 # copy and paste code below if you wish to change the colour of certain text 
#                 # p("suboutput 3", style = "color: #00CCCC; display: inline;")),
#                 br(),
#               # copy and paste text blow to put another line of text in describing another output table if you need  
#               #  div(p("3. Output table:", style = "font-weight: bold; display: inline;"),
#               #      p("Description of output table number 3 ", style = "display: inline;"), 
#               #      a("HYPERLINK", href="https://www.immunocore.com/", style = "display: inline;"), # this is a hyperlink line, remove it if it is not needed
#               #      p("Continuation of description of table after the hyperlink.", style = "display: inline;")),
#               #  br(),
#                 downloadButton("report", "Download html report", class="btn-secondary"),
#                 downloadButton("excel_report", "Download excel report", class="btn-secondary"),
#                 # copy and paste the code below if you wish to add addition buttons
#                 # downloadButton("example_report", "Download example report", class="btn-secondary"),
#                 br(),
#              ), #END: box
#            ),  # END: fluidRow
#           fluidRow(
#              h2(strong("Some output")),
#              downloadButton("some_output_report", "Download",  class="btn-secondary"),
#              column(12,
#                       shinycssloaders::withSpinner(DT::dataTableOutput("flagged_table"), type = 1),
#                       style = "height:500px; overflow-y: scroll"
#             ), # END:column
#           ), # END: fluidRow
#           conditionalPanel(
#             condition = "input.dataType == 'One' || input.dataType == 'Three'", # set the conditions for the output table 
#             fluidRow(
#               br(),
#               h2(strong("Conditional output")), # title of the table
#               downloadButton("alpha_report", "Download", class="btn-secondary"), # download button
#               column(12, shinycssloaders::withSpinner(DT::dataTableOutput("output_table_1"), # render datatable
#                                                     type = 1),
#                    style = "overflow-y: scroll")#END:column
#             ),# END:fluidRow
#            fluidRow(
#               br(),
#               h2(strong("This output will only appear if the conditions above are met")), # Title of the table
#               downloadButton("alpha_report2", "Download", class="btn-secondary"), # download button
#               column(12, shinycssloaders::withSpinner(DT::dataTableOutput("output_table_2"), # render datatable
#                                                     type = 1),
#                 style = "overflow-y: scroll") #END:column
#             ),# END:fluidRow
#           ), # END: conditionalPanel
#       # copy and paste the code below if you wish to have certain panels to appear based on certain parameter options clicked
#       #    conditionalPanel(
#       #      condition = "input.dataType == 'Parameter option 1' || input.dataType == 'Parameter option 2'",
#       #      fluidRow(
#       #        br(),
#       #        h2(strong("Name of conditional panel")),
#       #        downloadButton("parameter_option_1__report", "Download", class="btn-secondary"),   # this line creates a download button for this panel
#       #        column(12,shinycssloaders::withSpinner(DT::dataTableOutput("name_of_table"), type = 1),  # this line loads the datatable
#       #             style = "overflow-y: scroll") #END:column 
#       #      ), # END: fluidRow
#       #       # this code below produces another table based on the conditions selected above
#       #      fluidRow(
#       #        br(),
#       #        h2(strong("Conditional panel 2")),
#       #       downloadButton("parameter__option_2_report2", "Download", class="btn-secondary"),
#       #        column(12, shinycssloaders::withSpinner(DT::dataTableOutput("name_of_table_2"), type = 1
#       #             ), style = "overflow-y: scroll"),
#       #       br(),
#       #       br()
#       #      ) # END: fluidRow
#       #    ) #END: conditionalPanel
#   ) # END:tabPanel
# } # END:risk_tab
# 
# 
# 
# #### about page ####
# about_tab <- function() {
#   tabItem("about",
#           fluidRow(
#             
#             titlePanel(h2("About", align = "center")), # Title of the page goes here
#             
#             column(width = 6,
#                    box(title = "Overview", status = "success", # title of the box goes here
#                        width = 12, solidHeader = TRUE,
#                        div(p("This is the overview tab. Here you can right a brief description of what your app does,
#                              as well as what it entails.",
#                              style = "display: inline;"),
#                            p("Your app can do the following:", style = "display: inline;")),
#                        br(), # the br() function creates a line of empty space between text
#                        div(p("- Function number 1 ", style = "display: inline; "),
#                            a("Hyperlink", href="https://www.youtube.com/watch?v=uHgt8giw1LY" # put hyperlink here
#                              , style = "display: inline;"),
#                            p(" is definitely the most useful, I would totally click
#                              the hyperlink... -_-.", style = "display: inline;")),
#                        br(),
#                        div(p("- This is another line to explain what your app does, you 
#                              can have as many lines as your heart desires <3. (I've commented
#                              out the rest of the lines though as it's a bit overkill", style = "display: inline;")),
#                        br(),
#                        # div(p("- example of a bullet point with a word as a hyperlink ", style = "display: inline;"),
#                        #     a("HYPERLINK 2", href="put http address of the page you want hyperlinked", style = "display: inline;"),
#                        #     p(" the rest of the test after the hyperlinked word goes here", style = "display: inline;")),
#                        # br(),
#                        p(strong("This line is highlighted in BOLD to attract your attention!
#                                 Usually the line. 'For any queries please contact data.science@immunocore.com' goes here.")) 
#                        # this line makes any text bold
#                        # is good for highlighting important info
#                    ), # END: box
#                    box(title = "Parameters", status = "success", # title of the box goes here
#                        width = 12, solidHeader = TRUE,
#                        div(p("Parameter 1: ", style = "display: inline; font-weight: bold;"),
#                            p("Description of parameter 1.", style = "display: inline;")
#                        ),
#                        br(),
#                        div(p("Parameter 2: ", style = "display: inline; font-weight: bold;"),
#                            p("Description of parameter 2.", style = "display: inline;")
#                        ),
#                        br(),
#                        div(p("Parameter 3: ", style = "display: inline; font-weight: bold;"),
#                            p("You get the idea here.", style = "display: inline;")
#                            # for more parameters either copy and paste the exmaples above and edit them or copy and paste the example
#                            # below and edit it
#                            # br(),
#                            # div(p("Parameter x: ", style = "display: inline; font-weight: bold;"),
#                            #     p("Parameter x description.", style = "display: inline;")
#                        )
#                    ), # END: box
#             ), # END: column
#             column(width = 6, 
#                    box(title = "Input data", status = "success", # title of the box goes here
#                        width = 12, solidHeader = TRUE,
#                        p('Description of the input data and the format it needs to be in for the app to work'),
#                        br(),
#                        tags$div(
#                          tags$img(src = "thumbs_up.jpg", # name of image from www folder (all images must be in this folder if you want thme to render)
#                                   width = '80%', style = "padding-right:20px; padding-left:20px; 
#                      display: block; margin-left: auto; margin-right: auto;"), 
#                          tags$legend("Figure: Meme (but usually is a description of what the input data should look like)", # put description of the figure here
#                                      style = "font-size: 10pt; color: grey; border:none ;
#               display: inline-block; float:left;")
#                          #tags$img(src = "srf_example_output.png", height = "200px", width = "300px"),
#                          #tags$legend("Figure 1: Example of the fasta format of input files and output from sequence risk. Highlighted in yellow is the specific format
#                          #              of the names of the TCRs", style = "font-size: 12pt; padding-right: 0px; color: grey; padding-left; 0px; border:
#                          #              none; display: inline-block; float:left;"),
#                          #tags$img(src = "SRF_clone_screenshot.png",
#                          #            height = "500px", width = "900px", style ="display: block; margin-left: auto; margin-right: auto;"),
#                          #tags$legend("Figure 2: When TCR clone is selected, only the parent sequence will be annotated with flagged residues.
#                          #                  Any daughter sequences that have a risk residue not contained in the parent, will be annotated.",
#                          #               style = "font-size: 12pt; padding-right: 0px; color: grey; padding-left; 0px; border:
#                          #                   none; display: inline-block; float:left;")
#                        ) # END:tags$div
#                    ), # END: box
#                    box(title = "Future Plans", status = "success",
#                        width = 12, solidHeader = TRUE,
#                        p("- Here you can write the future plans you have for your app"),
#                        p("- E.g., Overhaul the visuals of the app"),
#                        p("- You can add as many bullet points as you like in this section"),
#                        p("- Bullet points are easy to add/remove, the rest of them have been commented out")
#                        # When adding more bullet points make sure to add a comma to the line of code above so that it doesn't error
#                        #p("- Speed up Mixcr on many sequences"),
#                        #    p("- Increased ability to run 'weird' sequences - contact us if you have sequences which don't work")
#                    ) # END:box
#             ), # END: column
#           ) # END: fluidrow
#   ) #END: Tabitem
# } # END:about_tab
# 
