rm(list=ls())
source('src/misc.R')
cat('2014/clean/specimen.R\n')

## **************************************************
## load files and change to correct format (e.g., one entry per row)
files <- list.files('original/2014/specimen')

## for more than 1 data-file:
loaded <- lapply(files, function(x)
                 read.csv(file.path('original/2014/specimen', x),
                          as.is=TRUE))

if(any(sapply(loaded, function(x) any(names(x)!=names(loaded[[1]])))))
  cat('ERROR in 2014/specimen.R\n')
d.orig <- do.call(rbind, loaded)

## d.orig <- read.csv('original/2014/specimen/1.csv', as.is=TRUE)

names(d.orig)
if(any(!d.orig$Last >= d.orig$First))
  cat('Error: An entry in the \'last\' column is less than an entry in \'first\' column\n')

tempIDs <- unlist(mapply(function(a,b) a:b,
                         a=d.orig$First, b=d.orig$Last))
if(any(table(tempIDs)>1)) {
  cat('Error: Duplicate tempIDs found\n')
  print(table(tempIDs)[table(tempIDs)>1])
}

## d.orig$Last[!d.orig$Last >= d.orig$First]
## d.orig$First[!d.orig$Last >= d.orig$First]

d.orig$num <- d.orig$Last - d.orig$First + 1
ind <- unlist(sapply(1:nrow(d.orig),
                     function(x) rep(x, d.orig$num[x])))
d.new <- d.orig[ind,]
rownames(d.new) <- NULL
d.new$TempID <- unlist(mapply(function(a, b)
                              a:b, a=d.orig$First, b=d.orig$Last))
d.new <- d.new[,c('TempID', 'Site', 'Date', 'NetPan', 'PanColor',
                  'PanNumber', 'Collector', 'PlantSp')]
d.orig <- d.new
n.entries <- nrow(d.orig)
## **************************************************

## **************************************************
## TempID
TempID <- d.orig$TempID

## **************************************************
## Site
Site <- d.orig$Site
Site <- as.character(Site)
Site[Site=='Beeman'] <- 'BC2'
Site[Site=='Beeman Control'] <- 'BC2'
Site[Site=='CR101C'] <- 'CR101Control'
Site[Site=='FongW'] <- 'FongWest'
Site[Site=='MullerC'] <- 'MullerControl'
Site[Site=='MullerControl'] <- 'MC1'
Site[Site==''] <- ''
id(Site)

## **************************************************
## Date
Date <- d.orig$Date
Date <- as.character(Date)
id(Date)

## **************************************************
## Collector
Collector <- d.orig$Collector
Collector <- as.character(Collector)
Collector[Collector=='AP']       <- 'A. Peterson'
Collector[Collector=='CK']       <- 'C. Kremen'
Collector[Collector=='CV']       <- 'C. Vasquez'
Collector[Collector=='CV/SP']    <- 'S. Powell/C. Vasquez'
Collector[Collector=='CV/KC/KD'] <- 'K. Cutler/K. Dickerson/C. Vasquez'
Collector[Collector=='JDS']      <- 'J. Spann'
Collector[Collector=='KC']       <- 'K. Cutler'
Collector[Collector=='KC/GD']    <- 'K. Cutler/G. Dukhovney'
Collector[Collector=='KC/MV']    <- 'K. Cutler/M. Villa'
Collector[Collector=='KD']       <- 'K. Dickerson'
Collector[Collector=='LCP']      <- 'L. Ponisio'
Collector[Collector=='LKM']      <- "L. M'Gonigle"
Collector[Collector=='LMH']      <- 'L. Hack'
Collector[Collector=='LMH/KC']   <- 'K. Cutler/L. Hack'
Collector[Collector=='KC/SP']    <- 'K. Cutler/S. Powell'
Collector[Collector=='LMH/MV']   <- 'L. Hack/M. Villa'
Collector[Collector=='MV']       <- 'M. Villa'
Collector[Collector=='MV/TMF']   <- 'T. Fowles/M. Villa'
Collector[Collector=='TMF']      <- 'T. Fowles'
Collector[Collector=='TMF/JDS']  <- 'T. Fowles/J. Spann'
Collector[Collector=='TMF/LKM']  <- "T. Fowles/L. M'Gonigle"
Collector[Collector=='TMF/MV']   <- 'T. Fowles/M. Villa'
id(Collector)

