rm(list=ls())
source('src/misc.R')
cat('2012/clean/honeybee.R\n')

## **************************************************
d.orig <- read.csv('original/2012/honeybee.csv')
n.entries <- dim(d.orig)[1]

## **************************************************
## Site
Site <- d.orig$Site
Site <- as.character(Site)
## to do at end of year:
Site[Site=='martinez'] <- 'Martinez'
Site[Site=='hays'] <- 'Hays'
Site[Site=='Hayes'] <- 'Hays'
Site[Site=='martinez'] <- 'Martinez'
Site[Site=='CR101C'] <- 'CR101Control'
Site[Site=='FongW'] <- 'FongWest'
Site[Site=='ReddingtonSlough'] <- 'RSlough'
Site[Site=='Beeman'] <- 'BC2'
Site[Site=='BeemanControl'] <- 'BC2'
Site[Site=='MullerControl'] <- 'MC1'

## **************************************************
## Date
Date <- d.orig$Date
Date <- as.character(Date)

## **************************************************
## Collector
Collector <- d.orig$Collector
Collector <- as.character(Collector)
Collector[Collector=='R.Jaffe'] <- 'R. Jaffe'
Collector[Collector=='R.Hanifin'] <- 'R. Hanifin'
Collector[Collector=='A.Hernandez'] <- 'A. Hernandez'
Collector[Collector=='J.Dorcy'] <- 'J. Dorcy'
Collector[Collector=='K.Cutler'] <- 'K. Cutler'

## **************************************************
## NetPan
NetPan <- d.orig$NetPan

## **************************************************
## PanColor
PanColor <- d.orig$PanColor
PanColor <- as.character(PanColor)
id(PanColor[NetPan=='pan'])

## **************************************************
## PanNumber
PanNumber <- d.orig$PanNumber
PanNumber <- as.character(PanNumber)
PanNumber[is.na(PanNumber)] <- ''

## **************************************************
## NetNumber
NetNumber <- d.orig$NetNumber
NetNumber <- as.character(NetNumber)
NetNumber[is.na(NetNumber)] <- ''

## **************************************************
## BeeCount
BeeCount <- d.orig$BeeCount
BeeCount

## **************************************************
## PlantSp
PlantSp <- d.orig$PlantSp
PlantSp <- fix.white.space(PlantSp)
p.1 <- sapply(strsplit(PlantSp, ' '), length) > 1
PlantSp[p.1] <- sapply(strsplit(PlantSp[p.1], ' '), function(x)
                       paste(x[1], x[2], sep='_'))

## PlantSp[PlantSp=='NA_NA'] <- ''

## ## **************************************************
## ## FinalPlantSp

## ## load plant codes
## plant.codes <- read.csv('original/2012/plant_names.csv')
## field.id <- as.character(plant.codes$FieldID)

## ## check which plant codes we don't have 
## IDs.in.data <- id(PlantSp[NetPan=='net'])
## codes <- as.character(plant.codes$FieldID)
## IDs.in.data[is.na(sapply(IDs.in.data, function(x) match(x, codes)))]

## FinalPlantSp <- rep('', n.entries)
## ind <- NetPan=='net'
## FinalPlantSp[ind] <-
##   as.character(plant.codes$FullName[match(PlantSp[ind], field.id)])

## ## **************************************************
## ## Notes 
## ## Notes <- d.orig$Notes
## Notes <- rep('', nrow(d.orig))


## fill in stuff that is easy for honeybees


## ## **************************************************
## ## UniqueID
## UniqueID <- rep('', n.entries)

## ## **************************************************
## ## TempID
## TempID <- rep('', n.entries)

## ## **************************************************
## ## BeeNonbee
## BeeNonbee <- rep('bee', n.entries)

## ## **************************************************
## ## GeneralID
## GeneralID <- rep('honeybee', n.entries)

## ## **************************************************
## ## Order
## Order <- rep('Hymenoptera', n.entries)
## Family <- rep('Apidae', n.entries)
## Genus <- rep('Apis', n.entries)
## SubGenus <- rep('', n.entries)
## Species <- rep('mellifera', n.entries)
## SubSpecies <- rep('', n.entries)

## ## **************************************************
## ## Sex
## Sex <- rep('f', n.entries)

## *******************************************************
## make new dataset
data <- data.frame(Site,
                   Date,
                   BeeCount,
                   NetPan,
                   PanColor,
                   PanNumber,
                   NetNumber,
                   Collector,
                   PlantSp)

write.csv(data, file='my_data/2012/cleaned/honeybee.csv',
          row.names=FALSE)
