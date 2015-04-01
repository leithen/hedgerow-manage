## ************************************************************
## clean up GIS layers by dropping problematic polygons
rm(list=ls())
setwd('~/Dropbox/occupancy/data')
source('src/misc.R')
library(maptools)
library(rgdal)
library(rgeos)
library(spatstat)
## ************************************************************

## ************************************************************
dd.spray <- read.csv('my_data/spraying/records.csv', as.is=TRUE)

merge.within.year <- function(year) {
  ## reduce size of dd.spray to speed things up
  dd.spray <- dd.spray[dd.spray$Year==year,]

  data.dir <- 'my_data/gis/spraying/field_boundaries_by_yr'
  load(file.path(data.dir, sprintf('%d.RData', year)))

  ## merge polygons that contain the same identifying data
  merge.key <- paste(dd@data$permit_yr,
                     dd@data$permit_num,
                     dd@data$site_id, sep=';')
  dd.by.key <- unionSpatialPolygons(dd, merge.key)

  ## construct new attributes table
  rows <- match(names(dd.by.key), merge.key)
  cols <- c('permit_yr', 'permit_num', 'site_id')
  attr.table <- as.data.frame(dd@data[rows, cols])
  row.names(attr.table) <- names(dd.by.key)
  ## convert all to lower case
  attr.table$permit_num <- tolower(attr.table$permit_num)
  attr.table$site_id    <- tolower(attr.table$site_id)
  ## create new key
  attr.table$key <- paste(attr.table$permit_yr,
                          attr.table$permit_num,
                          attr.table$site_id, sep=';')

  ## create new SpatialPolygonsDataFrame
  dd.new <- SpatialPolygonsDataFrame(Sr=dd.by.key,
                                     data=attr.table)
  
  ## add in crops
  dd.spray <- dd.spray[dd.spray$key %in% dd.new@data$key,]

  ## function to create crop list for each key
  get.crops.sprayed <- function(key) {
    crops <- id(dd.spray$Commodity[dd.spray$key==key])
    if(length(crops)==0) return('')
    paste(crops, collapse=';')
  }
  dd.new@data$crops <- sapply(dd.new@data$key, get.crops.sprayed)

  dd.new
}
dd.by.year <- lapply(2006:2013, merge.within.year)
dd.s <- do.call(rbind, dd.by.year)
save(dd.s, file='my_data/gis/spraying/field_boundaries.RData')

## setwd('my_data/gis/field_boundaries')
## file.remove(list.files())
## writeOGR(obj=dd.s,
##          dsn='.',
##          layer='field_boundaries',
##          driver='ESRI Shapefile')
## ************************************************************
