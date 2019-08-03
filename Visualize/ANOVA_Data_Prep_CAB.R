#This saves a .csv that was destined for Vasiliy
#Environmental Dependencies: B1 and filt_storms_info which work for poster_visuals

#Record to filt_storms_info:
#1. the SpCond at the start of the storm
#2. averaged water temperature from the storm
#3. maximum discharge seen in-storm

filt_storms_info$Start_SpCond <- NaN
filt_storms_info$End_SpCond <- NaN
filt_storms_info$Flux_SpCond <- NaN
filt_storms_info$uWTemp <- NaN
filt_storms_info$MaxDis <- NaN
filt_storms_info$yday <- NaN


for( ID in unique(filt_storms_info$Storm_ID)){
  
  stormdata <- filter( B1, ID == Storm_ID )
  
  filt_storms_info[ ID == filt_storms_info$Storm_ID, "Start_SpCond" ] <- stormdata$SpCond_uScm[1]
  filt_storms_info[ ID == filt_storms_info$Storm_ID, "End_SpCond" ] <- stormdata$SpCond_uScm[nrow(stormdata)]
  filt_storms_info[ ID == filt_storms_info$Storm_ID, "Flux_SpCond" ] <- 
    (stormdata$SpCond_uScm[1] - stormdata$SpCond_uScm[nrow(stormdata)] )
  filt_storms_info[ ID == filt_storms_info$Storm_ID, "uWTemp" ] <- mean( stormdata$Temp_degC )
  filt_storms_info[ ID == filt_storms_info$Storm_ID, "MaxDis" ] <- max( stormdata$Discharge )
  filt_storms_info[ ID == filt_storms_info$Storm_ID, "MinMax_SpCond" ] <-
      max(stormdata$SpCond_uScm) - min(stormdata$SpCond_uScm)
  filt_storms_info[ ID == filt_storms_info$Storm_ID, "yday" ] <- unique(yday(stormdata$Storm_ID))[1]
}

rm(stormdata, ID)

write_csv(B1,"B1_WQ.csv")
write_csv(filt_storms_info,"filt_storms_info.csv")