## *******************************************************
## make files for use in relational database
## *******************************************************
rm(list=ls())
cat('***2012/run_honeybee.R***\n')
source('src/misc.R')

## Honeybees

## *******************************************************
## create honeybee database

D <- read.csv('my_data/2006-2011/cleaned/honeybee.csv')
D <- data.frame(NetPan=D$net.pan,
                Site=D$site,
                SiteStatus=D$site.status,
                SampleRound=D$sample.round,
                Date=D$date,
                Sex=D$sex,
                Collector=D$collector,
                PanColor=D$pan.color,
                PanNumber=D$pan.number,
                NetNumber=D$net.number,
                FinalPlantSp=D$final.plant.sp,
                PanDistance=D$pan.distance,
                PanLocation=D$pan.location,
                PanOrientation=D$pan.orientation,
                Project=D$project)

D$hb.id <- paste(D$NetPan,
                 D$Site,
                 D$SiteStatus,
                 D$SampleRound,
                 D$Date,
                 D$PanColor,
                 D$PanNumber,
                 D$NetNumber,
                 D$FinalPlantSp,
                 D$PanDistance,
                 D$PanLocation,
                 D$PanOrientation,
                 D$Project, sep=';')

table.id <- table(D$hb.id)
D <- unique(D)
D$BeeCount <- table.id[match(D$hb.id, names(table.id))]
D <- D[-match(c('hb.id'), names(D))]
write.csv(D, file='my_data/2006-2011/honeybee.csv',
          row.names=FALSE)
## *******************************************************
