library(tidyverse)
library(tidyr)
library(janitor)
library(dplyr)
library(readr)
library(stringr)

officer_year_data <- read_csv("~/Police-Award-Nomination-Paper-Reproduction/data/analysis_data/analysis_officer_year_data.csv")
officer_month_data <- read.csv("~/Police-Award-Nomination-Paper-Reproduction/data/analysis_data/analysis_officer_month_data.csv")

unit44_data <- officer_month_data[officer_month_data$unit == 44, ]
unique_nuid <- unit44_data |>
  distinct(nuid, .keep_all = TRUE)
total_observations <- nrow(unique_nuid) 
total_birth_year <- sum(unique_nuid$birth_year, na.rm = TRUE)
avg_birth_year <- round(total_birth_year / total_observations, digits = 2)
total_complaints <- sum(unit44_data$cmpl_civ, na.rm = TRUE)
avg_complaints <- round(total_complaints / total_observations, digits = 2)
total_arrests <- sum(unit44_data$arrest_total, na.rm = TRUE)
avg_arrests <- round(total_arrests / total_observations, digits = 2)
total_trr_new <- sum(unit44_data$trr_new, na.rm = TRUE)
avg_trr_new <- round(total_trr_new / total_observations, digits = 2)
total_awd_perf <- sum(unit44_data$awd_perf, na.rm = TRUE)
avg_awd_perf <- round(total_awd_perf / total_observations, digits = 2)

unique_nuid$start_month <- as.character(unique_nuid$start_month)
start_date <- unique_nuid$start_month
processed_start_date <- str_match(start_date, "^(\\d{2})([a-zA-Z]{3})(\\d{4})$")
processed_start_date <- data.frame(processed_start_date)
processed_start_date$X4 <- as.integer(processed_start_date$X4)
total_start_year <- sum(processed_start_date$X4)
avg_start_year <- round(total_start_year / total_observations)
month_mapping <- c(jan = 1, feb = 2, mar = 3, apr = 4, may = 5, jun = 6,
                   jul = 7, aug = 8, sep = 9, oct = 10, nov = 11, dec = 12)
processed_start_month <- month_mapping[processed_start_date$X3]
processed_start_month <- as.integer(processed_start_month)
total_start_month <- sum(processed_start_month)
avg_start_month <- round(total_start_month / total_observations, digits = 2)


Everyone <- data.frame(
  Birth_year <- avg_birth_year,
  start_month <- paste(avg_start_month, avg_start_year, sep = " "),
  Complaints <- avg_complaints,
  Arrests <- avg_arrests,
  Award_performance <- avg_awd_perf,
  Trr_new <- avg_trr_new,
  Observations <- total_observations
)

female_observation <- nrow(unique_nuid[unique_nuid$female == 1, ])
female_data <- unit44_data[unit44_data$female == 1, ] 
tfemale_birth_year <- sum(unique_nuid[unique_nuid$female == 1, ]$birth_year, na.rm = TRUE)
tfemale_complaints <- sum(female_data$cmpl_civ, na.rm = TRUE)
tfemale_arrests <- sum(female_data$arrest, na.rm = TRUE)
tfemale_trr_new <- sum(female_data$trr_new, na.rm = TRUE)
tfemale_awd_perf <- sum(female_data$awd_perf, na.rm = TRUE)
afemale_birth_year <- round(tfemale_birth_year / female_observation, digit = 2)
afemale_complaints <- round(tfemale_complaints / female_observation, digit = 2)
afemale_arrests <- round(tfemale_arrests / female_observation, digit = 2)
afemale_trr_new <- round(tfemale_trr_new / female_observation, digit = 2)
afemale_awd_perf <- round(tfemale_awd_perf / female_observation, digit = 2)

female_date <- as.character(unique_nuid[unique_nuid$female == 1, ]$start_month)
fstart_date <- data.frame(female_date, start_month)
fprocessed_start_date <- str_match(fstart_date$female_date, "^(\\d{2})([a-zA-Z]{3})(\\d{4})$")
fprocessed_start_date <- data.frame(fprocessed_start_date)
fprocessed_start_date$X2 <- as.integer(fprocessed_start_date$X2)
fprocessed_start_date$X4 <- as.integer(fprocessed_start_date$X4)
ftotal_start_year <- sum(fprocessed_start_date$X4)
favg_start_year <- round(ftotal_start_year / female_observation)
month_mapping <- c(jan = 1, feb = 2, mar = 3, apr = 4, may = 5, jun = 6,
                   jul = 7, aug = 8, sep = 9, oct = 10, nov = 11, dec = 12)
