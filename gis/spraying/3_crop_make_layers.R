## ****************************************
## making sunflower subset file
rm(list=ls())
setwd('~/Dropbox/occupancy/data')
source('src/misc.R')

library(rgdal)
library(maptools)

## first load spray data shape file
load('my_data/gis/spraying/field_boundaries.RData')

## save sunflower, for example
dd.sf <- dd.s[grep('SUNF', dd.s@data$crops),]
## check saved crops
unique(dd.sf$crops)

## dissolve within each year to get rid of overlaid polgyons
by.yr <- unionSpatialPolygons(dd.sf, dd.sf$permit_yr)
save(by.yr, file='my_data/gis/spraying/crop_layers/sunflower.RData')
## ************************************************************
