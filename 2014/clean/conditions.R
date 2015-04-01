rm(list=ls())
source('src/misc.R')
cat('2014/clean/conditions.R\n')

## **************************************************
d.orig <- read.csv('original/2014/conditions.csv')
n.entries <- dim(d.orig)[1]
attach(d.orig)

## **************************************************
## Site
Site <- as.character(Site)
Site[Site=='Beeman'] <- 'BC2'
Site[Site=='MullerControl'] <- 'MC1'
lapply(split(paste(d.orig$Date, d.orig$NetPan), Site), sort)
## table(Site)

## **************************************************
## NetPan
NetPan <- tolower(NetPan)

## **************************************************
## Date
## Date <- as.character(Date)

## ## **************************************************
## ## StartTime
## id(StartTime)

## ## **************************************************
## ## EndTime
## id(EndTime)

## ## **************************************************
## ## TempStart
## id(TempStart)

## ## **************************************************
## ## TempEnd
## id(TempEnd)

## ## **************************************************
## ## WindStart
## id(WindStart)

## ## **************************************************
## ## WindEnd
## id(WindEnd)

## ## **************************************************
## ## SkyStart
## id(SkyStart)

## ## **************************************************
## ## SkyEnd
## id(SkyEnd)

## ## **************************************************
## ## WeatherNotes
## id(WeatherNotes)

## **************************************************
## fill in the easy bits
controls <- c('Barn', 'BC2', 'Best', 'Chamberlain', 'CircleG',
              'CR101Control', 'DQU', 'Gregory', 'H16', 'Hatanaka',
              'Hays', 'Joe', 'Loop', 'Maria', 'MC1', 'Roosevelt',
              'RSlough', 'Spiva', 'Turkovich', 'USS', 'YoloAirport',
              'Zamora') 
maturing <- c('Barger', 'Butler', 'Gilmer', 'Hrdy', 'Johnston',
              'MullerB', 'RLong', 'Sperandio')
mature <- c('Berm', 'CR101', 'CR29', 'Fong', 'FongWest', 'Harlan',
            'Martinez', 'MullerM', 'Oakdale', 'PutahCreek',
            'Rominger', 'Tractor', 'Voelz')
forb <- c('BermForb', 'GilmerForb', 'PurcellForb', 'PutahCreekForb',
          'RomingerForb')
natural <- c('Bramlett', 'Bray1', 'Bray2', 'Lowry', 'SHamilton')
SiteStatus <- rep('', n.entries)
SiteStatus[Site%in%controls] <- 'control'
SiteStatus[Site%in%maturing] <- 'maturing'
SiteStatus[Site%in%mature] <- 'mature'
SiteStatus[Site%in%forb] <- 'forb'
SiteStatus[Site%in%natural] <- 'natural'

Country <- rep('USA', n.entries)
State <- rep('CA', n.entries)
County <- rep('Yolo', n.entries)
County[Site=='RSlough'] <- 'Colusa'
County[Site=='Martinez'] <- 'Colusa'
County[Site=='Bramlett'] <- ''
County[Site=='Bray1'] <- ''
County[Site=='Bray2'] <- ''
County[Site=='Lowry'] <- ''
County[Site=='SHamilton'] <- ''

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

write.csv(data, file='my_data/2014/cleaned/conditions.csv',
          row.names=FALSE)
detach(d.orig)
