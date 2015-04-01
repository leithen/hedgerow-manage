rm(list=ls())
source('src/misc.R')
cat('2012/clean/conditions.R\n')

## **************************************************
d.orig <- read.csv('original/2012/conditions.csv')
n.entries <- dim(d.orig)[1]
attach(d.orig)

## **************************************************
## Site
Site <- as.character(Site)
## to do at end of year:
Site[Site=='BeemanControl'] <- 'BC2'
Site[Site=='MullerControl'] <- 'MC1'

## **************************************************
## NetPan
## NetPan[NetPan=='pan '] <- 'pan'

## **************************************************
## Date
Date <- as.character(Date)

## **************************************************
## StartTime
id(StartTime)

## **************************************************
## EndTime
id(EndTime)

## **************************************************
## TempStart
id(TempStart)

## **************************************************
## TempEnd
id(TempEnd)

## **************************************************
## WindStart
id(WindStart)

## **************************************************
## WindEnd
id(WindEnd)

## **************************************************
## SkyStart
id(SkyStart)

## **************************************************
## SkyEnd
id(SkyEnd)

## **************************************************
## WeatherNotes
id(WeatherNotes)

## **************************************************
## fill in the easy bits
controls <- c('Barn', 'BC2', 'Best', 'Chamberlain', 'CircleG',
              'CR101Control', 'DQU', 'Gregory', 'H16', 'Hatanaka',
              'Hays', 'Joe', 'Mariani', 'MC1', 'RSlough', 'Spiva',
              'Turkovich', 'USS', 'YoloAirport', 'Zamora')
maturing <- c('Barger', 'Butler', 'Gilmer', 'Hrdy', 'MullerB',
              'RLong', 'Sperandio')
mature <- c('Berm', 'CR101', 'CR29', 'Fong', 'FongWest', 'Harlan',
            'Martinez', 'MullerM', 'Oakdale', 'PutahCreek',
            'Rominger', 'Tractor', 'Voelz')
SiteStatus <- rep('', n.entries)
SiteStatus[Site%in%controls] <- 'control'
SiteStatus[Site%in%maturing] <- 'maturing'
SiteStatus[Site%in%mature] <- 'mature'

Country <- rep('USA', n.entries)
State <- rep('CA', n.entries)
County <- rep('Yolo', n.entries)
County[Site=='RSlough'] <- 'Colusa'
County[Site=='Martinez'] <- 'Colusa'

## *******************************************************
## make new dataset
data <- data.frame(Date,
                   Site,
                   NetPan,
                   SiteStatus,
                   SampleRound=rep('', n.entries),
                   StartTime,
                   EndTime,
                   TempStart,
                   TempEnd,
                   WindStart,
                   WindEnd,
                   SkyStart,
                   SkyEnd,
                   Country,
                   State,
                   County,
                   WeatherNotes)
data[is.na(data)] <- ''

write.csv(data, file='my_data/2012/cleaned/conditions.csv',
          row.names=FALSE)
detach(d.orig)
