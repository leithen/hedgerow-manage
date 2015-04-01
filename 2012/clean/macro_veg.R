## **************************************************
rm(list=ls())
## setwd('~/Dropbox/occupancy')
source('src/misc.R')
cat('2012/clean/macro_veg.R\n')

dd <- read.csv('original/2012/macro_veg.csv')

n.entries <- dim(dd)[1]
 
## **************************************************
## Site
Site <- as.character(dd$Site)
Site[Site=='Beeman'] <- 'BC2'
Site[Site=='BeemanControl'] <- 'BC2'
Site[Site=='CR101C'] <- 'CR101Control'
Site[Site=='FongW'] <- 'FongWest'
Site[Site=='Hayes'] <- 'Hays'
Site[Site=='MullerC'] <- 'MullerControl'
Site[Site=='MullerControl'] <- 'MC1'
Site[Site=='ReddingtonSlough'] <- 'RSlough'
Site[Site=='Rlong'] <- 'RLong'
id(Site)

## **************************************************
## Date
Date <- as.character(dd$Date)
id(Date)

## **************************************************
## Transect
Transect <- as.numeric(dd$Transect)
id(Transect)

## **************************************************
## WEEDS_near
WEEDS_near <- as.numeric(dd$WEEDS_near)
WEEDS_near[is.na(WEEDS_near)] <- 0
id(WEEDS_near)

## **************************************************
## WEEDS_middle
WEEDS_middle <- as.numeric(dd$WEEDS_middle)
WEEDS_middle[is.na(WEEDS_middle)] <- 0
id(WEEDS_middle)

## **************************************************
## WEEDS_far
WEEDS_far <- as.numeric(dd$WEEDS_far)
WEEDS_far[is.na(WEEDS_far)] <- 0
id(WEEDS_far)

## **************************************************
## SHRUBS_near
SHRUBS_near <- as.numeric(dd$SHRUBS_near)
SHRUBS_near[is.na(SHRUBS_near)] <- 0
id(SHRUBS_near)

## **************************************************
## SHRUBS_middle
SHRUBS_middle <- as.numeric(dd$SHRUBS_middle)
SHRUBS_middle[is.na(SHRUBS_middle)] <- 0
id(SHRUBS_middle)

## **************************************************
## SHRUBS_far
SHRUBS_far <- as.numeric(dd$SHRUBS_far)
SHRUBS_far[is.na(SHRUBS_far)] <- 0
id(SHRUBS_far)

## **************************************************
## Width
Width <- as.numeric(dd$Width)
id(Width)

## **************************************************
## Plants
p <- as.character(dd$Plants)
non.empty <- which(p!='')
p <- p[non.empty]
p.split <- lapply(p, strsplit, split=';')
p.split <- sapply(p.split, as.vector)

## replace.6 <- function(x, a) {
##   x[x==a] <- paste(substr(a, 1, 3), substr(a, 4, 6), sep='_')
##   x
## }

## list.6 <- c('ACENEG', 'AESCAL', 'ARUDON', 'ATRLEN', 'BACPIL',
##             'BACPUS', 'BACSAL', 'BUDDAV', 'CEPOCC', 'CEROCC',
##             'CISPUR', 'ELAANG', 'ERIFAS', 'GRIHIR', 'HETARB',
##             'JUGNIG', 'LAVOFF', 'MHURIG', 'NICGLA', 'POPFRE',
##             'PRUILI', 'PUNGRA', 'QUELOB', 'RHACAL', 'RHATOM',
##             'ROSCAL', 'SALLEU', 'SALNIG', 'SAMMEX')

## for(s in list.6) p.split <- sapply(p.split, replace.6, a=s)

## replace <- function(x, a, b) {
##   x[x==a] <- b
##   x
## }

## p.split <- lapply(p.split, function(x)
##                   replace(x, a='PRUNUS', b='PRU_SP'))
## p.split <- lapply(p.split, function(x)
##                   replace(x, a='LUPINE_SP', b='LUP_SP'))
## p.split <- lapply(p.split, function(x)
##                   replace(x, a='SALVIA_SP', b='SAL_SP'))
## p.split <- lapply(p.split, function(x)
##                   replace(x, a='MALVA_SP', b='MAL_SP'))
## p.split <- lapply(p.split, function(x)
##                   replace(x, a='SAPONA_SP', b='SAP_SP'))
## p.split <- lapply(p.split, function(x)
##                   replace(x, a='POP_NARROWLEAF', b='POP_SP'))
## p.split <- lapply(p.split, function(x)
##                   replace(x, a='ALMOND_TREE', b='PRU_SP'))
## p.split <- lapply(p.split, function(x)
##                   replace(x, a='PEACH_TREE', b='PRU_SP'))

tmp <- rep('', n.entries)
tmp[non.empty] <- p.split
Plants <- tmp

## **************************************************
## FinalPlantSp

## load plant codes
plant.codes <- read.csv('original/misc/plant_id.csv')
field.id <- as.character(plant.codes$FieldID)

replace <- function(x) {
  if(length(x)==0) return('')
  plant.codes$FullName[match(x, field.id)]
}
FinalPlantSp <- lapply(Plants, replace)

## check which plant codes we don't have 
codes <- as.character(plant.codes$FieldID)
IDs.in.data <- id(unlist(Plants))
IDs.in.data[is.na(sapply(IDs.in.data, function(x) match(x, codes)))]

## *******************************************************
## make new dataset

Plants <- unlist(lapply(Plants,
                        function(x) paste(x, collapse=';')))
FinalPlantSp <- unlist(lapply(FinalPlantSp,
                              function(x) paste(x, collapse=';')))
FinalPlantSp[which(FinalPlantSp=='NA')] <- ''


d <- data.frame(site=Site,
                date=Date,
                transect=Transect,
                weeds.near=WEEDS_near,
                weeds.mid=WEEDS_middle,
                weeds.far=WEEDS_far,
                shrubs.near=SHRUBS_near,
                shrubs.mid=SHRUBS_middle,
                shrubs.far=SHRUBS_far,
                width=Width,
                plants=Plants,
                final.plant.sp=FinalPlantSp)

write.csv(d, 'my_data/2012/cleaned/macro_veg.csv',
          row.names=FALSE)

## ## make dataset which lists all plants present at each site
## d.orig <- read.csv('my_data/2012/cleaned/macro_veg.csv')
## plants.by.site <- split(d$final.plant.sp, d$site)
## sites <- names(plants.by.site)
## f <- function(x) {
##   if(all(x=='NA')) return(NA)
##   x <- x[x!='NA']
##   paste(x, collapse=';')
## }
## plants <- sapply(plants.by.site, f)
## plants <- lapply(plants, strsplit, split=';')
## plants <- lapply(plants, function(x) sort(unique((x[[1]]))))
## d <- cbind(rep(sites, sapply(plants, length)),
##            unlist(plants))
## rownames(d) <- NULL
## colnames(d) <- c('site', 'final.plant.sp')
## write.csv(d, 'my_data/2012/cleaned/plants_by_site.csv',
##           row.names=FALSE)
