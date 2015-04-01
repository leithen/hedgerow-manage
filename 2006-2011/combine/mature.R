rm(list=ls())
source('src/misc.R')
cat('combine/mature.R\n')

## *******************************************************
## create combined mature data-set
## *******************************************************
D.2009 <- read.csv('my_data/2006-2011/cleaned/mature_2009.csv')
D.2010 <- read.csv('my_data/2006-2011/cleaned/mature_2010.csv')
D.2011 <- read.csv('my_data/2006-2011/cleaned/mature_2011.csv')

if(any(names(D.2009)!=names(D.2010))) cat('ERROR\n')
if(any(names(D.2010)!=names(D.2011))) cat('ERROR\n')

D <- rbind(D.2009, D.2010, D.2011)

## update classification
D$genus[D$species=='chionura'] <- 'Anthophorula'

## update site name for Muller
site <- as.character(D$site)
site[site=='Muller'] <- 'MullerM'
site[site=='Muller Control'] <- 'MullerControl'
site[site=='Circle G'] <- 'CircleG'
D$site <- site

## *******************************************************
## save honeybees and then remove them
write.csv(D[D$general.id=='honeybee',],
          file='my_data/2006-2011/cleaned/mature_honeybee.csv',
          row.names=FALSE)
D <- D[D$general.id!='honeybee',]
## *******************************************************

## create missing unique.IDs
unique.id <- as.character(D$unique.id)
ind <- which(unique.id=='')
date <- as.Date(D$date, format='%Y-%m-%d')
year <- as.numeric(format(date, format = '%Y'))[ind]
temp.id <- D$temp.id[ind]
unique.id[ind] <- sprintf('Morandin%d_%s', year, temp.id)
D$unique.id <- unique.id

cat('-dropped species with missing tempID-\n')
D <- D[!is.na(D$temp.id),]
write.csv(D[D$general.id!='honeybee',],
          file='my_data/2006-2011/cleaned/mature_combined.csv',
          row.names=FALSE)
