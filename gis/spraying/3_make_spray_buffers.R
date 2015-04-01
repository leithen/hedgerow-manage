## ******************************
rm(list=ls())
setwd('~/Dropbox/occupancy/data')
source('src/misc.R')
library(maptools)
library(rgdal)
library(rgeos)
library(parallel)
dir <- 'my_data/gis'
## ******************************

## ******************************
## load spray shape file
load('my_data/gis/spraying/field_boundaries.RData')

## dissolve by key and make new spatial data.frame
dd.by.key <- unionSpatialPolygons(dd.s, dd.s$key)
attr.table <- as.data.frame(dd.s[match(names(dd.by.key), dd.s$key),
                                 c('permit_yr', 
                                   'permit_num', 'site_id', 'key')])
row.names(attr.table) <- names(dd.by.key)
dd.s <- SpatialPolygonsDataFrame(Sr=dd.by.key, data=attr.table)
## ******************************

## ******************************
## load hedgerow shape file
load('my_data/gis/hedgerows.RData')

## make site points for hedgerows
site.pts <- SpatialLinesMidPoints(dd.h)
names(site.pts@data)[1] <- 'Site'
## ******************************

## ******************************
## make and save distance tables
make.distance.table <- function(year, radii, num.cores) {
  dd.s <- dd.s[dd.s$permit_yr==year,]
  cat(sprintf('Year %d contains %d elements\n', year, nrow(dd.s)))

  ## subset immediately to speed things up later
  max.buff <- gBuffer(site.pts, width=max(radii), quadsegs=20)
  dd.s <- gIntersection(dd.s, max.buff, byid=TRUE)

  get.for.site <- function(ss) {
    cat(sprintf('%s\n', ss))
    site.pt <- site.pts[site.pts$Site==ss,]

    ## subset again to speed things up later
    max.buff <- gBuffer(site.pt, width=max(radii), quadsegs=20)
    dd.s <- gIntersection(dd.s, max.buff, byid=TRUE)
    
    get.dists.areas <- function(radius) {
      cat(sprintf('%d\n', radius))
      
      disc.buff <- gBuffer(site.pt, width=radius, quadsegs=20)
      dd.s.sub <- gIntersection(dd.s, disc.buff, byid=TRUE)
      if(is.null(dd.s.sub)) return(NA)
      
      keys <- sapply(dd.s.sub@polygons, function(x) x@ID)
      keys <- gsub(' buffer', '', keys)
      dists <- sapply(1:length(keys),
                      function(i) gDistance(site.pt, dd.s.sub[i,]))
      areas <- sapply(dd.s.sub@polygons, function(x) x@area)

      ## create data structure to return
      data.frame(key=keys,
                 distance=dists,
                 area=areas,
                 site=ss,
                 year=year)
    }

    res <- lapply(radii, get.dists.areas)
    names(res) <- radii
    res
  }

  ## create list of areas for each site
  site.ids <- site.pts$Site
  if(num.cores==1)
    dist.tables <- lapply(site.ids, get.for.site)
  if(num.cores>1)
    dist.tables <- mclapply(site.ids, get.for.site,
                            mc.preschedule=FALSE,
                            mc.cores=num.cores)
  names(dist.tables) <- site.ids

  ## save file
  fn <- sprintf('my_data/spraying/dist.tables/%d.RData', year)
  save(dist.tables, file=fn)
}

radii <- round(exp(seq(from=log(100), to=log(10000), length=9)))
for(year in 2006:2013)
  make.distance.table(year=year, radii=radii, num.cores=1)


git remote add origin https://github.com/leithen/manage.git
