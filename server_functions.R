# R script for putting your server functions in 

# function to get data

generate_data <- function(inputTicker, dateFrom, dateTo) {
  
  # Params
  # ------------
  # inputTicker: ticker of stock
  # dateFrom: start date
  # dateTp: end date
  
  # Returns
  # ------------
  # data for ticker

  data <- tq_get(inputTicker, get = "stock.prices", from = dateFrom, to = dateTo)
  
  
}

# function to generate data

generate_bargraph <- function(stock_data, inputTicker) {
  
  # Params
  # ------------
  # stock_data: stock data from generate_data function
  # inputTicker: name of ticker
  
  # Returns
  # ------------
  # bar graph
  
  stock_data %>%
    ggplot(aes(x = date, y = close)) +
    geom_barchart(aes(open = open, high = high, low = low, close = close)) +
    labs(title = paste0(inputTicker, " Bar Chart"), y = "Closing Price", x = "") + 
    theme_classic()
  
}


generate_volume <- function(stock_data, inputTicker) {
  
  # Params
  # ----------
  # stock_data: stock data from generate_data function
  # inputTicker: name of ticker
  
  # Returns
  # ---------
  # Volume chart
  
  stock_data %>%
    ggplot(aes(x = date, y = volume)) +
    geom_segment(aes(xend = date, yend = 0, color = volume)) + 
    geom_smooth(method = "loess", se = FALSE) +
    labs(title = paste0(inputTicker, " Volume Chart"), 
         subtitle = "Charting Daily Volume", 
         y = "Volume", x = "") +
    theme_classic() +
    theme(legend.position = "none")
}

generate_sp500_returns <- function(dateFrom, dateTo, initial) {
  
  
  sp500_data <- tq_get("^GSPC", from = dateFrom, to = dateTo)
  
  initial_investment <- initial
  
  sp500_returns <- sp500_data %>%
    tq_transmute(select = adjusted,          # Use adjusted close prices
                 mutate_fun = periodReturn,  # Calculate daily returns
                 period = "daily", type = "log") %>%
    mutate(cumulative_return = cumsum(daily.returns),  # Cumulative log returns
           investment_value = initial_investment * exp(cumulative_return))  # Convert to investment value
  
  return(sp500_returns)
}

plot_sp500_returns <- function(sp500_data, initial) {
  ggplot(sp500_data, aes(x = date, y = investment_value)) +
         geom_line(color = "darkorange", linewidth = 1) +
         labs(title = paste0("Cumulative Returns of £",initial, " in S&P 500"),
                         x = "Date", 
                         y = "Investment Value (£)") +
         theme_minimal()
}


generate_custom_portfolio <- function(stocks, weights, dateFrom, dateTo, initial) {
  
  stocks_symbols <- unlist(strsplit(stocks, ",\\s*"))
  weights <- as.numeric(unlist(strsplit(weights, ",\\s*")))
  
  initial_investment <- as.numeric(initial)
  
  stock_data <- tq_get(stock_symbols, from = dateFrom, to = dateTo)
  
  portfolio_returns <- stock_data %>%
    group_by(symbol) %>%
    tq_transmute(select = adjusted,          # Use adjusted close prices
                 mutate_fun = periodReturn,  # Calculate daily returns
                 period = "daily", type = "log") %>%
    group_by(symbol) %>%
    mutate(cumulative_return = cumsum(daily.returns),  # Cumulative log returns
           weighted_investment_value = initial_investment * weights[match(symbol, stock_symbols)] * exp(cumulative_return))  # Apply weight
  
  portfolio_growth <- portfolio_returns %>%
    group_by(date) %>%
    summarise(total_portfolio_value = sum(weighted_investment_value, na.rm = TRUE))
  
  return(portfolio_growth)
  
}

plot_custom_portfolio <- function(custom_stock_data, initial) {
  
  ggplot(custom_stock_data, aes(x = date, y = total_portfolio_value)) +
    geom_line(color = "darkblue", size = 1) +
    labs(title = paste0("Cumulative Returns of a £", initial," Weighted Portfolio"),
         x = "Date", 
         y = "Portfolio Value (£)") +
    theme_minimal()
  
}


plot_custom_vs_sp500 <- function(sp500_data, custom_data) {
  
  ggplot() +
    geom_line(data = sp500_data, aes(x = date, y = investment_value, color = "darkorange"), size = 1, linetype = "solid") +
    geom_line(data = custom_data, aes(x = date, y = total_portfolio_value, color = "Custom Portfolio"), size = 1, linetype = "solid") +
    labs(title = "Comparison of S&P 500 and Custom Portfolio",
         x = "Date",
         y = "Investment Value (£)",
         color = "Portfolio") +
    theme_minimal() +
    theme(legend.position = "top")
  
}

