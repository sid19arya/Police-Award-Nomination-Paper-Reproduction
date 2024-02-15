library(tidyverse)
library(quantreg)

bw_b <- c()
bw_se <- c()
bw_lb <- c()
bw_ub <- c()
fm_b <- c()
fm_se <- c()
fm_lb <- c()
fm_ub <- c()

for (q in seq(0.2, 0.9, by = 0.05)) {
  # Perform quantile regression
  model <- rq(awd_perf ~ black + female + hisp + asian + natam + 
                birth_year + tenure + tenure2 + tenure3 + year + 
                group, data = data, tau = q)
  # These couple lines need to be fixed!
  bw_b <- c(bw_b, coef(model)["black"])
  bw_se <- c(bw_se, summary(model)$coef["black", "Pr(>|t|)"])
  bw_lb <- c(bw_lb, coef(model)["black"] - qt(0.025, df = 4045)[1] * summary(model)$coef["black", "Std. Error"])
  bw_ub <- c(bw_ub, coef(model)["black"] + qt(0.025, df = 4045)[1] * summary(model)$coef["black", "Std. Error"])
  
  fm_b <- c(fm_b, coef(model)["female"])
  fm_se <- c(fm_se, summary(model)$coef["female", "Pr(>|t|)"])
  fm_lb <- c(fm_lb, coef(model)["female"] - qt(0.025, df = 4045)[1] * summary(model)$coef["black", "Std. Error"])
  fm_ub <- c(fm_ub, coef(model)["female"] + qt(0.025, df = 4045)[1] * summary(model)$coef["black", "Std. Error"])
}

bw <- c(rep(1, 15), rep(0, 15))
fm <- c(rep(0,15), rep(1, 15))
coef <- c(bw_b, fm_b)
lb <- c(bw_lb, fm_lb)
ub <- c(bw_ub, fm_ub)
qtile <- seq(0.2, 0.9, by = 0.05)

C_df <- data.frame(bw, fm, coef, lb, ub, qtile)

write.csv(C_df, "data/analysis_data/figure_1_data.csv")

