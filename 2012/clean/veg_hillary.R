## **************************************************
rm(list=ls())
setwd('~/Dropbox/occupancy')
source('data/src/misc.R')
cat('2012/clean/veg_hillary.R\n')

dd <- read.csv('data/original/2012/veg_hillary.csv')
dd <- dd[!dd$Site %in% c('HC', 'Windmill'),]
names(dd)[names(dd)=='Flower.species..and..'] <- 'FieldID'
names(dd)[names(dd)=='Distance..m.'] <- 'Distance'

## **************************************************
## Site
Site <- as.character(dd$Site)
Site[Site=='MullerControl'] <- 'MC1'
dd$Site <- Site

## **************************************************
## Date

dd$Date[dd$Site=='Turkovich' & dd$Date=='2012-05-18'] <- '2012-05-19'
needed <- c('Barger;2012-06-06',
            'Barn;2012-05-27',
            'CircleG;2012-06-06',
            'FongWest;2012-05-21',
            'Hrdy;2012-06-01',
            'Joe;2012-06-01',
            'MC1;2012-05-21',
            'MullerM;2012-05-30',
            'Rominger;2012-05-19',
            'Tractor;2012-05-27',
            'Turkovich;2012-05-19',
            'Zamora;2012-05-30')
dd <- dd[paste(dd$Site, dd$Date, sep=';') %in% needed,]

dd$Year <- 2012
dd$JulianDate <- strptime(dd$Date, '%Y-%m-%d')$yday+1
## **************************************************

## **************************************************
## Plants
pp <- tolower(as.character(dd$FieldID))
pp[pp=='none'] <- NA
pp <- gsub(',', '', pp)
pp <- gsub('%', ';', pp)
pp <- gsub('; ', ';', pp)
pp <- gsub('ach mil', 'achmil', pp)
pp <- gsub('atr tri', 'atrtri', pp)
pp <- gsub('birdweed', 'lotcor', pp)
pp <- gsub('bra sp', 'brasp', pp)
pp <- gsub('con arv', 'conarv', pp)
pp <- gsub('ero sp', 'erocic', pp)
pp <- gsub('fuzzyunk', 'UNKNOWN', pp)
pp <- gsub('fillary', 'erocic', pp)
pp <- gsub('lep ', 'leplat ', pp)
pp <- gsub('tri sp', 'trisp', pp)
pp <- gsub('malneg1', 'malneg 1', pp)
pp <- gsub('malneg5', 'malneg 5', pp)
pp <- gsub('polarg', 'polare', pp)
pp <- gsub('cardus', 'carpyc', pp)
pp <- gsub('conlarv2', 'conarv 2', pp)
pp <- gsub('conarv8', 'conarv 8', pp)
pp <- gsub('conarv20', 'conarv 20', pp)
pp <- gsub('malneg5', 'malneg 5', pp)

non.empty <- which(!is.na(pp))
lengths <- rep(1, nrow(dd))
plants.split <- sapply(pp, strsplit, split=';')
lengths <- as.numeric(sapply(plants.split, length))

plant.codes <- as.vector(unlist(plants.split))
## ,
##                                 function(x)
##                                 strsplit(x, split=' ')[[1]][[1]]))
dd <- dd[rep(1:nrow(dd), lengths),]
dd$FieldID <- plant.codes
dd$FloralScore <- rep(NA, nrow(dd))
non.empty <- which(!is.na(dd$FieldID))
dd$FloralScore[non.empty] <-
  as.numeric(sapply(dd$FieldID[non.empty],
                    function(x) strsplit(x, ' ')[[1]])[2,])
dd$FieldID[non.empty] <-
  sapply(dd$FieldID[non.empty],
         function(x) strsplit(x, ' ')[[1]])[1,]
dd <- dd[-which(dd$FieldID=='UNKNOWN'),]

## fill in full plant names
plant.codes <- read.csv('data/original/misc/plant_id.csv')
plant <- dd$FieldID
ind <- which(!is.na(plant))

plant[ind] <-
  as.character(plant.codes$FullName[match(toupper(plant[ind]),
                                          plant.codes$FieldID)])
plant[is.na(plant)] <- ''
dd$FinalPlantSp <- plant
## *******************************************************

## *******************************************************
## write new dataset
keep <- c('Site', 'TentQuad', 'Row', 'Distance',
          'Date', 'Year', 'JulianDate', 'FinalPlantSp', 'FloralScore')
write.csv(dd[,keep], 'data/my_data/2012/cleaned/veg_hillary.csv',
          row.names=FALSE)
