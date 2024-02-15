#### Preamble ####
# Purpose: Tests summary statistics
# Author: Thu Dong, Siddarth Arya, Hyuk Jang
# Date: today
# License: MIT
# Prereq: Run 00-Simulated_data.R


#### Workspace setup ####
library(tidyverse)


#### Test data ####
# Checks if female variable is in class "numeric"
simulated_data$female |> class() == "numeric"
# Checks if largest year is at most 2020
simulated_data$year |> max() <=2020
# Checks if award performance is bigger or equal to "0"
simulated_data$awards_nomination|> min() >= 0
# Checks if total arrests is bigger or equal to "10"
simulated_data$total_arrests |> min() >= 10
# Checks if birth year has the class "integer"
simulated_data$birth_year |> class() == "numeric"