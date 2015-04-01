setwd('~/Dropbox/occupancy/data')

## 2011 and earlier
##
## clean
source('manage/2006-2011/clean/baci_2006_2010.R')
source('manage/2006-2011/clean/baci_2011.R')
source('manage/2006-2011/clean/mature_2009.R')
source('manage/2006-2011/clean/mature_2010.R')
source('manage/2006-2011/clean/mature_2011.R')
source('manage/2006-2011/clean/conditions.R')
## combine
source('manage/2006-2011/combine/baci.R')
source('manage/2006-2011/combine/mature.R')
source('manage/2006-2011/combine/specimen.R')
source('manage/2006-2011/combine/honeybee.R')
## add new IDs
source('manage/2006-2011/add/2011/bees.R')
source('manage/2006-2011/add/2011/butterflies.R')
source('manage/2006-2011/add/2011/syrphids.R')
source('manage/2006-2011/add/2011/wasps.R')

## 2012
##
## clean
source('manage/2012/clean/conditions.R')
source('manage/2012/clean/honeybee.R')
source('manage/2012/clean/specimen.R')
## add IDs
source('manage/2012/add/bees_1.R')
source('manage/2012/add/bees_2.R')
source('manage/2012/add/bees_3.R')
source('manage/2012/add/bees_4.R')
source('manage/2012/add/butterflies.R')
source('manage/2012/add/syrphids.R')
source('manage/2012/add/wasps.R')

## 2013
##
## clean
source('manage/2013/clean/conditions.R')
source('manage/2013/clean/specimen.R')
## add IDs
source('manage/2013/add/bees_1.R')
source('manage/2013/add/bees_2.R')
source('manage/2013/add/butterflies.R')
source('manage/2013/add/syrphids.R')

## 2014
##
## clean
source('manage/2014/clean/conditions.R')
source('manage/2014/clean/specimen.R')
## add IDs
## source('manage/2014/add/bees.R')
## source('manage/2014/add/butterflies.R')
## source('manage/2014/add/syrphids.R')

## generate standardized data files for SQL
source('src/data_prep.R')
load.and.standardize(yr='2006-2011', data.enterer=NA)
load.and.standardize(yr='2012', data.enterer='R. Jaffe')
load.and.standardize(yr='2013', data.enterer='K. Cutler')
load.and.standardize(yr='2014', data.enterer='K. Cutler')

## combine all years and run through SQL
rm(list=ls())
library(RSQLite)
source('src/misc.R')

## function to write data-tables
cat('Loading data files\n')
write.traditional <- function(dd, dir, s) {
  write.csv(dd, file=file.path(dir, sprintf('%s.csv', s)),
            row.names=FALSE)
  save(dd, file=file.path(dir, sprintf('%s.RData', s))) 
}

path <- 'my_data/2006-2011'
c.2011 <- read.csv(file.path(path, 'conditions.csv'), as.is=TRUE)
s.2011 <- read.csv(file.path(path, 'specimen.csv'), as.is=TRUE)

path <- 'my_data/2012'
c.2012 <- read.csv(file.path(path, 'conditions.csv'), as.is=TRUE)
s.2012 <- read.csv(file.path(path, 'specimen.csv'), as.is=TRUE)

path <- 'my_data/2013'
c.2013 <- read.csv(file.path(path, 'conditions.csv'), as.is=TRUE)
s.2013 <- read.csv(file.path(path, 'specimen.csv'), as.is=TRUE)

path <- 'my_data/2014'
c.2014 <- read.csv(file.path(path, 'conditions.csv'), as.is=TRUE)
s.2014 <- read.csv(file.path(path, 'specimen.csv'), as.is=TRUE)

conditions <- rbind(c.2011, c.2012, c.2013, c.2014)
specimens  <- rbind(s.2011, s.2012, s.2013, s.2014)

## Both of the following have been flagged in Google Drive.  Not sure
## what happened with these, but they appear un-resolvable.
##
## "Berm 2012-06-14"
## "Fong 2012-05-21"

