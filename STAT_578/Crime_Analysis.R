library(leaflet)
library(dplyr)

IL_Renter_Crime = read.csv("/san-data/usecase/pca_projects/Tenant_Terr_Study/Yiming/IL_Renter_Crime.csv", header = TRUE)

# Filter out missing values
IL_Renter_Crime = IL_Renter_Crime[, -c(1, 2, 8)] %>% 
  # filter(CASE_INCURRED_CLAIM_CNT_NCAT > 0) %>%
  na.omit()

# Add Freqency, Severity, Pure Premium
IL_Renter_Crime$Freq = IL_Renter_Crime$CASE_INCURRED_CLAIM_CNT_NCAT/ IL_Renter_Crime$AIY # Frequency
IL_Renter_Crime$Sev = IL_Renter_Crime$CASE_INCURRED_NCAT/ IL_Renter_Crime$CASE_INCURRED_CLAIM_CNT_NCAT # Severity
IL_Renter_Crime$PP = IL_Renter_Crime$CASE_INCURRED_NCAT/ IL_Renter_Crime$AIY # Pure Premium

# Add Relativities
IL_Renter_Crime$Loss_Rel = IL_Renter_Crime$CASE_INCURRED_NCAT/ mean(IL_Renter_Crime$CASE_INCURRED_NCAT, na.rm = TRUE)
IL_Renter_Crime$Freq_Rel = IL_Renter_Crime$Freq/ mean(IL_Renter_Crime$Freq, na.rm = TRUE)
IL_Renter_Crime$Sev_Rel = IL_Renter_Crime$Sev/ mean(IL_Renter_Crime$Sev, na.rm = TRUE)
IL_Renter_Crime$PP_Rel = IL_Renter_Crime$PP/ mean(IL_Renter_Crime$PP, na.rm = TRUE)

# Add loss ratio
# IL_Renter_Crime$LR = IL_Renter_Crime$CASE_INCURRED_NCAT / (10 * IL_Renter_Crime$earned_prem)



########################################## Data set for Lorenz Curve #########################################
# (1) Sort by LRF
IL_Renter_Crime_sorted_LRF = IL_Renter_Crime[order(IL_Renter_Crime$CRED_IND_FCTR),]

# Add cumulative column
IL_Renter_Crime_sorted_LRF = IL_Renter_Crime_sorted_LRF %>% mutate(
  Cum_Prem = cumsum(.$NO_LOC_PREM) / sum(.$NO_LOC_PREM),
  Cum_Loss = cumsum(.$CASE_INCURRED_NCAT)/ sum(.$CASE_INCURRED_NCAT)
)

# Gini Index calculation
x = IL_Renter_Crime_sorted_LRF$Cum_Prem
y = IL_Renter_Crime_sorted_LRF$Cum_Loss
Gini = 2 * (0.5 - sum((y + lag(y))/2 * (x - lag(x)), na.rm = TRUE))

# Plot
plot(IL_Renter_Crime_sorted_LRF$Cum_Prem, IL_Renter_Crime_sorted_LRF$Cum_Loss, col = "red", xlab = "No-loc Premium Sorted by Non-Tenant LRF", ylab = "",
     xlim = c(0, 1), ylim = c(0, 1))
par(new = T)
plot(IL_Renter_Crime_sorted_LRF$Cum_Prem, IL_Renter_Crime_sorted_LRF$Cum_Prem, xlab = "", ylab = "", 
     title(main = paste("Gini Index =", paste0(formatC(100 * Gini, format = "f", digits = 2), "%"))),
     xlim = c(0, 1), ylim = c(0, 1))


# Remove temporary variables
rm(x)
rm(y)
rm(Gini)



# (5) Sort by PP_Rel
IL_Renter_Crime_sorted_PP_Rel = IL_Renter_Crime[order(IL_Renter_Crime$PP_Rel),]

# Add cumulative column
IL_Renter_Crime_sorted_PP_Rel = IL_Renter_Crime_sorted_PP_Rel %>% mutate(
  Cum_Prem = cumsum(.$NO_LOC_PREM) / sum(.$NO_LOC_PREM),
  Cum_Loss = cumsum(.$CASE_INCURRED_NCAT)/ sum(.$CASE_INCURRED_NCAT)
)