## **************************************************
## NetPan
NetPan <- d.orig$NetPan
id(NetPan)

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
id(PanNumber[NetPan=='pan'])

## **************************************************
## NetNumber
NetNumber <- rep(NA, n.entries)

## **************************************************
## PlantSp
PlantSp <- d.orig$PlantSp
PlantSp <- toupper(fix.white.space(PlantSp))
PlantSp[PlantSp=='ALYMAR'] <- 'LOBMAR'
PlantSp[PlantSp=='BRASPP'] <- 'BRASP'
PlantSp[PlantSp=='CALMAC'] <- 'CALPUR'
PlantSp[PlantSp=='CEANOTHUS SP'] <- 'CEASP'
PlantSp[PlantSp=='LASSP'] <- 'ERILAN'
PlantSp[PlantSp=='Lasthenia sp'] <- 'LASSP'
PlantSp[PlantSp=='LAVANG'] <- 'LAVOFF'
PlantSp[PlantSp=='LUPINUS_SP'] <- 'LUPSP'
PlantSp[PlantSp=='PENSTEMON_SP'] <- 'PENSP'
PlantSp[PlantSp=='RANUNCULUS_SP'] <- 'RANSP'
PlantSp[PlantSp=='SALSPP'] <- 'SALSP'
PlantSp[PlantSp=='SALVIA_SP'] <- 'SALSP'
PlantSp[PlantSp=='SONCHUS SP'] <- 'SONSP'
PlantSp[PlantSp=='SONSPP'] <- 'SONSP'
PlantSp[PlantSp=='VICIA_SP'] <- 'VICSP'
## PlantSp[PlantSp==''] <- ''
id(PlantSp)

## **************************************************
## FinalPlantSp

## load plant codes
plant.codes <- read.csv('original/misc/plant_id.csv')

field.id <- as.character(plant.codes$FieldID)

FinalPlantSp <- rep('', n.entries)
ind <- NetPan=='net'

FinalPlantSp[ind] <-
  as.character(plant.codes$FullName[match(PlantSp[ind], field.id)])

## check which plant codes we don't have 
IDs.in.data <- id(PlantSp[NetPan=='net'])
codes <- as.character(plant.codes$FieldID)
IDs.in.data[is.na(sapply(IDs.in.data, function(x) match(x, codes)))]

## **************************************************
## Notes 
Notes <- rep('', nrow(d.orig))

## **************************************************
## UniqueID
date <- as.Date(Date, format='%Y-%m-%d')
year <- as.character(as.numeric(format(date, format = '%Y')))
month <- format(date, format = '%m')
day <- format(date, format = '%d')

UniqueID <- sprintf('EMEC_HR_%s_%d', year, TempID)

## *******************************************************
## make new dataset
data <- data.frame(UniqueID,
                   TempID,
                   Site,
                   Date,
                   NetPan,
                   PanColor,
                   PanNumber,
                   NetNumber,
                   Collector,
                   PlantSp,
                   FinalPlantSp,
                   Notes,
                   BeeNonbee=rep('', n.entries),
                   GeneralID=rep('', n.entries),
                   Order=rep('', n.entries),
                   Family=rep('', n.entries),
                   Genus=rep('', n.entries),
                   SubGenus=rep('', n.entries),
                   Species=rep('', n.entries),
                   SubSpecies=rep('', n.entries),
                   Sex=rep('', n.entries),
                   Determiner=rep('', n.entries))

write.csv(data, file='my_data/2014/cleaned/specimen.csv',
          row.names=FALSE)
