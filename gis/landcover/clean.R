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

data.dir <- 'original/gis/landcover'
save.dir <- 'my_data/gis/landcover'
projection <- CRS('+proj=utm +zone=10 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0')

## ************************************************************
## spraying layers

clean.gis <- function(fn) {

  dd <- readOGR(file.path(data.dir, fn, sprintf('%s.shp', fn)), fn)
  ## the below fixes some discrepancies in shape-file
  dd = gBuffer(dd, width=0, byid=TRUE)

  ## change projection to make all consistent
  ## CRS(proj4string(dd))
  dd <- spTransform(dd, projection)

  ## simplify attributes table
  cols.keep <- c('LandCover')
  dd@data <- dd@data[,cols.keep,drop=FALSE]

  ## check for and/or drop all problem cases
  problem.cases <- as.vector(which(!gIsValid(dd, byid=TRUE)))
  if(length(problem.cases)>0) {
    cat(sprintf('%d problem polygons\n', length(problem.cases)))
    ## dd <- dd[-problem.cases,]
  }

  ## write to dropbox
  db.dir <- '~/Dropbox/hedgerow/data_sets/gis/landcover'
  save(dd, file=file.path(db.dir, sprintf('%s.RData', fn)))
  ## create ARC version
  wd <- getwd()
  setwd(file.path('~/Dropbox/hedgerow/data_sets/gis/landcover', fn))
  file.remove(list.files())
  writeOGR(obj=dd,
           dsn='.',
           layer='digitize2006',
           driver='ESRI Shapefile')
  setwd(wd)

  ## save to my_data
  save(dd, file=file.path(save.dir, sprintf('%s.RData', fn)))
  dd
}

dd.2006 <- clean.gis(fn='digitize2006')
dd.2012 <- clean.gis(fn='digitize2012')
## ************************************************************
