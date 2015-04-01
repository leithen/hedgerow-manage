## **************************************************
rm(list=ls())
source('src/misc.R')
cat('2013/clean/veg.R\n')

dd.1 <- read.csv('original/2013/veg/1.csv')
dd.2 <- read.csv('original/2013/veg/2.csv')
dd <- rbind(dd.1, dd.2)

## **************************************************
## Site
Site <- fix.white.space(as.character(dd$Site))
Site[Site=='BeemanControl'] <- 'BC2'
Site[Site=='MullerControl'] <- 'MC1'
Site[Site=='ReddingtonSlough'] <- 'RSlough'
dd$Site <- Site

## **************************************************
## Date
dd$Date <- as.character(dd$Date)

## **************************************************
## make syd keys
dd$syd <- make.keys(sites=dd$Site, dates=dd$Date)

## **************************************************
## make a new Transect ID
dd$TransectID <- paste(dd$Site, dd$Date,
                       paste(dd$Position, dd$Quad, sep='-'), sep=';')

## **************************************************
## CoverScore
dd$CoverScore <- gsub('<', '', dd$CoverScore)
dd$CoverScore <- gsub('% ', ';', dd$CoverScore)

## for consistency with earlier years
dd$Quad <- paste(dd$Position, dd$Quad, sep='-')

## **************************************************
## write new dataset
keep <- c('Site', 'Date', 'Quad', 'TransectID',
          'CoverScore', 'syd')
write.csv(dd[,keep], file='my_data/2013/cleaned/veg.csv',
          row.names=FALSE)
