## ************************************************************
setwd('~/Dropbox/occupancy')
rm(list=ls())
source('data/src/misc.R')
library('bipartite')

## bees
traits <- read.csv('data/original/functional_traits/lkm/bee.csv',
                   as.is=TRUE)

## load specimen data
load('data/my_data/relational/traditional/specimens-complete.RData')
dd <- dd[dd$Year==2013 & dd$BeeNonbee=='bee',]

measurements <- traits[,c('Specimen1',
                          'Specimen2',
                          'Specimen3',
                          'Specimen4',
                          'Specimen5')]

num.needed <- apply(is.na(measurements), 1, sum)
names(num.needed) <- traits$GenusSpecies

num.needed <- num.needed[num.needed>0]

dd.2013 <- table(dd$GenusSpecies)
num.have <- dd.2013[names(dd.2013) %in% names(num.needed)]

to.do <- cbind(needed=num.needed[names(num.needed) %in%
                 names(num.have)],
               have=num.have)
to.do

##                               needed
## Coelioxys gilensis                 5
## Lasioglossum (Evylaeus) sp. 4      5
## Lasioglossum (Evylaeus) sp. C      1
## Megachile brevis                   3
## Osmia gaudiosa                     2
## Stelis laticincta                  5
## Stelis montana                     4

## syrphids
traits <- read.csv('data/original/functional_traits/lkm/syrphid.csv',
                   as.is=TRUE)

## load specimen data
load('data/my_data/relational/traditional/specimens-complete.RData')
dd <- dd[dd$Year==2013 & dd$Family=='Syrphidae',]

measurements <- traits[,c('BodyLength1',
                          'BodyLength2',
                          'BodyLength3',
                          'BodyLength4',
                          'BodyLength5')]

num.needed <- apply(is.na(measurements), 1, sum)
names(num.needed) <- traits$GenusSpecies

num.needed <- num.needed[num.needed>0]

dd.2013 <- table(dd$GenusSpecies)
num.have <- dd.2013[names(dd.2013) %in% names(num.needed)]

to.do <- cbind(needed=num.needed[names(num.needed) %in%
                 names(num.have)],
               have=num.have)
to.do

##                        needed
## Copestylum mexicanum        2
## Myathropa florea            3
## Palpada alhambra            3
## Platycheirus obscurus       1
## Platycheirus quadratus      4
## Syrphus torvus              5
## Tropidia quadrata           2

