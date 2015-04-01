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

data.dir <- 'original/gis/spraying'
save.dir <- 'my_data/gis/spraying'
projection <- CRS('+proj=utm +zone=10 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0')

## ************************************************************
## spraying layers
load.gis <- function(year.path, fn) {
  dd <- readOGR(file.path(data.dir,
                          year.path,
                          sprintf('%s.shp', fn)), fn)
  ## this fixes some discrepancies in the shape-file
  dd <- gBuffer(dd, width=0, byid=TRUE)
  ## change projection to make all consistent
  dd <- spTransform(dd, projection)
  ## check for valid GIS structure
  if(gIsValid(dd)) cat('Valid GIS Layer loaded\n')
  dd
}
  
clean.gis <- function(year) {
  if(year<=2008)
    cols.keep <- c('PERMIT',
                   'SITEID',
                   'COMMODITY')
  if(2008<year & year<=2013)
    cols.keep <- c('permit_num',
                   'site_id',
                   'crop_list',
                   'permit_yr')
  
  dd@data <- dd@data[,cols.keep]
  if(year<2009) dd@data$permit_yr <- rep(year, nrow(dd@data))
  colnames(dd@data) <- c('permit_num', 
                         'site_id',
                         'crop',
                         'permit_yr')
  dd <- dd[dd@data$permit_yr==year,]

  ## drop sites that are missing permit_num or site_id
  keep <- apply(dd@data[,c('permit_num', 'site_id')], 1,
                function(x) !any(is.na(x)))
  dd <- dd[keep,]
  dd <- dd[dd@data$site_id!='New',]
  
  save(dd, file=file.path(save.dir,
             'field_boundaries_by_yr',
             sprintf('%s.RData', year)))
  NULL
}

## 2006
dd <- load.gis(year.path='2006', fn='Field_Borders_NAD_Meters_101106')
clean.gis(year=2006)

## 2007
dd <- load.gis(year.path='2007', fn='fieldborders_nad83_meters9507')
clean.gis(year=2007)

## 2008
dd <- load.gis(year.path='2008', fn='fbnad83mtr_91108')
clean.gis(year=2008)

## 2009-2013
dd <- load.gis(year.path='2009-2014', fn='field_boundaries_57')
sapply(2009:2013, clean.gis)
## ************************************************************
