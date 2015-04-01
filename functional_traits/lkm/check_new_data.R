setwd('~/Dropbox/occupancy')
rm(list=ls())
source('data/src/misc.R')

## BEES
dir <- 'data/original/functional_traits'
itd <- read.csv(file.path(dir, 'lkm/bee/bee_msr.csv'),
                as.is=TRUE)
keep <- c('UniqueID', 'Species', 'Scope', 'ITDSetting', 'ITD')
itd <- itd[,keep]

## *** scope 1 stuff ***
itd.scope.1 <- itd[itd$Scope==1,]

scope.1 <- read.csv(file.path(dir, 'lkm/scope-calibrations/nikon.csv'), as.is=TRUE) 

itd.scope.1$mm <- itd.scope.1$ITD /
  scope.1$ticks.per.mm[match(itd.scope.1$ITDSetting,
                             scope.1$magnification)]
itd.scope.1[,c('Species', 'ITD', 'mm')]
## *********************

## *** scope 2 stuff
itd.scope.2 <- itd[itd$Scope==2,]

scope.2 <- read.csv(file.path(dir, 'lkm/scope-calibrations/zeiss.csv'), as.is=TRUE) 

itd.scope.2$mm <- itd.scope.2$ITD / scope.2$ticks.per.mm[match(itd.scope.2$ITDSetting, scope.2$magnification)]
itd.scope.2[,c('Species', 'ITD', 'mm')]
## *********************

## SYRPHIDS
dir <- 'data/original/functional_traits'
blwl <- read.csv(file.path(dir, 'lkm/syrphid/syrphid_msr.csv'),
                 as.is=TRUE)

blwl <- blwl[blwl$UniqueID!="",]

## *** scope 1 stuff ***
blwl.scope.1 <- blwl[blwl$Scope==1,]

scope.1 <- read.csv(file.path(dir, 'lkm/scope-calibrations/nikon.csv'), as.is=TRUE)  

blwl.scope.1$BodyLength.mm <- blwl.scope.1$BodyLength /
  scope.1$ticks.per.mm[match(blwl.scope.1$BodyLengthSetting, scope.1$magnification)]
blwl.scope.1$WingLength.mm <- blwl.scope.1$WingLength /
  scope.1$ticks.per.mm[match(blwl.scope.1$WingLengthSetting, scope.1$magnification)]
blwl.scope.1$HeadWidth.mm <- blwl.scope.1$HeadWidth /
  scope.1$ticks.per.mm[match(blwl.scope.1$HeadWidthSetting, scope.1$magnification)]

blwl.scope.1[,c("Species", "BodyLength.mm", "WingLength.mm", "HeadWidth.mm")]
## *********************

## ## *** scope 2 stuff
## blwl.scope.2 <- blwl[blwl$Scope==2,]

## scope.2 <- read.csv(file.path(dir, 'lkm/scope-calibrations/zeiss.csv'), as.is=TRUE)  

## blwl.scope.2$BodyLength.mm <- blwl.scope.2$BodyLength /
##   scope.2$ticks.per.mm[match(blwl.scope.2$BodyLengthSetting, scope.2$magnification)]
## blwl.scope.2$WingLength.mm <- blwl.scope.2$WingLength /
##   scope.2$ticks.per.mm[match(blwl.scope.2$WingLengthSetting, scope.2$magnification)]
## blwl.scope.2$HeadWidth.mm <- blwl.scope.2$HeadWidth /
##   scope.2$ticks.per.mm[match(blwl.scope.2$HeadWidthSetting, scope.2$magnification)]

## blwl.scope.2[,c("Species", "BodyLength.mm", "WingLength.mm", "HeadWidth.mm")]
## ## *********************




## traits$betweenness[ind] <- bee.chars[,1][in.list] 


## date <- as.Date(dd$Date, format='%Y-%m-%d')
## year <- as.numeric(format(date, format = '%Y'))

## not.na <- itd$UniqueID!=''
## itd$UniqueID[not.na][!itd$UniqueID[not.na] %in% dd$UniqueID]
## itd$Species[not.na][!itd$UniqueID[not.na] %in% dd$UniqueID]

## ind <- match(itd$UniqueID[not.na], dd$UniqueID)
## gsp <- paste(dd$Genus[ind],
##              dd$Species[ind],
##              dd$SubSpecies[ind])
## paste(itd$Species[not.na], gsp)


## dd$UniqueID[dd$Species=='cerasifolii']

## dd$UniqueID[dd$Genus=='Nomada' & dd$Species=='3']


## traits <- read.csv('data/original/functional_traits/lkm/bee.csv',
##                    as.is=TRUE)

## keep <- c('GenusSp', 'Specimen1', 'Specimen2', 'Specimen3',
##           'Specimen4', 'Specimen5', 'InKremen')
## traits <- traits[,keep]
## traits$NumNeeded <-
##   apply(traits[,c('Specimen1', 'Specimen2', 'Specimen3', 'Specimen4',
##                   'Specimen5')], 1, function(x) sum(is.na(x)))
## traits <- traits[traits$NumNeeded>0,]
## traits <- traits[,c('GenusSp', 'NumNeeded', 'InKremen')]
## write.csv(traits, '~/Desktop/traits.to.get.csv')
