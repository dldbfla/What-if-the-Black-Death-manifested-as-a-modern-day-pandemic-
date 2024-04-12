# Check if necessary packages are installed, if not, install them
if(!require(deSolve)) install.packages("deSolve", repos = "http://cran.rstudio.com/")
if(!require(ggplot2)) install.packages("ggplot2", repos = "http://cran.rstudio.com/")
if(!require(reshape2)) install.packages("reshape2", repos = "http://cran.rstudio.com/")
library(deSolve)
library(ggplot2)
library(reshape2)

# Change locale setting to support UTF-8 (for Unix-like systems)
Sys.setlocale("LC_ALL", "en_US.UTF-8")

# Set policy implementation time
policy_start_time <- 20

# Function to adjust beta value over time
beta_function <- function(time) {
 if (time < policy_start_time) {
 return(10) # High infection rate before policy implementation
 } else {
 return(2) # Low infection rate after policy implementation
 }
}

# Modified SIRD model definition function
sird_model_with_policy <- function(time, variables, parameters) {
 with(as.list(c(variables, parameters)), {
 # Calculate beta value over time
 beta <- beta_function(time)
 
 dS <- -beta * I * S / N
 dI <- beta * I * S / N - gamma * I - mu * I
 dR <- gamma * I
 dD <- mu * I
 
 # Return results
 return(list(c(dS, dI, dR, dD)))
 })
}

# Initial population settings: S (Susceptible), I (Infected), R (Recovered), D (Deceased)
initial_values <- c(S = 999, I = 1, R = 0, D = 0)

# Model parameters: gamma (recovery rate), mu (mortality rate), N (total population)
# beta is changed over time, so it is not set here.
parameters <- c(gamma = 0.5, mu = 0.05, N = 1000)

# Time settings
times <- seq(0, 50, by = 1)

# Run the model
result_with_policy <- ode(y = initial_values, times = times, func = sird_model_with_policy, parms = parameters)

# Convert results to data.frame and visualize
result_df_with_policy <- as.data.frame(result_with_policy)
result_df_with_policy$time <- result_df_with_policy[, 1]
result_df_with_policy_long <- melt(result_df_with_policy, id.vars = "time")

ggplot(data = result_df_with_policy_long, aes(x = time, y = value, colour = variable)) +
 geom_line() +
 scale_colour_manual(values = c("S" = "blue", "I" = "red", "R" = "green", "D" = "black")) +
 labs(x = "Time", y = "Population", colour = "Status", title = "SIRD Model Simulation Including Policy Effect") +
 theme_minimal()
