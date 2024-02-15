#### Preamble ####
# Purpose: Tests summary statistics
# Author: Thu Dong, Siddarth Arya, Hyuk Jang
# Date: today
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Test data ####
# Checks if female variable is in class "numeric"
simulated_data$female |> class() == "numeric"
# Checks if largest year is at most 2020
simulated_data$year |> max(year) <=2020
# Checks if award performance is bigger or equal to "0"
simulated_data$awards_nomination|> min(award_nomination) >= 0
# Checks if total arrests is bigger or equal to "10"
simulated_data$total_arrests |> min(total_arrests) >= 10
# Checks if birth year has the class "integer"
simulated_data$birth_year |> class() == "integer"