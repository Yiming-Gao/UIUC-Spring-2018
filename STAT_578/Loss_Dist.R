library(leaflet)
library(dplyr)
library(pracma)
library(tidyr)
library(data.table) 
library(ggplot2)
library(maptools)
library(zipcode)
library(noncensus)

library(devtools)


data("counties")
counties = counties[counties$state == 'IL', c(1, 4)]
names(counties)[names(counties) == 'county_fips'] = 'fips'
counties$fips = as.numeric(counties$fips) + 17000

data("zip_codes")
zip_codes = zip_codes[zip_codes$state == 'IL',]
zip_codes = zip_codes[order(zip_codes$fips), c(1, 6)]

merg1 = merge(zip_codes, counties, by = "fips")

IL_Renter_Loss_Full = read.csv("/san-data/usecase/pca_projects/Tenant_Terr_Study/Yiming/IL_Renter_Loss_Full.csv", header = TRUE)

# Filter out missing values
IL_Renter_Loss_Full = IL_Renter_Loss_Full[, c(3, 8, 11)] %>% 
  na.omit()

IL_Renter_Loss_Full = IL_Renter_Loss_Full[order(IL_Renter_Loss_Full$ZIP), ]
names(IL_Renter_Loss_Full)[names(IL_Renter_Loss_Full) == 'ZIP'] = 'zip'

IL_Renter_Loss_Full = merge(merg1, IL_Renter_Loss_Full, by = "zip")
IL_Renter_Loss_Full$county_name = tolower(IL_Renter_Loss_Full$county_name)
IL_Renter_Loss_Full$county_name = removeWords(IL_Renter_Loss_Full$county_name, " county")

head(IL_Renter_Loss_Full)
names(IL_Renter_Loss_Full)[names(IL_Renter_Loss_Full) == 'county_name'] = 'subregion'

############################ Loss Distribution Plot for the state by county
### 3/2/18 Yiming
Loss_by_peril = IL_Renter_Loss_Full %>% 
  group_by_(.dots = c("subregion", "col")) %>% 
  summarise(sum_loss_byperil = sum(CASE_INCURRED_NCAT))

# New column that contains probabilities
Loss_by_peril = Loss_by_peril %>% group_by(subregion) %>% mutate(peril_prop = sum_loss_byperil/ sum(sum_loss_byperil))

# Imputate col
for (i in unique(Loss_by_peril$subregion)) {
  if (length(Loss_by_peril[Loss_by_peril$subregion == i, ]$col) != 5) {
    diff = setdiff( c("Crime", "Fire", "OEC", "S2", "W/H"), as.vector(Loss_by_peril[Loss_by_peril$subregion == i, ]$col))
    for (j in diff) {
      Loss_by_peril = rbind(data.frame(Loss_by_peril), data.frame("subregion" = i, "col"= j,  "sum_loss_byperil" = 0, "peril_prop" = 0))
    }
  }
}

Loss_by_peril = Loss_by_peril[order(Loss_by_peril$subregion), ]
Loss_by_peril_Crime = Loss_by_peril[Loss_by_peril$col == "Crime", ]


# map
states <- map_data("state")
il_df <- subset(states, region == "illinois")
counties <- map_data("county")
il_county <- subset(counties, region == "illinois")

IL_base = ggplot(data = il_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")

IL_base + geom_polygon(data = il_county, fill = NA, color = "white") +
  geom_polygon(color = "black", fill = NA) 

Loss_by_peril_Crime = inner_join(il_county, Loss_by_peril_Crime, by = "subregion")

ditch_the_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank()
)

elbow_room1 <- IL_base + 
  geom_polygon(data = Loss_by_peril_Crime, aes(fill = peril_prop), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_bw() +
  ditch_the_axes

elbow_room1 


###################
























#look at loss relativities by peril
crime = sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT[IL_Renter_Loss_Full$col == 'Crime'])/sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT)
subfire = sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT[IL_Renter_Loss_Full$col == 'Fire'])/sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT)
oec = sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT[IL_Renter_Loss_Full$col == 'OEC'])/sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT)
wh = sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT[IL_Renter_Loss_Full$col == 'W/H'])/sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT)
s2 = sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT[IL_Renter_Loss_Full$col == 'S2'])/sum(IL_Renter_Loss_Full$CASE_INCURRED_NCAT)
cbind(crime,fire,oec,wh,s2)

#make a county variable that puts each observation in a county
bycounty = IL_Renter_Loss_Full[order(IL_Renter_Loss_Full$subregion),]
names(bycounty)[names(bycounty) == 'CASE_INCURRED_NCAT'] = 'loss'

#sum the Case incurred non-catastrophic losses by county and peril
bycounty = bycounty %>% 
  group_by(subregion,col) %>% 
  summarise(loss = sum(loss))

#get the relativity of crime by county throughout the whole state
bycounty_crime
group_by(bycounty, subregion)

bycounty_crime = bycounty %>% 
  group_by(subregion) %>% 
  mutate(loss_crime = bycounty[col == "Crime", ]/sum(loss)) #can do this for any peril (Crime, Fire, OEC, W/H, S2)

####### create plot ######
#make a dataset with county names and crime loss relativity together
map_data('county','illinois')
counties = unique(map_data('county','illinois')[,6])
crime_dist_map = data.frame(county_names=counties, 
                            dist = bycounty_crime$loss)

#set up ggplot by combining crime loss distribution with all of map_data dataset values 
map_county = data.table(map_data('county', 'illinois'))
setkey(map_county,subregion)
crime_dist_map = data.table(crime_dist_map)
setkey(crime_dist_map,county_names)
map_df = map_county[crime_dist_map]

#plot the loss distribution on the state of illinois
ggplot(map_df, aes(x=long, y=lat, group=group, fill=dist)) + 
  scale_fill_gradientn("",colours=terrain.colors(10)) +
  geom_polygon(data = map_df, aes(x = map_county$long, y = map_county$lat), colour = 'black') +
  coord_map() +
  expand_limits(x = map_county$long, y = map_county$lat) +
  labs(title = 'Renters Loss Relativity for Crime by County')

#look at the differences in loss distribution for crime across the counties
round(sort(bycounty_crime$loss, decreasing = TRUE), 2)


for(i in 1:length(IL_Renter_Loss_Full)){
  
}


  
