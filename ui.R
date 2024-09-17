# ui

source("global.R", local = TRUE)

ui <- dashboardPage(
  dashboardHeader(title = "Stocks and portfolio" # input bioapp name here
                    #tags$img(src="vdj_annotate.png", width = 100, height = 100,
                     #              style = "padding-top:5px; padding-bottom:5px;"),
                  # tags$li(class = "dropdown",
                  #         tags$img(height='50px', alt='IClogo', src='immunocore_logo.png',
                  #                  style='text-align; center"'))
                  #        tags$style(".main-header {max-height: 100px}"),
                  #        tags$style(".main-header .logo {height: 100px;}"),
                  #        tags$style(".sidebar-toggle {height: 100px; padding-top: 1px !important;}"),
                  #       tags$style(".navbar {min-height:100px !important}"))
                   ),
  dashboardSidebar(
    #tags$style(".left-side, .main-sidebar {padding-top: 120px}"),
    sidebarMenu(id = "tabset", # the order of the menuItems is the order at which they appear in the tab
                # what you input in the first brackets is the name that is going to be displayed on the sidebar
                # the second bracket is where you put the name of your variable
                # and the third bracket is where you put the name of the icon you would like displayed
      menuItem("Stock analysis", tabName = "stock", icon = icon("arrow-trend-up")),
      menuItem("Custom portfolio vs S&P500", tabName = "custom_portfolio", icon = icon("layer-group")),
      div(img(src="stonks.jpg", width = 150, height = 150,  # this line is to change the logo of the shiny app
          style='position: absolute; bottom: 5px; left:50px;'))#,
      #  menuItem("Example", tabName = "example", icon = icon("icon")), # copy and paste this code if you need to add
      # more tabs to the side bar
    )
  ),
  dashboardBody(use_theme("dashboard_theme.css"), # here is where the immunocore .css theme is applied to your bioapp, there is also a create_rshiny_dashboard_theme_1.R script that allows you to generate your own imcr_dashbaord_theme.css
               #add the name of the different times you have here
                 tabItems(
                  stock_analysis(),
                  custom_portfolio_tab()
                ))
)  # END: ui 

