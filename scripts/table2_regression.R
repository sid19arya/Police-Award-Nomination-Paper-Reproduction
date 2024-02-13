data <- read.csv("./data/officer_year_data.csv")

library(tidyverse)
library(plm)
library(lmtest)
library(sandwich)
library(stargazer)
library(dplyr)


# Line 1: Fixed effects model with variable lists
model1 <- plm(awd_perf ~ black + hisp + asian + natam +birth_year+ tenure +
                tenure2 + tenure3 + L_cmpl_civ + L_cmpl_civ2 + L_cmpl_civ3 +
                L_arrest_total + L_arrest_total2 + L_arrest_total3 +  L_trr_new 
              + L_trr_new2 + L_trr_new3, data = data, model = "within", 
              index = c("group", "year"), effect = "twoways")

# Line 2: Generate 'sample' variable based on the existence of fixed effects
data$sample <- as.integer(length(unique(data$group)) > 1)

# Line 3: Fixed effects model conditional on the 'sample' variable

# fixed effect regression of races on awards performances
fe_reg_black <- plm( awd_perf ~ black + hisp + asian + natam,
                     data = subset(data, sample == 1), index = c("group", "year"), 
               model = "within", effect = "twoways", vcov = "CR2")



# fixed effect regression of gender on awards performances
fe_reg_female <-plm( awd_perf ~ female,
                     data = subset(data, sample == 1), index = c("group", "year"), 
                     model = "within", effect = "twoways",  vcov = "CR2")

# fixed effect regression of gender and races on awards performances
fe_reg_black_female <- plm(awd_perf ~ female+black + hisp + asian + natam+
                             birth_year+ tenure +  tenure2 + tenure3 +
                             L_cmpl_civ +L_cmpl_civ2 + L_cmpl_civ3 +
                             L_arrest_total + L_arrest_total2 + L_arrest_total3+ 
                             L_trr_new + L_trr_new2 + L_trr_new3,
                           data = data,model = "within", 
                           index = c("group", "year"), effect = "twoways")

# fixed effect regression of races*gender on awards performances
fe_reg_blackxfemale <- plm(awd_perf ~ female *black + hisp + asian + natam+
                             birth_year+ tenure +  tenure2 + tenure3 +
                             L_cmpl_civ +L_cmpl_civ2 + L_cmpl_civ3 +
                             L_arrest_total + L_arrest_total2 + L_arrest_total3+ 
                             L_trr_new + L_trr_new2 + L_trr_new3, 
                           data = data,
                           model = "within", index = c("group", "year"), 
                           effect = "twoways")

# Sum awd_perf if white == 1
mean_white <- mean(data$awd_perf[data$white == 1], na.rm = TRUE)

# Sum awd_perf if female == 0
mean_female_0 <- mean(data$awd_perf[data$female == 0], na.rm = TRUE)

# Sum awd_perf if white == 1 & female == 0
mean_white_female_0 <- mean(data$awd_perf[data$white == 1 
                                             & data$female == 0], 
                          na.rm = TRUE)





#final table

stargazer(fe_reg_black,fe_reg_female, fe_reg_black_female,fe_reg_blackxfemale, 
          omit =c("hisp", "asian", "natam", "birth_year", "tenure", "tenure2",
          "tenure3", "L_cmpl_civ", "L_cmpl_civ2", "L_cmpl_civ3",
          "L_arrest_total", "L_arrest_total2","L_arrest_total3","L_trr_new",
          "L_trr_new2","L_trr_new3"),
          omit.stat=c("f", "rsq","adj.rsq"),
          add.lines=list(c("Control for"),
                         c("Cohort", "Yes", "Yes", "Yes", "Yes"), 
                         c("Year",  "Yes", "Yes", "Yes", "Yes"), 
                         c("Demographics", " ", " ", "Yes", "Yes"),
                         c("Policing activities", "", "", "Yes", "Yes"),
                         c("Reference group mean",round(mean_white, digits = 2), 
                           round(mean_female_0, digits = 2), 
                           round(mean_white_female_0, digits = 2), 
                           round(mean_white_female_0, digits = 2))), 
          type = 'text')

