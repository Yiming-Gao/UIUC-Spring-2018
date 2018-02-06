######################## MSE: Test on 2015 Data ##########################
IL_Renter_Crime_New = read.csv("~/Yiming/Spring2018/IL_Renter_2015_allperil.csv", header = TRUE)
IL_Renter_Crime_New$CASE_INCURRED_NCAT[is.na(IL_Renter_Crime_New$CASE_INCURRED_NCAT)] = 0

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
  ) # %>% 
 # na.omit() # 1809 obs

# Add Freqency, Severity, Pure Premium
# IL_Renter_Crime_New$Freq_New = IL_Renter_Crime_New$CASE_INCURRED_CLAIM_CNT_NCAT/ IL_Renter_Crime_New$AIY # Frequency
# IL_Renter_Crime_New$Sev_New = IL_Renter_Crime_New$CASE_INCURRED_NCAT/ IL_Renter_Crime_New$CASE_INCURRED_CLAIM_CNT_NCAT # Severity
IL_Renter_Crime_New$PP_New = IL_Renter_Crime_New$CASE_INCURRED_NCAT / IL_Renter_Crime_New$AIY # Pure Premium


# Add Relativities
# IL_Renter_Crime_New$Loss_Rel_New = IL_Renter_Crime_New$CASE_INCURRED_NCAT/ mean(IL_Renter_Crime_New$CASE_INCURRED_NCAT, na.rm = TRUE)
# IL_Renter_Crime_New$Freq_Rel_New = IL_Renter_Crime_New$Freq_New/ mean(IL_Renter_Crime_New$Freq_New, na.rm = TRUE)
# IL_Renter_Crime_New$Sev_Rel_New = IL_Renter_Crime_New$Sev_New/ mean(IL_Renter_Crime_New$Sev_New, na.rm = TRUE)
IL_Renter_Crime_New$PP_Rel_New = IL_Renter_Crime_New$PP_New/ mean(IL_Renter_Crime_New$PP_New, na.rm = TRUE)


# MSE
mean((IL_Renter_Crime_New$NON_TENANT_LRF - IL_Renter_Crime_New$PP_Rel_New)^2, na.rm = TRUE) #2391.113











######################## MSE: Test on 2015 Data for CONDO ##########################
IL_Renter_Condo_New = read.csv("~/Yiming/Spring2018/IL_Condo_2015_allperil.csv", header = TRUE)
IL_Renter_Condo_New$CASE_INCURRED_NCAT[is.na(IL_Renter_Condo_New$CASE_INCURRED_NCAT)] = 0

# Filter out missing values
# Aggregate by GRID_ID (not separated by peril)
IL_Renter_Condo_New = IL_Renter_Condo_New  %>%
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
# IL_Renter_Condo_New$Freq_New = IL_Renter_Condo_New$CASE_INCURRED_CLAIM_CNT_NCAT/ IL_Renter_Condo_New$AIY # Frequency
# IL_Renter_Condo_New$Sev_New = IL_Renter_Condo_New$CASE_INCURRED_NCAT/ IL_Renter_Condo_New$CASE_INCURRED_CLAIM_CNT_NCAT # Severity
IL_Renter_Condo_New$PP_New = IL_Renter_Condo_New$CASE_INCURRED_NCAT / IL_Renter_Condo_New$AIY # Pure Premium


# Add Relativities
# IL_Renter_Condo_New$Loss_Rel_New = IL_Renter_Condo_New$CASE_INCURRED_NCAT/ mean(IL_Renter_Condo_New$CASE_INCURRED_NCAT, na.rm = TRUE)
# IL_Renter_Condo_New$Freq_Rel_New = IL_Renter_Condo_New$Freq_New/ mean(IL_Renter_Condo_New$Freq_New, na.rm = TRUE)
# IL_Renter_Condo_New$Sev_Rel_New = IL_Renter_Condo_New$Sev_New/ mean(IL_Renter_Condo_New$Sev_New, na.rm = TRUE)
IL_Renter_Condo_New$PP_Rel_New = IL_Renter_Condo_New$PP_New/ mean(IL_Renter_Condo_New$PP_New, na.rm = TRUE)


# MSE
mean((IL_Renter_Condo_New$NON_TENANT_LRF - IL_Renter_Condo_New$PP_Rel_New)^2, na.rm = TRUE)
