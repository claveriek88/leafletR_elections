library('tmap')
library('leaflet')
#install.packages('rio')
library('rio')
library(plyr)

datafile <- "data/election.csv"
election <- rio::import(datafile)
mnshape <- "data/L2012-1.shp"
mngeo <- read_shape(file=mnshape)
qtm(mngeo)

str(mngeo@data$DISTRICT)


election$District <- 
  revalue(election$District,
          c("1A"="01A", "1B"="01B","2A"="02A", "2B"= "02B", "3A"="03A", "3B"= "03B",
            "4A"="04A", "4B"="04B", "5A"="05A", "5B"="05B", "6A"="06A", "6B"="06B",
            "7A"="07A", "7B"="07B", "8A"="08A", "8B"="08B", "9A"="09A", "9B"="09B"))

election$District
mngeo@data$DISTRICT <- as.character(mngeo@data$DISTRICT)

mnmap <- append_data(mngeo, election, key.shp = "DISTRICT", key.data="District")

qtm(mnmap, "DemBase")

mnPalette <- colorNumeric(palette = "RdYlBu", domain=mnmap$DemBase)

