rm(list=ls())
source('src/misc.R')
cat('2013/clean/specimen.R\n')

## **************************************************
## load files and change to correct format (e.g., one entry per row)
files <- list.files('original/2013/specimen')

## for more than 1 data-file:
loaded <- lapply(files, function(x)
                 read.csv(file.path('original/2013/specimen', x),
                          as.is=TRUE))

if(any(sapply(loaded, function(x) any(names(x)!=names(loaded[[1]])))))
  cat('ERROR in 2013/specimen.R\n')
d.orig <- do.call(rbind, loaded)

names(d.orig)
if(any(!d.orig$Last >= d.orig$First))
  cat('Error: An entry in the \'last\' column is less than an entry in \'first\' column\n')

tempIDs <- unlist(mapply(function(a,b) a:b,
                         a=d.orig$First, b=d.orig$Last))
if(any(table(tempIDs)>1)) {
  cat('Error: Duplicate tempIDs found\n')
  print(table(tempIDs)[table(tempIDs)>1])
}

d.orig$Last[!d.orig$Last >= d.orig$First]
d.orig$First[!d.orig$Last >= d.orig$First]

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
Site[Site=='BermF'] <- 'BermForb'
Site[Site=='CR101C'] <- 'CR101Control'
Site[Site=='FongW'] <- 'FongWest'
Site[Site=='GilmerF'] <- 'GilmerForb'
Site[Site=='HRDY'] <- 'Hrdy'
Site[Site=='MullerC'] <- 'MullerControl'
Site[Site=='MullerControl'] <- 'MC1'
Site[Site=='Putah Creek'] <- 'PutahCreek'
Site[Site=='PutahForb'] <- 'PutahCreekForb'
Site[Site=='PutaForb'] <- 'PutahCreekForb'
Site[Site=='ReddingtonSlough'] <- 'RSlough'
Site[Site=='Rlong'] <- 'RLong'
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
Collector[Collector=='?']       <- ''
Collector[Collector=='N/A']     <- ''
Collector[Collector=='AD']      <- 'A. Drager'
Collector[Collector=='AD/BES']  <- 'A. Drager/B. Sostak'
Collector[Collector=='AD/KC']   <- 'K. Cutler/A. Drager'
Collector[Collector=='AD/MB']   <- 'A. Drager/M. Bennett'
Collector[Collector=='BES']     <- 'B. Sostak'
Collector[Collector=='BES/KC']  <- 'K. Cutler/B. Sostek'
Collector[Collector=='BES/LKM'] <- "L. M'Gonigle/B. Sostak"
Collector[Collector=='BES/RW']  <- 'B. Sostak/R. Waytes'
Collector[Collector=='BES/SH']  <- 'S. Hyson/B. Sostak'
Collector[Collector=='BES/SMH'] <- 'S. Hyson/B. Sostak'
Collector[Collector=='BS/KC']   <- 'K. Cutler/B. Sostek'
Collector[Collector=='BS/SH']   <- 'S. Hyson/B. Sostak'
Collector[Collector=='BS/SMH']  <- 'S. Hyson/B. Sostak'
Collector[Collector=='BS,TS']   <- 'B. Sostek/T. Sritongchuay'
Collector[Collector=='BES,TS']  <- 'B. Sostek/T. Sritongchuay'
Collector[Collector=='HS']      <- 'H. Sardinas'
Collector[Collector=='KC']      <- 'K. Cutler'
Collector[Collector=='KC,MB']   <- 'M. Bennett/K. Cutler'
Collector[Collector=='KC,NS']   <- 'K. Cutler/N. Solares'
Collector[Collector=='KC/MB']   <- 'M. Bennett/K. Cutler'
Collector[Collector=='KC/NS']   <- 'K. Cutler/N. Solares'
Collector[Collector=='KC/RW']   <- 'K. Cutler/R. Waytes'
Collector[Collector=='LKM']     <- "L. M'Gonigle"
Collector[Collector=='MB']      <- 'M. Bennett'
Collector[Collector=='MB,RW']   <- 'M. Bennett/R. Waytes'
Collector[Collector=='MB,SH']   <- 'M. Bennett/S. Hyson'
Collector[Collector=='MB/KC']   <- 'M. Bennett/K. Cutler'
Collector[Collector=='MB/RW']   <- 'M. Bennett/R. Waytes'
Collector[Collector=='NS']      <- 'N. Solares'
Collector[Collector=='NS/RW']   <- 'N. Solares/R. Waytes'
Collector[Collector=='RW']      <- 'R. Waytes'
Collector[Collector=='RW,NS']   <- 'N. Solares/R. Waytes'
Collector[Collector=='RW/MB']   <- 'M. Bennett/R. Waytes'
Collector[Collector=='RW/TS']   <- 'T. Sritongchuay/R. Waytes'
Collector[Collector=='SH']      <- 'S. Hyson'
Collector[Collector=='SH,MB']   <- 'M. Bennett/S. Hyson'
Collector[Collector=='SH/KC']   <- 'K. Cutler/S. Hyson'
Collector[Collector=='SMH']     <- 'S. Hyson'
Collector[Collector=='SMH/KC']  <- 'K. Cutler/S. Hyson'
Collector[Collector=='TS']      <- 'T. Sritongchuay'
Collector[Collector=='UNK']     <- '??'
id(Collector)

## **************************************************
## NetPan
NetPan <- d.orig$NetPan
id(NetPan)

## **************************************************
## PanColor
PanColor <- d.orig$PanColor
PanColor <- tolower(as.character(PanColor))
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
PlantSp <- fix.white.space(PlantSp)
PlantSp[PlantSp=='ALYMAR'] <- 'LOBMAR'
PlantSp[PlantSp=='CAMPANILA'] <- 'CAMSP'
PlantSp[PlantSp=='DATSTR'] <- 'DATWRI'
PlantSp[PlantSp=='ELAOLE'] <- 'ELAANG'
PlantSp[PlantSp=='ELA_OLE'] <- 'ELAANG'
PlantSp[PlantSp=='ERESET'] <- 'CRO_SET'
PlantSp[PlantSp=='LAYIASP'] <- 'LAYSP'
PlantSp[PlantSp=='LOBPAR'] <- 'LOBMAR'
PlantSp[PlantSp=='LUPINESP'] <- 'LUPSP'
PlantSp[PlantSp=='MELIND'] <- 'MELOFF'
PlantSp[PlantSp=='MALVASP'] <- 'MALSP'
PlantSp[PlantSp=='SALVIASP'] <- 'SALSP'
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

write.csv(data, file='my_data/2013/cleaned/specimen.csv',
          row.names=FALSE)


