rm(list=ls())
source('src/misc.R')
cat('combine/baci.R\n')

## *******************************************************
## create combined baci data-set
## *******************************************************
D.1 <- read.csv('my_data/2006-2011/cleaned/baci_2006_2010.csv')
D.2 <- read.csv('my_data/2006-2011/cleaned/baci_2011.csv')
if(any(names(D.1)!=names(D.2))) cat('ERROR\n')

D <- rbind(D.1, D.2)

## add things to make format consistent with mature
D$pan.distance <- rep('', nrow(D))
D$pan.distance[D$net.pan=='pan'] <- '0'
D$pan.location <- rep('', nrow(D))
D$pan.location[D$net.pan=='pan'] <- 'edge'
D$pan.orientation <- rep('', nrow(D))
D$group <- rep('', nrow(D))
D$data.entry <- rep('', nrow(D))

D$genus[D$family=='Andrenidae?'] <- ''
D$family[D$family=='Andrenidae?'] <- ''
D$family[D$family=='Halictidae?'] <- ''
D$genus[D$genus=='Andrena?'] <- ''
D$genus[D$genus=='Sphecodes?'] <- ''
D$bee.nonbee[D$genus=='Apis'] <- 'bee'

## update classification
D$genus[D$species=='chionura'] <- 'Anthophorula'

## update site name for Muller
site <- as.character(D$site)
site[site=='Hrdy Control'] <- 'HC1'
site[site=='Muller'] <- 'MullerB'
site[site=='MC1'] <- 'MullerControl'
site[site=='Muller Control'] <- 'MullerControl'
D$site <- site

## *******************************************************
## save honeybees and then remove them
write.csv(D[D$general.id=='honeybee',],
          file='my_data/2006-2011/cleaned/baci_honeybee.csv',
          row.names=FALSE)
D <- D[D$general.id!='honeybee',]
## *******************************************************

unique.id <- as.character(D$unique.id)
unique.id[unique.id=='Other'] <- ''
family <- as.character(D$family)
family[unique.id=='Tach Fly'] <- 'Tachinidae'
family[unique.id=='tachinid fly'] <- 'Tachinidae'
D$family <- family
unique.id[unique.id=='Tach Fly'] <- ''
unique.id[unique.id=='tachinid fly'] <- ''

## create missing unique.IDs
date <- as.Date(D$date, format='%Y-%m-%d')
year <- as.numeric(format(date, format = '%Y'))

unique.id[unique.id==''] <- sprintf('M%dSR%d%s_%d',
                                    year,
                                    D$sample.round,
                                    D$site,
                                    D$temp.id)[unique.id=='']
D$unique.id <- unique.id

write.csv(D, file='my_data/2006-2011/cleaned/baci_combined.csv',
          row.names=FALSE)
