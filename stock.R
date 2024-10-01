# Install necessary libraries (if not already installed)
# Uncomment the lines below to install packages
# install.packages("ggplot2")
# install.packages("plotly")
# install.packages("quantmod")

# Load required libraries
library(ggplot2)
library(plotly)
library(quantmod)

# Simulate stock market data
set.seed(123)
n <- 365  # Number of days (1 year of daily data)

stock_data <- data.frame(
  Date = seq(as.Date("2023-01-01"), by = "day", length.out = n),
  Open = cumsum(runif(n, min = -1, max = 1)) + 100,
  High = cumsum(runif(n, min = -0.5, max = 1.5)) + 101,
  Low = cumsum(runif(n, min = -1.5, max = 0.5)) + 99,
  Close = cumsum(runif(n, min = -1, max = 1)) + 100,
  Volume = runif(n, min = 10000, max = 50000)
)

# Adjust 'High' to always be greater than or equal to 'Open' and 'Low' to be less than or equal to 'Open'
stock_data$High <- pmax(stock_data$Open, stock_data$High)
stock_data$Low <- pmin(stock_data$Open, stock_data$Low)

# Preview the first few rows of the dataset
head(stock_data)

# Plot 1: Line chart of stock prices over time (Closing price)
ggplot(stock_data, aes(x = Date, y = Close)) +
  geom_line(color = "blue") +
  labs(title = "Closing Price Over Time", x = "Date", y = "Closing Price") +
  theme_minimal()

# Plot 2: Candlestick chart (Open, High, Low, Close prices)
stock_xts <- xts(stock_data[, c("Open", "High", "Low", "Close")], order.by = stock_data$Date)
candleChart(stock_xts, up.col = "green", dn.col = "red", theme = "white", name = "Candlestick Chart")

# Plot 3: Histogram of stock closing prices
ggplot(stock_data, aes(x = Close)) +
  geom_histogram(fill = "blue", bins = 30) +
  labs(title = "Distribution of Closing Prices", x = "Closing Price", y = "Frequency") +
  theme_minimal()

# Plot 4: Line chart for volume over time
ggplot(stock_data, aes(x = Date, y = Volume)) +
  geom_line(color = "purple") +
  labs(title = "Volume of Trades Over Time", x = "Date", y = "Volume") +
  theme_minimal()

# Plot 5: Interactive line plot (using plotly) for closing price
plot_ly(stock_data, x = ~Date, y = ~Close, type = 'scatter', mode = 'lines', 
        name = 'Close', line = list(color = 'blue')) %>%
  layout(title = "Interactive Line Plot of Closing Prices",
         xaxis = list(title = "Date"),
         yaxis = list(title = "Closing Price"))

# Plot 6: Scatter plot comparing Open and Close prices
ggplot(stock_data, aes(x = Open, y = Close)) +
  geom_point(color = "darkred", alpha = 0.6) +
  labs(title = "Scatter Plot of Open vs Close Prices", x = "Open Price", y = "Close Price") +
  theme_minimal()

# Show the plots

