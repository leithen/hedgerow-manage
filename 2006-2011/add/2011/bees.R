rm(list=ls())
source('src/misc.R')
cat('add/2011/bees.R\n')

sp.ids <- list(list(Genus='Nomada', SubGenus='', Species='sp.',
                    SubSpecies='3', Sex='f',
                    UniqueID=c('M2011SR1Muller_2692' ,
                      'M2011SR1Butler_2086',
                      'M2011SR1HC1_867',
                      'M2011SR1HC1_4146',
                      'M2011SR1HC1_4185',
                      'M2011SR1HC1_4009',
                      'M2011SR1HC1_4008')),

               list(Genus='Nomada', SubGenus='', Species='sp.',
                    SubSpecies='CK-1M', Sex='m',
                    UniqueID=c('M2011SR1Sperandio_27')),

               list(Genus='Sphecodes', SubGenus='', Species='sp.',
                    SubSpecies='B', Sex='f',
                    UniqueID=c('M2011SR1BC2_2860')))

lengths <- sapply(sp.ids, function(x) length(x$UniqueID))
genus <- sapply(sp.ids, function(x) x$Genus)
sub.genus <- sapply(sp.ids, function(x) x$SubGenus)
species <- sapply(sp.ids, function(x) x$Species)
sub.species <- sapply(sp.ids, function(x) x$SubSpecies)
sex <- sapply(sp.ids, function(x) x$Sex)
unique.id <- sapply(sp.ids, function(x) x$UniqueID)
dd <- data.frame(unique.id=unlist(unique.id),
                 genus=rep(genus, lengths),
                 sub.genus=rep(sub.genus, lengths),
                 species=rep(species, lengths),
                 sub.species=rep(sub.species, lengths),
                 sex=rep(sex, lengths))

## lood data:
D <- read.csv(file='my_data/2006-2011/cleaned/specimen.csv',
              as.is=TRUE)

date <- as.Date(D$Date, format='%Y-%m-%d')
year <- as.numeric(format(date, format = '%Y'))

ind <- match(dd$unique.id, D$UniqueID)
D$BeeNonbee[ind] <- 'bee'
D$Genus[ind] <- as.character(dd$genus)
D$SubGenus[ind] <- as.character(dd$sub.genus)
D$Species[ind] <- as.character(dd$species)
D$SubSpecies[ind] <- as.character(dd$sub.species)
D$Sex[ind] <- as.character(dd$sex)
D$Determiner[ind] <- 'R. Thorp'

write.csv(D, file='my_data/2006-2011/cleaned/specimen.csv',
          row.names=FALSE)
