#### Preamble ####
# Purpose: Tests summary statistics
# Author: Thu Dong, Siddarth Arya, Hyuk Jang
# Date: today
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Test data ####
# Checks if male average start month has the class "numeric"
mavg_start_month |> class() == "numeric"
# Checks if birth year in clean female data has the class "numeric"
clean_female_data$birth_year....afemale_birth_year |> class() == "numeric"
# Checks if award performance in clean white data is bigger or equal to "0"
clean_white_data$award_performance....awhite_awd_perf >= 0
# Checks if civilian complaints of clean black data is bigger or equal to "0"
clean_black_data$complaints....ablack_complaints >= 0
# Checks if observations of clean male data has the class "integer"
clean_male_data$observations....male_observation |> class() == "integer"