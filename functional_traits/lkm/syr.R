## ************************************************************
rm(list=ls())
cat('manage/functional_traits/lkm/syr.R\n')
source('src/misc.R')
library('bipartite')

traits <- read.csv('original/functional_traits/lkm/syrphid.csv',
                   as.is=TRUE, row.names='GenusSpecies')

## load specimen data
load('my_data/relational/traditional/specimens-complete.RData')
dd <- dd[dd$Family=='Syrphidae',]

## calculate abundances in data-set
ind.net <- dd$NetPan=='net'
ind.pan <- dd$NetPan=='pan'

traits$abun.net <- sapply(id(rownames(traits)), function(x)
                          sum(dd$GenusSpecies[ind.net]==x))
traits$abun.pan <- sapply(id(rownames(traits)), function(x)
                          sum(dd$GenusSpecies[ind.pan]==x))

traits$num.occ.net <-
  sapply(id(rownames(traits)), function(x)
         length(unique(dd$syd[ind.net][dd$GenusSpecies[ind.net]==x])))

traits$num.occ.pan <-
  sapply(id(rownames(traits)), function(x)
         length(unique(dd$syd[ind.pan][dd$GenusSpecies[ind.pan]==x])))

## create pollinator data to compute network traits
dd <- dd[dd$NetPan=='net',]

## create pollinator data
polli <- fix.white.space(paste(dd$Genus,
                               dd$SubGenus,
                               dd$Species,
                               dd$SubSpecies))

## create plant data
plant <- fix.white.space(paste(dd$PlantGenus,
                               dd$PlantSpecies))

drop <- which(dd$Species=='' | plant=='' |
              is.na(match(polli, rownames(traits))))
dd <- dd[-drop,]
polli <- polli[-drop]
plant <- plant[-drop]

samp2site.spp <- function(site, spp, abund) { 
  x <- tapply(abund, list(site=site,spp=spp), sum)
  x[is.na(x)] <- 0
  x
}

abund <- aggregate(list(count=polli),
                   list(pol=polli, plant=plant),
                   length)
int.mat <- samp2site.spp(abund$plant, abund$pol, abund$count)
metrics <- specieslevel(int.mat, index=c('ALL'))[[1]]

## keep only d'
metrics <- list(d=metrics$d)

make.vec <- function(x) {
  bw <- rep('', ncol(traits))
  bw[match(names(x), rownames(traits))] <- x
  bw
}

traits <- cbind(traits, data.frame(lapply(metrics, make.vec)))
traits[traits==''] <- NA
traits$GenusSpecies <- rownames(traits)

write.csv(traits, file='my_data/functional_traits/syr.csv',
          row.names=TRUE)
write.csv(traits, file='~/Dropbox/hedgerow/data_sets/traditional/functional_traits/syr.csv', row.names=TRUE)
## ************************************************************