## add site names for use in publications
site.code <- conditions$Site
site.code[site.code=='Barger']      <- 'H1'
site.code[site.code=='Butler']      <- 'H2'
site.code[site.code=='Hrdy']        <- 'H3'
site.code[site.code=='MullerB']     <- 'H4'
site.code[site.code=='Sperandio']   <- 'H5'
site.code[site.code=='USS']         <- 'C1a'
site.code[site.code=='Gregory']     <- 'C1b'
site.code[site.code=='H16']         <- 'C2a'
site.code[site.code=='Spiva']       <- 'C2b'
site.code[site.code=='HC1']         <- 'C3a'
site.code[site.code=='Turkovich']   <- 'C3b'
site.code[site.code=='MC1']         <- 'C4a'
site.code[site.code=='BC2']         <- 'C4b'
site.code[site.code=='DQU']         <- 'C5a'
site.code[site.code=='Chamberlain'] <- 'C5b'

site.code[!site.code %in%
          c('H1', 'H2', 'H3', 'H4', 'H5', 'C1a', 'C1b', 'C2a', 'C2b',
            'C3a', 'C3b', 'C4a', 'C4b', 'C5a', 'C5b')] <- ''
conditions$SiteCode <- site.code

## *******************************************************
## Taxonomic updates
## *******************************************************
cat('Making taxonomic updates\n')
source('manage/taxonomy/updates.R')
specimens <- update.taxonomy(specimens)

## *******************************************************
## Create relational database
## *******************************************************
cat('Creating relational database\n')

## *******************************************************
## Start by importing the conditions information, from the conditions
## file.
## *******************************************************
if(file.exists('my_data/relational/hr.db'))
  file.remove('my_data/relational/hr.db')
con <- dbConnect(dbDriver('SQLite'),
                 dbname='my_data/relational/hr.db')

## *******************************************************
## 1. Geographic infomation
## *******************************************************
cat('Geographic information\n')

keep <- c('Site', 'SiteCode', 'Country', 'State', 'County')
geography <- unique(conditions[keep])
geography <- geography[match(sort(geography$Site), geography$Site),]
geography <- cbind(GeographyPK=seq_len(nrow(geography)), geography)
rownames(geography) <- NULL

gps <- read.csv('original/misc/site_coordinates.csv', as.is=TRUE)
geography$GPS <- gps$Coordinates[match(geography$Site, gps$Site)]

dbWriteTable(con, 'tblGeography', geography, row.names=FALSE)

## Propagate geography key to the conditions table.
conditions$GeographyFK <-
  geography$GeographyPK[match(conditions$Site, geography$Site)]
## Propagate geography key to the specimens table.
specimens$GeographyFK <- geography$GeographyPK[match(specimens$Site,
                                                     geography$Site)] 

## write table to csv, just for convenience
write.csv(dbReadTable(con, 'tblGeography'),
          file='my_data/relational/tables/geography.csv', row.names=FALSE)
write.csv(dbReadTable(con, 'tblGeography'),
          file='~/Dropbox/hedgerow/data_sets/tables/geography.csv',
          row.names=FALSE)

## *******************************************************
## 2. Conditions
## *******************************************************
cat('Conditions\n')

## Check that no sample round takes more than one day.
tmp <- paste(conditions$Site, conditions$Date, conditions$SampleRound,
             conditions$NetPan)
if ( any(duplicated(tmp)) ) stop('Duplicates found')

## Temporarily identify unique combinations:
keep <- c('GeographyFK', 'Date', 'NetPan')
conditions$cond.code <- apply(conditions[keep], 1, paste, collapse=';')
specimens$cond.code <- apply(specimens[keep], 1, paste, collapse=';')

