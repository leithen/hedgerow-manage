rm(list=ls())
source('src/misc.R')
cat('clean/conditions.R\n')

## *******************************************************
## update conditions data
## *******************************************************
D <- read.csv('original/2006-2011/conditions.csv', as.is=TRUE)

date <- as.Date(D$Date, format='%Y-%m-%d')
year <- as.numeric(format(date, format = '%Y'))

## site
site <- D$Site
site[site=='Muller Control'] <- 'MC1'
D$Site <- site

## site status
D$SiteStatus[D$Site=='MullerB' & year>=2009] <- 'maturing'

write.csv(D, file='my_data/2006-2011/cleaned/conditions.csv',
          row.names=FALSE)
