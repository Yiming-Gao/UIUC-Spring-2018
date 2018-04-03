######################## MSE: Test on 2015 Data ##########################
IL_Renter_New = read.csv("~/Yiming/Spring2018/IL_Renter_2015_allperil.csv", header = TRUE)
IL_Renter_New$CASE_INCURRED_NCAT[is.na(IL_Renter_New$CASE_INCURRED_NCAT)] = 0

# Filter out missing values
# Aggregate by GRID_ID (not separated by peril)
IL_Renter_New = IL_Renter_New  %>%
  group_by(GRID_ID) %>%
  summarise(
    NON_TENANT_LRF = mean(CRED_IND_FCTR),
    AIY = mean(AIY),
    EARNED_PREM = mean(earned_prem),
    CASE_INCURRED_NCAT = sum(CASE_INCURRED_NCAT),
    CASE_INCURRED_CLAIM_CNT_NCAT = sum(CASE_INCURRED_CLAIM_CNT_NCAT)
  ) # %>% 
 # na.omit() # 1809 obs

# Add Freqency, Severity, Pure Premium
# IL_Renter_Crime_New$Freq_New = IL_Renter_Crime_New$CASE_INCURRED_CLAIM_CNT_NCAT/ IL_Renter_Crime_New$AIY # Frequency
# IL_Renter_Crime_New$Sev_New = IL_Renter_Crime_New$CASE_INCURRED_NCAT/ IL_RAggreenter_Crime_New$CASE_INCURRED_CLAIM_CNT_NCAT # Severity
IL_Renter_New$PP_New = IL_Renter_New$CASE_INCURRED_NCAT / IL_Renter_New$AIY # Pure Premium


# Add Relativities
# IL_Renter_Crime_New$Loss_Rel_New = IL_Renter_Crime_New$CASE_INCURRED_NCAT/ mean(IL_Renter_Crime_New$CASE_INCURRED_NCAT, na.rm = TRUE)
# IL_Renter_Crime_New$Freq_Rel_New = IL_Renter_Crime_New$Freq_New/ mean(IL_Renter_Crime_New$Freq_New, na.rm = TRUE)
# IL_Renter_Crime_New$Sev_Rel_New = IL_Renter_Crime_New$Sev_New/ mean(IL_Renter_Crime_New$Sev_New, na.rm = TRUE)
IL_Renter_New$PP_Rel_New = IL_Renter_New$PP_New/ mean(IL_Renter_New$PP_New, na.rm = TRUE)


# MSE
mean((IL_Renter_New$NON_TENANT_LRF - IL_Renter_New$PP_Rel_New)^2, na.rm = TRUE) 











######################## MSE: Test on 2015 Data for CONDO ###########################
IL_Condo_New = read.csv("~/Yiming/Spring2018/IL_Condo_2015_allperil.csv", header = TRUE)
IL_Condo_New$CASE_INCURRED_NCAT[is.na(IL_Condo_New$CASE_INCURRED_NCAT)] = 0

# Filter out missing values
# Aggregate by GRID_ID (not separated by peril)
IL_Condo_New = IL_Condo_New  %>%
  group_by(GRID_ID) %>%
  summarise(
    NON_TENANT_LRF = mean(CRED_IND_FCTR),
    AIY = mean(AIY),
    EARNED_PREM = mean(earned_prem),
    CASE_INCURRED_NCAT = sum(CASE_INCURRED_NCAT),
    CASE_INCURRED_CLAIM_CNT_NCAT = sum(CASE_INCURRED_CLAIM_CNT_NCAT)
  ) # %>% 
# na.omit() # 1809 obs

# Pure Premium
IL_Condo_New$PP_New = IL_Condo_New$CASE_INCURRED_NCAT / IL_Condo_New$AIY # Pure Premium
IL_Condo_New$PP_Rel_New = IL_Condo_New$PP_New/ mean(IL_Condo_New$PP_New, na.rm = TRUE)


# MSE
mean((IL_Condo_New$NON_TENANT_LRF - IL_Condo_New$PP_Rel_New)^2, na.rm = TRUE)





######################## MSE: Test on 2015 Data for RENTER&CONDO ##########################
(sum((IL_Renter_New$NON_TENANT_LRF - IL_Renter_New$PP_Rel_New)^2, na.rm = TRUE) + sum((IL_Condo_New$NON_TENANT_LRF - IL_Condo_New$PP_Rel_New)^2, na.rm = TRUE))/ (nrow(IL_Renter_New) + nrow(IL_Condo_New))