## make table
keep <- c('Date', 'SampleRound', 'SiteStatus', 'NetPan', 'StartTime',
          'EndTime', 'TempStart', 'TempEnd', 'WindStart', 'WindEnd',
          'SkyStart', 'SkyEnd', 'WeatherNotes', 'GeographyFK',
          'cond.code')

cond <- unique(conditions[keep])
rownames(cond) <- NULL
cond <- cbind(ConditionsPK=seq_len(nrow(cond)), cond)
## Don't upload the cond.code column
dbWriteTable(con, 'tblConditions', cond[-ncol(cond)], row.names=FALSE)

## Propagate cond key to the conditions table.
conditions$ConditionsFK <-
  cond$ConditionsPK[match(conditions$cond.code, cond$cond.code)]
## Propagate cond key to the specimens table.
specimens$ConditionsFK <-
  cond$ConditionsPK[match(specimens$cond.code, cond$cond.code)]

if(any(is.na(match(specimens$cond.code, cond$cond.code)))) {
  cat('---WARNING:---\n')
  cat('Specimens are being dropped due to site-date inconsistencies\n')
  total.2012 <- sum(is.na(match(specimens$cond.code, cond$cond.code)) &
                    specimens$Date>'2012-01-01' &
                    specimens$Date<'2013-01-01')
  cat('Note: 89 from 2012 are necessarily dropped due to errors made by Tim Luttermoser.\n')
  total.2013 <- sum(is.na(match(specimens$cond.code, cond$cond.code)) &
                    specimens$Date>'2013-01-01' &
                    specimens$Date<'2014-01-01')
  total.2014 <- sum(is.na(match(specimens$cond.code, cond$cond.code)) &
                    specimens$Date>'2014-01-01' &
                    specimens$Date<'2015-01-01')
  cat(sprintf('%d from 2012\n', total.2012))  
  cat(sprintf('%d from 2013\n', total.2013))  
  cat(sprintf('%d from 2014\n', total.2014))  
  cat('--------------\n')
}

## table to check for incorrect site-date combinations
missing <- is.na(match(specimens$cond.code, cond$cond.code))

ind.2012 <- which(missing & specimens$Date>'2012-01-01' &
                  specimens$Date<'2013-01-01')
## drop Tim's specimens
drop <- c(which(specimens$Date[ind.2012]=='2012-05-21' &
                specimens$Site[ind.2012]=='Fong'),
          which(specimens$Date[ind.2012]=='2012-06-14' &
                specimens$Site[ind.2012]=='Berm'))
ind.2012 <- ind.2012[-drop]
ind.2013 <- which(missing & specimens$Date>'2013-01-01' &
                  specimens$Date<'2014-01-01')
ind.2014 <- which(missing & specimens$Date>'2014-01-01' &
                  specimens$Date<'2015-01-01')

if(length(ind.2012)>0 |
   length(ind.2013)>0 |
   length(ind.2014)>0) {
  
  cat('---WARNING:---\n')
  if(length(ind.2012)>0) {
    cat('There are site-date inconsistencies in 2012\n')
    print(unique(specimens[ind.2012, c('TempID', 'Site', 'Date')]))
    cat('Fong 2012-05-21 and Berm 2012-06-14 are due to mistakes made by Tim Luttermoser (not printed here)\n')
  }
  if(length(ind.2013)>0) {
    cat('There are site-date inconsistencies in 2013\n')
    print(unique(specimens[ind.2013, c('TempID', 'Site', 'Date')]))
  }
  if(length(ind.2014)>0) {
    cat('There are site-date inconsistencies in 2014\n')
    print(unique(specimens[ind.2014, c('TempID', 'Site', 'Date')]))
  }
  cat('--------------\n')
}
write.csv(dbReadTable(con, 'tblConditions'),
          file='my_data/relational/tables/conditions.csv', row.names=FALSE)
write.csv(dbReadTable(con, 'tblConditions'),
          file='~/Dropbox/hedgerow/data_sets/tables/conditions.csv',
          row.names=FALSE)