fprocessed_start_month <- month_mapping[fprocessed_start_date$X3]
fprocessed_start_month <- as.integer(fprocessed_start_month)
ftotal_start_month <- sum(fprocessed_start_month)
favg_start_month <- round(ftotal_start_month / female_observation, digit = 2)

clean_female_data <- data.frame(
  birth_year <- afemale_birth_year,
  start_month <- paste(favg_start_month, favg_start_year, sep = " "),
  complaints <- afemale_complaints,
  arrests <- afemale_arrests,
  award_performance <- afemale_awd_perf,
  trr_new <- afemale_trr_new,
  observations <- female_observation
)

male_observation <- nrow(unique_nuid[unique_nuid$female != 1, ])
male_data <- unit44_data[unit44_data$female != 1, ] 
tmale_birth_year <- sum(unique_nuid[unique_nuid$female != 1, ]$birth_year, na.rm = TRUE)
tmale_complaints <- sum(male_data$cmpl_civ, na.rm = TRUE)
tmale_arrests <- sum(male_data$arrest, na.rm = TRUE)
tmale_trr_new <- sum(male_data$trr_new, na.rm = TRUE)
tmale_awd_perf <- sum(male_data$awd_perf, na.rm = TRUE)
amale_birth_year <- round(tmale_birth_year / male_observation, digit = 2)
amale_complaints <- round(tmale_complaints / male_observation, digit = 2)
amale_arrests <- round(tmale_arrests / male_observation, digit = 2)
amale_trr_new <- round(tmale_trr_new / male_observation, digit = 2)
amale_awd_perf <- round(tmale_awd_perf / male_observation, digit = 2)

male_date <- as.character(unique_nuid[unique_nuid$female != 1, ]$start_month)
mstart_date <- data.frame(male_date, start_month)
mprocessed_start_date <- str_match(mstart_date$male_date, "^(\\d{2})([a-zA-Z]{3})(\\d{4})$")
mprocessed_start_date <- data.frame(mprocessed_start_date)
mprocessed_start_date$X2 <- as.integer(mprocessed_start_date$X2)
mprocessed_start_date$X4 <- as.integer(mprocessed_start_date$X4)
mtotal_start_year <- sum(mprocessed_start_date$X4)
mavg_start_year <- round(mtotal_start_year / male_observation)
month_mapping <- c(jan = 1, feb = 2, mar = 3, apr = 4, may = 5, jun = 6,
                   jul = 7, aug = 8, sep = 9, oct = 10, nov = 11, dec = 12)
mprocessed_start_month <- month_mapping[mprocessed_start_date$X3]
mprocessed_start_month <- as.integer(mprocessed_start_month)
mtotal_start_month <- sum(mprocessed_start_month)
mavg_start_month <- round(mtotal_start_month / male_observation, digit = 2)
clean_male_data <- data.frame(
  birth_year <- amale_birth_year,
  start_month <- paste(mavg_start_month, mavg_start_year, sep = " "),
  complaints <- amale_complaints,
  arrests <- amale_arrests,
  award_performance <- amale_awd_perf,
  trr_new <- amale_trr_new,
  observations <- male_observation
)

white_observation <- nrow(unique_nuid[unique_nuid$white == 1, ])
white_data <- unit44_data[unit44_data$white == 1, ] 
twhite_birth_year <- sum(unique_nuid[unique_nuid$white == 1, ]$birth_year, na.rm = TRUE)
twhite_complaints <- sum(white_data$cmpl_civ, na.rm = TRUE)
twhite_arrests <- sum(white_data$arrest, na.rm = TRUE)
twhite_trr_new <- sum(white_data$trr_new, na.rm = TRUE)
twhite_awd_perf <- sum(white_data$awd_perf, na.rm = TRUE)
awhite_birth_year <- round(twhite_birth_year / white_observation, digit = 2)
awhite_complaints <- round(twhite_complaints / white_observation, digit = 2)
awhite_arrests <- round(twhite_arrests / white_observation, digit = 2)
awhite_trr_new <- round(twhite_trr_new / white_observation, digit = 2)
awhite_awd_perf <- round(twhite_awd_perf / white_observation, digit = 2)

