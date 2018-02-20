# Please refer to the Lift charts in Research Ideas in Onenote
########################################## LIFT #########################################
IL_Renter_Crime = read.csv("/san-data/usecase/pca_projects/Tenant_Terr_Study/Yiming/IL_Renter_Crime.csv", header = TRUE)

# IL_Condo_Crime = read.csv("/san-data/usecase/pca_projects/Tenant_Terr_Study/Yiming/IL_Condo_Crime.csv", header = TRUE)

# IL_Renter_Crime = WI_Condo_Crime
# WI_Renter_Crime = read.csv("/san-data/usecase/pca_projects/Tenant_Terr_Study/Yiming/WI_Renter_Crime.csv", header = TRUE)
# 
# WI_Condo_Crime = read.csv("/san-data/usecase/pca_projects/Tenant_Terr_Study/Yiming/WI_Condo_Crime.csv", header = TRUE)
# WI_Condo_Crime$Zone_fctr = ifelse(WI_Condo_Crime$ZONE == 20, 1.057,
#                                   ifelse(WI_Condo_Crime$ZONE == 21, 1.169,
#                                          ifelse(WI_Condo_Crime$ZONE == 22, 0.895,
#                                                 ifelse(WI_Condo_Crime$ZONE == 23, 0.707, 1.18))))
# WI_Condo_Crime$NO_LOC_PREM = WI_Condo_Crime$earned_prem/ WI_Condo_Crime$Zone_fctr


# Filter out missing values
IL_Renter_Crime = IL_Renter_Crime[, -c(1, 2, 7)] %>% 
  # filter(CASE_INCURRED_CLAIM_CNT_NCAT > 0) %>%
  na.omit()

# Add Freqency, Severity, Pure Premium
# IL_Crime_Crime$Freq = IL_Renter_Crime$CASE_INCURRED_CLAIM_CNT_NCAT/ IL_Renter_Crime$AIY # Frequency
# IL_Renter_Crime$Sev = IL_Renter_Crime$CASE_INCURRED_NCAT/ IL_Renter_Crime$CASE_INCURRED_CLAIM_CNT_NCAT # Severity
IL_Renter_Crime$PP = IL_Renter_Crime$CASE_INCURRED_NCAT/ IL_Renter_Crime$AIY # Pure Premium

# Add Relativities
# IL_Renter_Crime$PP_Rel = IL_Renter_Crime$PP/ mean(IL_Renter_Crime$PP, na.rm = TRUE)

# Add loss ratio
# IL_Renter_Crime$LR = IL_Renter_Crime$CASE_INCURRED_NCAT / (10 * IL_Renter_Crime$earned_prem)

sum_AIY = sum(IL_Renter_Crime$AIY)


# Step 1: Sorted by LRF Predicted Loss Cost
IL_Renter_Crime_sorted_LRF = IL_Renter_Crime
IL_Renter_Crime_sorted_LRF$LRF_Pred_Loss = IL_Renter_Crime_sorted_LRF$NO_LOC_PREM * IL_Renter_Crime_sorted_LRF$CRED_IND_FCTR # LRF Predicted Loss Cost
IL_Renter_Crime_sorted_LRF = IL_Renter_Crime_sorted_LRF[order(IL_Renter_Crime_sorted_LRF$LRF_Pred_Loss),]

# LRF PP = NO_LOC_PREM * CRED_IND_FCTR / AIY
IL_Renter_Crime_sorted_LRF$LRF_PP = IL_Renter_Crime_sorted_LRF$LRF_Pred_Loss / IL_Renter_Crime_sorted_LRF$AIY
IL_Renter_Crime_sorted_LRF$LRF_PP_Rel = IL_Renter_Crime_sorted_LRF$LRF_PP/ mean(IL_Renter_Crime_sorted_LRF$LRF_PP, na.rm = TRUE)


# Step 2: Add cumulative column & Group the data
IL_Renter_Crime_sorted_LRF = IL_Renter_Crime_sorted_LRF %>% mutate(
  Cum_AIY = cumsum(.$AIY)
)

IL_Renter_Crime_sorted_LRF$Group = rep(0, nrow(IL_Renter_Crime_sorted_LRF))
for (i in 1:nrow(IL_Renter_Crime_sorted_LRF)) {
  for (j in 1:10) {
    if ((IL_Renter_Crime_sorted_LRF[i, ]$Cum_AIY > (j-1)*sum_AIY/10) & (IL_Renter_Crime_sorted_LRF[i, ]$Cum_AIY <= j*sum_AIY/10)) {
      IL_Renter_Crime_sorted_LRF[i, ]$Group = j
    }
  }
}