## *******************************************************
## 3. Insect species:
## *******************************************************
cat('Insect species\n')

keep <- c('BeeNonbee', 'Order', 'Family', 'Genus',
          'SubGenus', 'Species', 'SubSpecies') 

insects <- specimens[keep]
insects <- unique(insects)

insects$gen.sp <- paste(insects$BeeNonbee,
                        insects$Order,
                        insects$Family,
                        insects$Genus,
                        insects$SubGenus,
                        insects$Species,
                        insects$SubSpecies, sep=';') 
insects <- cbind(InsectPK=seq_len(nrow(insects)), insects)
rownames(insects) <- NULL

dbWriteTable(con, 'tblInsect', insects[-ncol(insects)],
             row.names=FALSE)

## Propagate insect key to the specimens table.
specimens$gen.sp <- paste(specimens$BeeNonbee,
                          specimens$Order,
                          specimens$Family,
                          specimens$Genus,
                          specimens$SubGenus,
                          specimens$Species,
                          specimens$SubSpecies, sep=';') 
specimens$InsectFK <- insects$InsectPK[match(specimens$gen.sp,
                                             insects$gen.sp)]
specimens$InsectFK[is.na(specimens$InsectFK)] <- ''

write.csv(dbReadTable(con, 'tblInsect'),
          file='my_data/relational/tables/insect.csv', row.names=FALSE)
write.csv(dbReadTable(con, 'tblInsect'),
          file='~/Dropbox/hedgerow/data_sets/tables/insect.csv',
          row.names=FALSE)

## *******************************************************
## 4. Plant species:
## *******************************************************
cat('Plant species\n')

keep <- c('FinalPlantSp') 
plants <- specimens[keep][[1]]
plants <- sort(unique(plants))

PlantGenus <- sapply(strsplit(plants, ' '), function(x) x[1])
PlantGenus[is.na(PlantGenus)] <- ''
PlantSpecies <- sapply(strsplit(plants, ' '), function(x) x[2])
PlantSpecies[is.na(PlantSpecies)] <- ''

plants <- data.frame(PlantPK=seq_along(PlantGenus),
                     PlantGenus, PlantSpecies)
rownames(plants) <- NULL
dbWriteTable(con, 'tblPlant', plants, row.names=FALSE)

## Propagate plant key to the specimens table.
specimens.plant.sp <- specimens[keep][[1]]
plants.plant.sp <- paste(plants$PlantGenus, plants$PlantSpecies)
plants.plant.sp[plants.plant.sp==' '] <- ''
specimens$PlantFK <- plants$PlantPK[match(specimens.plant.sp,
                                         plants.plant.sp)]

write.csv(dbReadTable(con, 'tblPlant'),
          file='my_data/relational/tables/plant.csv', row.names=FALSE)
write.csv(dbReadTable(con, 'tblPlant'),
          file='~/Dropbox/hedgerow/data_sets/tables/plant.csv',
          row.names=FALSE)

## *******************************************************
## 5. Pan info:
## *******************************************************
cat('Pan info\n')

keep <- c('PanColor',
          'PanNumber',
          'PanDistance',
          'PanLocation',
          'PanOrientation') 
pans <- unique(specimens[keep])
pans$PanPK <- seq_len(nrow(pans))
rownames(pans) <- NULL
dbWriteTable(con, 'tblPan', pans, row.names=FALSE)

## pan key to the specimens table.
pans.pan.info <- paste(pans$PanColor,
                       pans$PanNumber,
                       pans$PanDistance,
                       pans$PanLocation,
                       pans$PanOrientation, sep=';')
specimens.pan.info <- paste(specimens$PanColor,
                           specimens$PanNumber,
                           specimens$PanDistance,
                           specimens$PanLocation,
                           specimens$PanOrientation, sep=';') 
specimens$PanFK <- pans$PanPK[match(specimens.pan.info, pans.pan.info)]

write.csv(dbReadTable(con, 'tblPan'),
          file='my_data/relational/tables/pan.csv', row.names=FALSE)