# Gini Index calculation
x = IL_Renter_Crime_sorted_PP_Rel$Cum_Prem
y = IL_Renter_Crime_sorted_PP_Rel$Cum_Loss
Gini = 2 * (0.5 - sum((y + lag(y))/2 * (x - lag(x)), na.rm = TRUE))

# Plot
plot(IL_Renter_Crime_sorted_PP_Rel$Cum_Prem, IL_Renter_Crime_sorted_PP_Rel$Cum_Loss, col = "red", xlab = "No-loc Premium Sorted by PP Relativities", ylab = "")
par(new = T)
plot(IL_Renter_Crime_sorted_PP_Rel$Cum_Prem, IL_Renter_Crime_sorted_PP_Rel$Cum_Prem, xlab = "", ylab = "", title(main = paste("Gini Index =", paste0(formatC(100 * Gini, format = "f", digits = 2), "%"))))


# Remove temporary variables
rm(x)
rm(y)
rm(Gini)















######################## MSE: Test on 2015 Data ##########################
IL_Renter_Crime_New = read.csv("~/Yiming/Spring2018/IL_Renter_2015_allperil.csv", header = TRUE)

# Filter out missing values
# Aggregate by GRID_ID (not separated by peril)
IL_Renter_Crime_New = IL_Renter_Crime_New  %>%
  group_by(GRID_ID) %>%
  summarise(
    NON_TENANT_LRF = mean(CRED_IND_FCTR),
    AIY = mean(AIY),
    EARNED_PREM = mean(earned_prem),
    CASE_INCURRED_NCAT = sum(CASE_INCURRED_NCAT),
    CASE_INCURRED_CLAIM_CNT_NCAT = sum(CASE_INCURRED_CLAIM_CNT_NCAT)
    ) %>% 
  na.omit() # 1809 obs

# Add Freqency, Severity, Pure Premium
IL_Renter_Crime_New$Freq_New = IL_Renter_Crime_New$CASE_INCURRED_CLAIM_CNT_NCAT/ IL_Renter_Crime_New$AIY # Frequency
IL_Renter_Crime_New$Sev_New = IL_Renter_Crime_New$CASE_INCURRED_NCAT/ IL_Renter_Crime_New$CASE_INCURRED_CLAIM_CNT_NCAT # Severity
IL_Renter_Crime_New$PP_New = IL_Renter_Crime_New$CASE_INCURRED_CLAIM_CNT_NCAT * IL_Renter_Crime_New$AIY # Pure Premium


# Add Relativities
IL_Renter_Crime_New$Loss_Rel_New = IL_Renter_Crime_New$CASE_INCURRED_NCAT/ mean(IL_Renter_Crime_New$CASE_INCURRED_NCAT, na.rm = TRUE)
IL_Renter_Crime_New$Freq_Rel_New = IL_Renter_Crime_New$Freq_New/ mean(IL_Renter_Crime_New$Freq_New, na.rm = TRUE)
IL_Renter_Crime_New$Sev_Rel_New = IL_Renter_Crime_New$Sev_New/ mean(IL_Renter_Crime_New$Sev_New, na.rm = TRUE)
IL_Renter_Crime_New$PP_Rel_New = IL_Renter_Crime_New$PP_New/ mean(IL_Renter_Crime_New$PP_New, na.rm = TRUE)



## Tentative Analysis
MSE = matrix(rep(0, 25), nrow = 5, ncol = 5)

# Row and Column names
dimnames(MSE) = list(
  c( "CRED_IND_FCTR", "Loss_Rel", "Freq_Rel", "Sev_Rel", "PP_Rel"),         # row names 
  c("CRED_IND_FCTR", "Loss_Rel_New", "Freq_Rel_New", "Sev_Rel_New", "PP_Rel_New")) # column names

for (i in 1:5) {
  for (j in 1:5) {
    MSE[i, j] = mean((Crime_New[, c( "CRED_IND_FCTR", "Loss_Rel", "Freq_Rel", "Sev_Rel", "PP_Rel")[i]] - Crime_New[, c("CRED_IND_FCTR", "Loss_Rel_New", "Freq_Rel_New", "Sev_Rel_New", "PP_Rel_New")[j]])^2)
  }
}
  

