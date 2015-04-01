rm(list=ls())
source('src/misc.R')
cat('add/2011/butterflies.R\n')

## lood data:
D <- read.csv(file='my_data/2006-2011/cleaned/specimen.csv',
              as.is=TRUE)

leps <- read.csv('original/2006-2011/baci_butterflies.csv',
                 as.is=TRUE)
leps <- leps[leps$unique_id %in% D$UniqueID,]
ind <- match(leps$unique_id, D$UniqueID)

## fill stuff in
D$Family[ind] <- leps$family
D$Genus[ind] <- leps$genus
D$Species[ind] <- leps$species
D$Sex[ind] <- leps$sex
D$Author[ind] <- leps$author
D$Determiner[ind] <- leps$determiner
D$DateDetermined[ind] <- leps$date_determined

write.csv(D, file='my_data/2006-2011/cleaned/specimen.csv',
          row.names=FALSE)