write.csv(dbReadTable(con, 'tblPan'),
          file='~/Dropbox/hedgerow/data_sets/tables/pan.csv',
          row.names=FALSE) 
  
## *******************************************************
## 6. Specimens:
## *******************************************************
cat('Specimens\n')

keep <- c('Project',
          'UniqueID',
          'TempID',
          'Sex',
          'Determiner',
          'DateDetermined',
          'Collector',
          'NetNumber',
          'DataEntry',
          'Notes',
          'InsectFK',
          'PlantFK',
          'PanFK',
          'ConditionsFK',
          'GeographyFK')

specimens <- specimens[keep]
specimens <- unique(specimens)
rownames(specimens) <- NULL

dbWriteTable(con, 'tblSpecimens', specimens, row.names=FALSE)

write.csv(dbReadTable(con, 'tblSpecimens'),
          file='my_data/relational/tables/specimens.csv', row.names=FALSE)
write.csv(dbReadTable(con, 'tblSpecimens'),
          file='~/Dropbox/hedgerow/data_sets/tables/specimens.csv',
          row.names=FALSE)

## *******************************************************
## do stuff
## *******************************************************

## make table containing everything
cat('make table containing everything\n')
sql <- paste('SELECT * FROM tblSpecimens',
             'JOIN tblInsect',
             'ON tblSpecimens.InsectFK = tblInsect.InsectPK',
             'JOIN tblPlant',
             'ON tblSpecimens.PlantFK = tblPlant.PlantPK',
             'JOIN tblPan',
             'ON tblSpecimens.PanFK = tblPan.PanPK',
             'JOIN tblConditions',
             'ON tblSpecimens.ConditionsFK = tblConditions.ConditionsPK',
             'JOIN tblGeography',
             'ON tblSpecimens.GeographyFK = tblGeography.GeographyPK')
res.complete <- dbGetQuery(con, sql)
dim(res.complete)

drop <- c('InsectPK', 'InsectFK',
          'GeographyPK', 'GeographyFK',
          'PlantPK', 'PlantFK',
          'PanPK', 'PanFK',
          'ConditionsPK', 'ConditionsFK')
res.complete <- res.complete[-match(drop, names(res.complete))]
drop <- c('GeographyFK')
res.complete <- res.complete[-match(drop, names(res.complete))]

date <- as.Date(res.complete$Date, format='%Y-%m-%d')
res.complete$Year <- as.numeric(format(date, format = '%Y'))
res.complete$JulianDate <- strptime(date, "%Y-%m-%d")$yday+1
res.complete$syd <- paste(res.complete$Site,
                          res.complete$Year,
                          res.complete$JulianDate, sep=';')

## make full insect names
res.complete[is.na(res.complete)] <- ''
res.complete$GenusSpecies <- fix.white.space(paste(res.complete$Genus,
                                                   res.complete$SubGenus,
                                                   res.complete$Species,
                                                   res.complete$SubSpecies))

## add BACI only status column
SiteStatusBACI <- res.complete$SiteStatus
SiteStatusBACI[res.complete$Project!='kremen-baci'] <- ''
BACI <- c('Barger', 'Butler', 'Hrdy', 'MullerB', 'Sperandio')
SiteStatusBACI[res.complete$Project=='kremen-baci' &
               res.complete$Site%in%BACI]  <- 'hedgerow'
SiteStatusBACI[SiteStatusBACI=='mature']   <- 'hedgerow'
SiteStatusBACI[SiteStatusBACI=='maturing'] <- 'hedgerow'
SiteStatusBACI[SiteStatusBACI=='restored'] <- 'hedgerow'
res.complete$SiteStatusBACI <- SiteStatusBACI