#                 CRED_IND_FCTR Loss_Rel_New Freq_Rel_New Sev_Rel_New PP_Rel_New
# CRED_IND_FCTR      0.000000     3.613236     33.90142    3.032139   24.32736
# Loss_Rel           6.214020     6.815722     39.66079    8.237489   29.86825
# Freq_Rel          14.763435    14.643644     45.12913   14.002877   35.42350
# Sev_Rel            2.124244     2.678023     32.53693    1.420734   22.94969
# PP_Rel            10.711931    10.948640     41.47965   10.673958   31.56739


# Normalization
for (i in 1:5) {
  for (j in 1:5) {
    MSE[i, j] = mean((scale(Crime_New[, c( "CRED_IND_FCTR", "Loss_Rel", "Freq_Rel", "Sev_Rel", "PP_Rel")[i]]) - scale(Crime_New[, c("CRED_IND_FCTR", "Loss_Rel_New", "Freq_Rel_New", "Sev_Rel_New", "PP_Rel_New")[j]]))^2)
  }
}

#                   CRED_IND_FCTR Loss_Rel_New Freq_Rel_New Sev_Rel_New PP_Rel_New
# CRED_IND_FCTR      0.000000     1.693620     1.897905    1.781739   1.847254
# Loss_Rel           1.621659     1.433481     2.018209    2.056380   1.988663
# Freq_Rel           1.835581     1.842620     1.995401    1.953014   1.974112
# Sev_Rel            1.326167     1.818463     1.977071    1.770919   1.905500
# PP_Rel             1.634051     1.732228     1.970618    1.917947   1.928045


## Stepwise AIC?
# Plots for log-transformation
qplot(Crime_New$Loss_Rel_New,
      geom="histogram",
      binwidth = 0.2,  
      main = "Histogram for 2015 Loss Relativity", 
      xlab = "LOSS_REL_NEW",  
      fill=I("blue"), 
      col=I("red"), 
      alpha=I(.2))

qplot(log(Crime_New$Loss_Rel_New),
      geom="histogram",
      binwidth = 0.2,  
      main = "Histogram for 2015 Loss Relativity", 
      xlab = "LOSS_REL_NEW",  
      fill=I("blue"), 
      col=I("red"), 
      alpha=I(.2))


# (1) Loss_Rel_New
library(MASS)
fit1 <- lm(log(Loss_Rel_New) ~ CRED_IND_FCTR + Loss_Rel + Freq_Rel + Sev_Rel + PP_Rel, data = Crime_New)
step1 <- stepAIC(fit1, direction = "both")
summary(step1) # adjusted R^2 = 0.090, F-statistic significant

par(mfrow=c(2, 2)) # diagnostic plots
plot(fit1, which = 1:4)


# (2) Freq_Rel_New
fit2 <- lm(log(Freq_Rel_New) ~ CRED_IND_FCTR + Loss_Rel + Freq_Rel + Sev_Rel + PP_Rel, data = Crime_New)
step2 <- stepAIC(fit2, direction = "both")
summary(step2)

par(mfrow=c(2, 2)) # diagnostic plots
plot(fit2, which = 1:4)

# (3) Sev_Rel_New
fit3 <- lm(log(Sev_Rel_New) ~ CRED_IND_FCTR + Loss_Rel + Freq_Rel + Sev_Rel + PP_Rel, data = Crime_New)
step3 <- stepAIC(fit3, direction = "both")
summary(step3)

par(mfrow=c(2, 2)) # diagnostic plots
plot(fit3, which = 1:4)

# (4) PP_Rel_New
fit4 <- lm(log(PP_Rel_New) ~ CRED_IND_FCTR + Loss_Rel + Freq_Rel + Sev_Rel + PP_Rel, data = Crime_New)
step4 <- stepAIC(fit4, direction = "both")
summary(step4)

par(mfrow=c(2, 2)) # diagnostic plots
plot(fit4, which = 1:4)









