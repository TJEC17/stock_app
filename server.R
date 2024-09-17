# server

source("global.R", local = TRUE)
plan('multicore', workers = 6) # this line allows parallelisation of tasks

server <- function(input, output, session) {
  
  
  # observeEvent(input$graph, {
  #   print(input$ticker)
  #   print(input$dateRange)
  # 
  # })
  
  plot_data <- eventReactive(input$graph, {
    
    generate_data(input$ticker, input$dateRange[1], input$dateRange[2])
    
  })
  
  
  output$stock_graph <- renderPlot({
    req(plot_data())
    generate_bargraph(plot_data(), input$ticker)
  })
  
  output$stock_volume <- renderPlot({
    req(plot_data())
    generate_volume(plot_data(), input$Ticker)
  })
  
  
  observeEvent(input$plot_portfolio, {
    print(unlist(strsplit(input$stocks, ",\\s*")))
    print(as.numeric(unlist(strsplit(input$weighting, ",\\s*"))))
    print(as.numeric(input$initial))
  })
  
  
  sp500_dat <- eventReactive(input$plot_portfolio, {
    
    generate_sp500_returns(input$date[1], input$date[2], as.numeric(input$initial))
    
  })
  
  output$custom_portfolio <- renderPlot({
    req(sp500_dat())
    print(sp500_dat())
    plot_sp500_returns(sp500_dat(), input$initial)
  })
  
  custom_dat <- eventReactive(input$plot_portfolio, {
    
    generate_custom_portfolio(input$stocks, input$weighting, input$date[1], input$date[2], input$initial)
    
  })
  
  output$custom_return <- renderPlot({
    req(custom_dat())
    print(custom_dat())
    plot_custom_portfolio(custom_dat(), input$initial)
  })
  
  output$custom_vs_sp500 <- renderPlot({
    req(custom_dat())
    req(sp500_dat())
    plot_custom_vs_sp500(sp500_dat(), custom_dat())
  })

  
} # END: server 

