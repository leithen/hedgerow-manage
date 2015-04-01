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

data.dir <- 'original/gis'
projection <- CRS('+proj=utm +zone=10 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0')

## ************************************************************
## hedgerow layers
##
dir <- file.path(data.dir, 'hedgerows')
dd.h <- readOGR(file.path(dir, 'Merge2006_2012.shp'),
                'Merge2006_2012') 
## update projection to make consistent with spraying layer
dd.h <- spTransform(dd.h, projection)

## check for valid GIS structure
gIsValid(dd.h)

## drop un-needed columns
dd.h <- dd.h[,'Name',drop=FALSE]
names(dd.h) <- 'site'

## fix site names
## dd.h$site <- tolower(dd.h$site)
## dd.h <- dd.h[-which(dd.h$site=='sperandio3?'),]
dd.h$site <- fix.white.space(dd.h$site)
## dd.h$site <- gsub(' ', '', dd.h$site)
## dd.h$site <- sapply(dd.h$site, function(s) substr(s, 1, nchar(s)-1))
dd.h$site[dd.h$site=='BeemanControl1'] <- 'BC1'
dd.h$site[dd.h$site=='BeemanControl2'] <- 'BC2'
dd.h$site[dd.h$site=='HrdyControl'] <- 'HC1'
dd.h$site[dd.h$site=='MullerBACI'] <- 'MullerB'
dd.h$site[dd.h$site=='MullerControl'] <- 'MC1'
dd.h$site[dd.h$site=='Rlong'] <- 'RLong'
drop <- c('Martinez', 'PutahCreek', 'PutahCreekForb', 'RSlough')
dd.h <- dd.h[-which(dd.h$site %in% drop),]

## drop duplicate hedgrows
drop <- c(which(dd.h@data$site=='Gregory')[2],
          which(dd.h@data$site=='USS')[2])
dd.h <- dd.h[-drop,]

save(dd.h, file=file.path('my_data/gis',
             'hedgerows.RData'))
save(dd.h, file=file.path('~/Dropbox/hedgerow/data_sets/gis',
             'hedgerows.RData'))

wd <- getwd()
setwd('my_data/gis/hedgerows')
file.remove(list.files())
writeOGR(obj=dd.h,
         dsn='.',
         layer='field_boundaries',
         driver='ESRI Shapefile')
setwd(wd)

wd <- getwd()
setwd('~/Dropbox/hedgerow/data_sets/gis/hedgerows')
file.remove(list.files())
writeOGR(obj=dd.h,
         dsn='.',
         layer='field_boundaries',
         driver='ESRI Shapefile')
setwd(wd)
## ************************************************************
