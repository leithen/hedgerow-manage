 ## ************************************************************
setwd('~/Dropbox/occupancy')
rm(list=ls())
source('data/src/misc.R')
library('bipartite')

traits <- read.csv('data/original/functional_traits/lkm/syrphid.csv',
                   as.is=TRUE)

## calculate some network stuff:
dd <- read.csv('data/my_data/relational/traditional/specimens-complete.csv')
dd <- dd[dd$NetPan=='net',]
dd <- dd[dd$Family=='Syrphidae',]

## dd$Year[dd$Family=='Syrphidae']
## table(dd$NetPan[dd$Family=='Syrphidae'])

## dd$Species[dd$Family=='Syrphidae' & dd$Year==2011]

## dd$NetPan[dd$Family=='Syrphidae' & dd$Year==2011]

## create pollinator data
polli <- fix.white.space(paste(dd$Genus,
                               dd$SubGenus,
                               dd$Species,
                               dd$SubSpecies))

## create plant data
plant <- fix.white.space(paste(dd$PlantGenus,
                               dd$PlantSpecies))

drop <- which(dd$Species=='' | plant=='' |
              is.na(match(polli, traits$GenusSp)))
dd <- dd[-drop,]
polli <- polli[-drop]
plant <- plant[-drop]

samp2site.spp <- function(site,spp,abund) { 
  x <- tapply(abund, list(site=site,spp=spp), sum)
  x[is.na(x)] <- 0
  x
}

abund <- aggregate(list(count=polli),
                   list(pol=polli, plant=plant),
                   length)
int.mat <- samp2site.spp(abund$plant, abund$pol, abund$count)
metrics <- specieslevel(int.mat, index=c('ALL'))

make.vec <- function(x) {
  bw <- rep('', length(traits$GenusSp))
  bw[match(names(x), traits$GenusSp)] <- x
  bw
}

traits <- cbind(traits, data.frame(lapply(metrics[[1]], make.vec)))

write.csv(traits, file='data/my_data/functional_traits/syrphid.csv', row.names=FALSE)
write.csv(traits, file='~/Dropbox/hedgerow/data_sets/traditional/functional_traits/syrphid.csv', row.names=FALSE)
## ************************************************************