# Have a look at the quantiles
table(IL_Renter_Crime_sorted_LRF$Group)

# Step 3: 
x = IL_Renter_Crime_sorted_LRF %>% group_by(Group) %>% summarise(Pred_PP = mean(LRF_PP)) # LRF Predicted
y = IL_Renter_Crime_sorted_LRF %>% group_by(Group) %>%summarise(PP = mean(PP)) # Actual
z = c(mean(z[q1]), mean(z[q2]), mean(z[q3]), mean(z[q4]), mean(z[q5]), mean(z[q6]), mean(z[q7]), mean(z[q8]), mean(z[q9]), mean(z[q10]))/mean(z)

#Simple Quantile Plots ('Model' is No_Loc_Prem and 'actual' is Case_Incurred)
plot(x[-1, ], xlim = c(1, 10), ylim = c(0, 20), main = NA, pch = 19, type = 'b', xlab = 'Quantile', ylab = "", col = "red")
lines(y[-1, ], type = 'b', col = 'black', pch = 19)
legend("topleft", c("Non-tenant Crime LRF Predicted PP", "Actual PP"), col = c("red", "black"), lty = c(1, 1))
title(main = paste('IL-Renter-Crime\n', paste("Lift =", round(y$PP[10] / y$PP[1], digits = 2)))) # should be actual loss
grid()

#Loss Ratio Chart (Case_Incurred/Earned_Prem)
value = round(y1*mean(y)/ (z1*mean(z)), digits = 2)
bplt = barplot(value, ylab = "Loss Ratio", xlab = "Predicted Loss Cost Quantiles")
text(x = bplt, y = value + 0.2, labels = as.character(value), xpd = TRUE)
title(main = "IL_Renter_Crime - LRF")


############################################# Double Lift chart ##########################################
#want to check if using non tenant LRF instead of zone factors is a better predictor
#create ratio between model a and b to sort the data
IL_Renter_Crime_sorted_ratio = IL_Renter_Crime
IL_Renter_Crime_sorted_ratio$ratio = IL_Renter_Crime_sorted_ratio$CRED_IND_FCTR/IL_Renter_Crime_sorted_ratio$zone_fctr
IL_Renter_Crime_sorted_ratio = IL_Renter_Crime_sorted_ratio[order(IL_Renter_Crime_sorted_ratio$ratio), ]

#calculate averages of model a, model b and actual loss for each quantile
x = IL_Renter_Crime_sorted_ratio$NO_LOC_PREM * IL_Renter_Crime_sorted_ratio$CRED_IND_FCTR
y = IL_Renter_Crime_sorted_ratio$earned_prem
z = IL_Renter_Crime_sorted_ratio$CASE_INCURRED_NCAT
x1 = c(mean(x[q1]), mean(x[q2]), mean(x[q3]), mean(x[q4]), mean(x[q5]), mean(x[q6]), mean(x[q7]), mean(x[q8]), mean(x[q9]), mean(x[q10]))/mean(x)
y1 = c(mean(y[q1]), mean(y[q2]), mean(y[q3]), mean(y[q4]), mean(y[q5]), mean(y[q6]), mean(y[q7]), mean(y[q8]), mean(y[q9]), mean(y[q10]))/mean(y)
z1 = c(mean(z[q1]), mean(z[q2]), mean(z[q3]), mean(z[q4]), mean(z[q5]), mean(z[q6]), mean(z[q7]), mean(z[q8]), mean(z[q9]), mean(z[q10]))/mean(z)
#create plot comparing the models
#Simple Quantile Plots ('Model' is No_Loc_Prem*LRF and 'actual' is Case_Incurred)
plot(x1, xlim = c(0,10), ylim = c(0, 3), main = 'IL_Renter_Crime', pch = 15, type = 'b', xlab = 'Decile', ylab = "Relative Loss Cost", col = 'red')
lines(y1, type = 'b', col = 'blue', pch = 17)
lines(z1, type = 'b', col = 'black', pch = 19)
legend("topleft", c("LRF Model", "Zone Model", "Actual"), col = c("red", "blue", "black"), pch = c(15, 17, 19), lty = c(1,1))
grid()