## create vector with year of restoration for each BACI site
res.complete$ypr <- rep(NA, nrow(res.complete))
year.rest <- c(Barger=2008,
               Butler=2007,
               Hrdy=2008,
               MullerB=2007,
               Sperandio=2008,
               BC2=3000,
               Chamberlain=3000,
               DQU=3000,
               Gregory=3000,
               H16=3000,
               HC1=3000,
               MC1=3000,
               Spiva=3000,
               Turkovich=3000,
               USS=3000)

for(i in names(year.rest)) {
  ypr <- res.complete$Year[res.complete$Site==i]-year.rest[i]+1
  ypr[ypr<0] <- 0
  res.complete$ypr[res.complete$Site==i] <- ypr
}

write.traditional(dd=res.complete,
                  dir='my_data/relational/traditional',
                  s='specimens-complete')
write.traditional(dd=res.complete,
                  dir='~/Dropbox/hedgerow/data_sets/traditional',
                  s='specimens-complete')

## make table containing conditions by date
cat('make table containing conditions by date\n')
sql <- paste('SELECT * FROM tblConditions',
             'JOIN tblGeography',
             'ON tblConditions.GeographyFK = tblGeography.GeographyPK')
res <- dbGetQuery(con, sql)

res$JulianDate <- strptime(res$Date, "%Y-%m-%d")$yday+1
date <- as.Date(res$Date, format='%Y-%m-%d')
res$Year <- as.numeric(format(date, format = '%Y'))
res$syd <- paste(res$Site,
                 res$Year,
                 res$JulianDate, sep=';')

## site by date
cat('make site by date table\n')
keep <- c('Site', 'SiteCode', 'Date', 'SiteStatus', 'NetPan', 'Year',
          'syd')

write.traditional(dd=res[keep],
                  dir='my_data/relational/traditional',
                  s='site_by_date')
write.traditional(dd=res[keep],
                  dir='~/Dropbox/hedgerow/data_sets/traditional',
                  s='site_by_date')

## site by date
keep <- c('Site', 'SiteCode', 'Date', 'SiteStatus', 'NetPan',
          'StartTime', 'EndTime', 'TempStart', 'TempEnd', 'WindStart',
          'WindEnd', 'SkyStart', 'SkyEnd', 'Year', 'syd')

write.traditional(dd=res[keep],
                  dir='my_data/relational/traditional',
                  s='site_conditions_by_date')
write.traditional(dd=res[keep],
                  dir='~/Dropbox/hedgerow/data_sets/traditional',
                  s='site_conditions_by_date')

## site by sample round
cat('make site by sample round table\n')
keep <- c('Site', 'SiteCode', 'Year', 'SampleRound', 'SiteStatus',
          'NetPan') 
site.by.sr <- res[keep]
write.csv(site.by.sr,
          file='my_data/relational/traditional/site_by_sr.csv', 
          row.names=FALSE)
write.csv(site.by.sr, file='~/Dropbox/hedgerow/data_sets/traditional/site_by_sr.csv',
          row.names=FALSE)

write.traditional(dd=res[keep],
                  dir='my_data/relational/traditional',
                  s='site_by_sr')
write.traditional(dd=res[keep],
                  dir='~/Dropbox/hedgerow/data_sets/traditional',
                  s='site_by_sr')

dbDisconnect(con)
## *******************************************************










## ## *******************************************************
## ## table containing...
## sql <- paste('SELECT * FROM tblGeography INNER JOIN tblConditions',
##              'ON tblGeography.GeographyPK = tblConditions.GeographyFK;')
## res.site.sample <- dbGetQuery(con, sql)

## ## table containing...
## sql <- paste('SELECT * FROM tblGeography INNER JOIN tblConditions',
##              'ON tblGeography.GeographyPK = tblConditions.GeographyFK',
##              'JOIN tblSite ON tblConditions.ConditionsPK',
##              '= tblSite.SampleRoundFK')
## res.everything <- dbGetQuery(con, sql)             

## ## Drop columns to hide:
## res.everything <- res.everything[-grep('[FP]K$', names(res.everything))]
## ## *******************************************************
 