###################################################################################################################
#################################################### WI ###########################################################
###################################################################################################################
######################## MSE: Test on 2015 Data ##########################
WI_Renter_New = read.csv("~/Yiming/Spring2018/WI_Renter_2015_allperil.csv", header = TRUE)
WI_Renter_New$CASE_INCURRED_NCAT[is.na(WI_Renter_New$CASE_INCURRED_NCAT)] = 0

# Filter out missing values
# Aggregate by GRID_ID (not separated by peril)
WI_Renter_New = WI_Renter_New  %>%
  group_by(GRID_ID) %>%
  summarise(
    NON_TENANT_LRF = mean(CRED_IND_FCTR),
    AIY = mean(AIY),
    EARNED_PREM = mean(earned_prem),
    CASE_INCURRED_NCAT = sum(CASE_INCURRED_NCAT),
    CASE_INCURRED_CLAIM_CNT_NCAT = sum(CASE_INCURRED_CLAIM_CNT_NCAT)
  ) # %>% 
# na.omit() # 1809 obs

# Add Freqency, Severity, Pure Premium
# WI_Renter_Crime_New$Freq_New = WI_Renter_Crime_New$CASE_INCURRED_CLAIM_CNT_NCAT/ WI_Renter_Crime_New$AIY # Frequency
# WI_Renter_Crime_New$Sev_New = WI_Renter_Crime_New$CASE_INCURRED_NCAT/ WI_RAggreenter_Crime_New$CASE_INCURRED_CLAIM_CNT_NCAT # Severity
WI_Renter_New$PP_New = WI_Renter_New$CASE_INCURRED_NCAT / WI_Renter_New$AIY # Pure Premium


# Add Relativities
# WI_Renter_Crime_New$Loss_Rel_New = WI_Renter_Crime_New$CASE_INCURRED_NCAT/ mean(WI_Renter_Crime_New$CASE_INCURRED_NCAT, na.rm = TRUE)
# WI_Renter_Crime_New$Freq_Rel_New = WI_Renter_Crime_New$Freq_New/ mean(WI_Renter_Crime_New$Freq_New, na.rm = TRUE)
# WI_Renter_Crime_New$Sev_Rel_New = WI_Renter_Crime_New$Sev_New/ mean(WI_Renter_Crime_New$Sev_New, na.rm = TRUE)
WI_Renter_New$PP_Rel_New = WI_Renter_New$PP_New/ mean(WI_Renter_New$PP_New, na.rm = TRUE)


# MSE
mean((WI_Renter_New$NON_TENANT_LRF - WI_Renter_New$PP_Rel_New)^2, na.rm = TRUE) 











######################## MSE: Test on 2015 Data for CONDO ##########################
WI_Condo_New = read.csv("~/Yiming/Spring2018/WI_Condo_2015_allperil.csv", header = TRUE)
WI_Condo_New$CASE_INCURRED_NCAT[is.na(WI_Condo_New$CASE_INCURRED_NCAT)] = 0

# FWIter out missing values
# Aggregate by GRID_ID (not separated by peril)
WI_Condo_New = WI_Condo_New  %>%
  group_by(GRID_ID) %>%
  summarise(
    NON_TENANT_LRF = mean(CRED_IND_FCTR),
    AIY = mean(AIY),
    EARNED_PREM = mean(earned_prem),
    CASE_INCURRED_NCAT = sum(CASE_INCURRED_NCAT),
    CASE_INCURRED_CLAIM_CNT_NCAT = sum(CASE_INCURRED_CLAIM_CNT_NCAT)
  ) # %>% 
# na.omit() # 1809 obs

# Pure Premium
WI_Condo_New$PP_New = WI_Condo_New$CASE_INCURRED_NCAT / WI_Condo_New$AIY # Pure Premium
WI_Condo_New$PP_Rel_New = WI_Condo_New$PP_New/ mean(WI_Condo_New$PP_New, na.rm = TRUE)


# MSE
mean((WI_Condo_New$NON_TENANT_LRF - WI_Condo_New$PP_Rel_New)^2, na.rm = TRUE)





######################## MSE: Test on 2015 Data for RENTER&CONDO ##########################
(sum((WI_Renter_New$NON_TENANT_LRF - WI_Renter_New$PP_Rel_New)^2, na.rm = TRUE) + sum((WI_Condo_New$NON_TENANT_LRF - WI_Condo_New$PP_Rel_New)^2, na.rm = TRUE))/ (nrow(WI_Renter_New) + nrow(WI_Condo_New))