white_date <- as.character(unique_nuid[unique_nuid$white == 1, ]$start_month)
wstart_date <- data.frame(white_date, start_month)
wprocessed_start_date <- str_match(wstart_date$white_date, "^(\\d{2})([a-zA-Z]{3})(\\d{4})$")
wprocessed_start_date <- data.frame(wprocessed_start_date)
wprocessed_start_date$X2 <- as.integer(wprocessed_start_date$X2)
wprocessed_start_date$X4 <- as.integer(wprocessed_start_date$X4)
wtotal_start_year <- sum(wprocessed_start_date$X4)
wavg_start_year <- round(wtotal_start_year / white_observation)
month_mapping <- c(jan = 1, feb = 2, mar = 3, apr = 4, may = 5, jun = 6,
                   jul = 7, aug = 8, sep = 9, oct = 10, nov = 11, dec = 12)
wprocessed_start_month <- month_mapping[wprocessed_start_date$X3]
wprocessed_start_month <- as.integer(wprocessed_start_month)
wtotal_start_month <- sum(wprocessed_start_month)
wavg_start_month <- round(wtotal_start_month / white_observation, digit = 2)

clean_white_data <- data.frame(
  birth_year <- awhite_birth_year,
  start_month <- paste(wavg_start_month, wavg_start_year, sep = " "),
  complaints <- awhite_complaints,
  arrests <- awhite_arrests,
  award_performance <- awhite_awd_perf,
  trr_new <- awhite_trr_new,
  observations <- white_observation
)

black_observation <- nrow(unique_nuid[unique_nuid$black == 1, ])
black_data <- unit44_data[unit44_data$black == 1, ] 
tblack_birth_year <- sum(unique_nuid[unique_nuid$black == 1, ]$birth_year, na.rm = TRUE)
tblack_complaints <- sum(black_data$cmpl_civ, na.rm = TRUE)
tblack_arrests <- sum(black_data$arrest, na.rm = TRUE)
tblack_trr_new <- sum(black_data$trr_new, na.rm = TRUE)
tblack_awd_perf <- sum(black_data$awd_perf, na.rm = TRUE)
ablack_birth_year <- round(tblack_birth_year / black_observation, digit = 2)
ablack_complaints <- round(tblack_complaints / black_observation, digit = 2)
ablack_arrests <- round(tblack_arrests / black_observation, digit = 2)
ablack_trr_new <- round(tblack_trr_new / black_observation, digit = 2)
ablack_awd_perf <- round(tblack_awd_perf / black_observation, digit = 2)

black_date <- as.character(unique_nuid[unique_nuid$black == 1, ]$start_month)
bstart_date <- data.frame(black_date, start_month)
bprocessed_start_date <- str_match(bstart_date$black_date, "^(\\d{2})([a-zA-Z]{3})(\\d{4})$")
bprocessed_start_date <- data.frame(bprocessed_start_date)
bprocessed_start_date$X2 <- as.integer(bprocessed_start_date$X2)
bprocessed_start_date$X4 <- as.integer(bprocessed_start_date$X4)
btotal_start_year <- sum(bprocessed_start_date$X4)
bavg_start_year <- round(btotal_start_year / black_observation)
month_mapping <- c(jan = 1, feb = 2, mar = 3, apr = 4, may = 5, jun = 6,
                   jul = 7, aug = 8, sep = 9, oct = 10, nov = 11, dec = 12)
bprocessed_start_month <- month_mapping[bprocessed_start_date$X3]
bprocessed_start_month <- as.integer(bprocessed_start_month)
btotal_start_month <- sum(bprocessed_start_month)
bavg_start_month <- round(btotal_start_month / black_observation, digit = 2)

clean_black_data <- data.frame(
  birth_year <- ablack_birth_year,
  start_month <- paste(bavg_start_month, bavg_start_year, sep = " "),
  complaints <- ablack_complaints,
  arrests <- ablack_arrests,
  award_performance <- ablack_awd_perf,
  trr_new <- ablack_trr_new,
  observations <- black_observation
)


table_1 <- data.frame(
  everyone <- Everyone,
  white <- clean_white_data,
  black <- clean_black_data,
  male <- clean_male_data,
  female <- clean_female_data
)
organized_table_1 <- matrix(table_1, nrow = 7, ncol = 5)
row.names(organized_table_1) <- c("birth year", "start month", "complaints", "arrests", "award performance", "trr new", "observation")
colnames(organized_table_1) <- c("Everyone", "White", "Black", "Male", "Female")

write.csv(organized_table_1, "data/analysis_data/table_1_data.csv")

