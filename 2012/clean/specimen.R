rm(list=ls())
source('src/misc.R')
cat('2012/clean/specimen.R\n')

## **************************************************
files <- list.files('original/2012/specimen')

loaded <- lapply(files, function(x)
                 read.csv(file.path('original/2012/specimen', x),
                          as.is=TRUE))
if(any(sapply(loaded, function(x) any(names(x)!=names(loaded[[1]])))))
  cat('ERROR in 2012/specimen.R\n')

d.orig <- do.call(rbind, loaded)
n.entries <- dim(d.orig)[1]

## **************************************************
## TempID
TempID <- d.orig$TempID

## **************************************************
## Site
Site <- d.orig$Site
Site <- as.character(Site)
Site[Site=='FongW'] <- 'FongWest'
Site[Site=='MullerC'] <- 'MullerControl'
Site[Site=='Rlong'] <- 'RLong'
Site[Site=='ReddingtonSlough'] <- 'RSlough'
Site[Site=='Beeman'] <- 'BC2'
Site[Site=='BeemanControl'] <- 'BC2'
Site[Site=='MullerControl'] <- 'MC1'
Site[Site=='CR101C'] <- 'CR101Control'
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
Collector[Collector=='A.Ellis'] <- 'A. Ellis'
Collector[Collector=='A.Hernandez'] <- 'A. Hernandez'
Collector[Collector=='A Hernandez'] <- 'A. Hernandez'
Collector[Collector=='C.Kremen'] <- 'C. Kremen'
Collector[Collector=='C Kremen'] <- 'C. Kremen'
Collector[Collector=='D.Baker'] <- 'D. Baker'
Collector[Collector=='D Baker'] <- 'D. Baker'
Collector[Collector=='H Sardinas'] <- 'H. Sardinas'
Collector[Collector=='J.Dorcy'] <- 'J. Dorcy'
Collector[Collector=='J Dorcy'] <- 'J. Dorcy'
Collector[Collector=='K.Calhoun'] <- 'K. Calhoun'
Collector[Collector=='K Calhoun'] <- 'K. Calhoun'
Collector[Collector=='K.Cutler'] <- 'K. Cutler'
Collector[Collector=='K Cutler'] <- 'K. Cutler'
Collector[Collector=='K.Nguyen'] <- 'K. Nguyen'
Collector[Collector=='K Nguyen'] <- 'K. Nguyen'
Collector[Collector=="L.M'gonigle"] <- "L. M'Gonigle"
Collector[Collector=="L.M'Gonigle"] <- "L. M'Gonigle"
Collector[Collector=="L M'Gonigle"] <- "L. M'Gonigle"
Collector[Collector=='R.Hanifin'] <- 'R. Hanifin'
Collector[Collector=='R Hanifin'] <- 'R. Hanifin'
Collector[Collector=='R.Jaffe'] <- 'R. Jaffe'
Collector[Collector=='R Jaffe'] <- 'R. Jaffe'
Collector[Collector=='T.Luttermoser'] <- 'T. Luttermoser'
Collector[Collector=='T Luttermoser'] <- 'T. Luttermoser'
Collector[Collector=='H.Sardinas'] <- 'H. Sardinas'
id(Collector)

## **************************************************
## NetPan
NetPan <- d.orig$NetPan
id(NetPan)

## **************************************************
## PanColor
PanColor <- d.orig$PanColor
PanColor <- as.character(PanColor)
PanColor[PanColor=='Y'] <- 'y'
id(PanColor[NetPan=='pan'])

## **************************************************
## PanNumber
PanNumber <- d.orig$PanNumber
PanNumber <- as.character(PanNumber)
PanNumber[is.na(PanNumber)] <- ''
id(PanNumber[NetPan=='pan'])

## **************************************************
## NetNumber
NetNumber <- d.orig$NetNumber
NetNumber <- as.character(NetNumber)
NetNumber[is.na(NetNumber)] <- ''
NetNumber[NetNumber=='?'] <- ''
id(NetNumber[NetPan=='net'])

## which(is.na(NetNumber) & NetPan=='net')

## **************************************************
## PlantSp
PlantSp <- d.orig$PlantSp
PlantSp <- fix.white.space(PlantSp)
PlantSp[PlantSp=='?'] <- ''
PlantSp[PlantSp=='NA'] <- ''
PlantSp[PlantSp=='ATR_LEP'] <- 'ATR_LEN'
PlantSp[PlantSp=='CIS_SKI'] <- 'CIS_SKA'
PlantSp[PlantSp=='ERO_CIR'] <- 'ERO_CIC'
PlantSp[PlantSp=='KM_AMV'] <- ''
PlantSp[PlantSp=='MALVASP'] <- 'MAL_SP'
PlantSp[PlantSp=='SALVIASP'] <- 'SAL_SP'
PlantSp[PlantSp=='UNK_SP'] <- ''
PlantSp[PlantSp=='WHITE?'] <- 'CRE_TRU'
id(PlantSp)
## PlantSp <- sapply(strsplit(PlantSp, ' '), function(x)
##                   paste(x[1], x[2], sep='_'))

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

write.csv(data, file='my_data/2012/cleaned/specimen.csv',
          row.names=FALSE)
