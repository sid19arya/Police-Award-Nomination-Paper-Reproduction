#### Preamble ####
# Purpose: Simulates summary statistics
# Author: Thu Dong, Siddarth Arya, Hyuk Jang
# Date: today
# License: MIT



#### Workspace setup ####
library(tidyverse)
library(tibble)

# Create a tibble with the provided summary statistics

simulated_data <- tibble(
  id = 1:100,                       # Example: 100 rows
  year = sample(2010:2020, 100, replace = TRUE),  # Example: random years between 2010 and 2020
  birth_year = rnorm(100, mean = 1980, sd = 5),    # Example: random birth years
  black = sample(c(0, 1), 100, replace = TRUE),    # Example: random binary values
  white = sample(c(0, 1), 100, replace = TRUE),    # Example: random binary values
  female = sample(c(0, 1), 100, replace = TRUE),   # Example: random binary values
  awards_nomination = rpois(100, lambda = 5),      # Example: Poisson-distributed awards nominations
  total_arrests = rpois(100, lambda = 20)          # Example: Poisson-distributed total arrests
)

# Print the simulated tibble
print(simulated_data)

#summary statistics 
summary_stats <- tibble(
  Category = c("birth year", "start month", "complaints", "arrests", "award performance", "trr new", "observation"),
  Everyone = c(1981.51, 7.36, 0.45, 23.45, 7.05, 0.66, 1715),
  White = c(1982.4, 7.36, 0.44, 24.8, 7.47, 0.72, 840),
  Black = c(1979.54, 7.29, 0.54, 21.16, 5.89, 0.56, 282),
  Male = c(1981.74, 7.37, 0.47, 24.3, 7.27, 0.74, 1369),
  Female = c(1980.6, 7.34, 0.37, 20.07, 6.21, 0.32, 346)
)

# Print the tibble
print(summary_stats)



