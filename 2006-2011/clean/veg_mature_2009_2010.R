rm(list=ls())
source('src/misc.R')
cat('clean/veg_mature_2009_2010.R\n')

d <- read.csv('original/2006-2011/veg_mature_2009_2010.csv',
              as.is=TRUE)

## Site
site <- d$Site
site[site=='Muller'] <- 'MullerM'
d$Site <- site

## Date
d$Date <- as.Date(d$Date, format='%Y-%m-%d')
d$Date[d$Date=='2009-01-07'] <- '2009-07-01'

## ## Quadrat
## d$Quadrat

## Location
## d$Location

## make a new Transect ID
d$TransectID <- paste(d$Site, d$Date, paste(d$Location, d$Quadrat,
                                            sep='-'), sep=';')

## clean up field IDs
##
## first drop unidentified plants
d$Species.ID <- fix.white.space(d$Species.ID)
to.drop <- c('daisy',
             'Fiddleneck (yellow)',
             'purple fragrant, very hairy',
             'rough spikey yellow',
             'UID 1',
             'UID 2',
             'unk forb',
             'unknown',
             'unknown yellow prickly',
             'yellow daisy')
d$Species.ID[d$Species.ID %in% to.drop] <- ''
d$Species.ID[d$Species.ID=='Ceanothus'] <- 'Ceanothus sp.'
d$Species.ID[d$Species.ID=='Centaurea solstitalis'] <- 'Centaurea solstitialis'
d$Species.ID[d$Species.ID=='Epliobium sp.'] <- 'Epilobium sp.'
d$Species.ID[d$Species.ID=='Lupinus densiflora'] <- 'Lupinus densiflorus'
d$Species.ID[d$Species.ID=='Rosemary'] <- 'Rosmarinus officinalis'
d$Species.ID[d$Species.ID=='Toyon'] <- 'Heteromeles arbutifolia'
d$Species.ID[d$Species.ID=='Salvia clevlandii'] <- 'Salvia clevelandii'
d$Species.ID <- gsub('Sp.', 'sp.', d$Species.ID)

## add plant codes for consistency with later years
plant.codes <- read.csv('original/misc/plant_id.csv')
not.empty <- which(d$Species.ID!='')
d$field.codes <- rep('', nrow(d))
d$field.codes[not.empty] <-
  as.character(plant.codes$FieldID[match(d$Species.ID[not.empty],
                                         plant.codes$FullName)])
d <- unique(d)

## Cover.Score
## ## using Braun-Blaquet scale:
## cover.score <- d$Cover.Score
## cover.score[cover.score=='+'] <- '1'
## cover.score <- as.numeric(cover.score)
## using percent cover
cover.score <- as.character(d$percent)
cover.score[is.na(cover.score)] <- ''
cover.score[d$field.codes==''] <- ''
cover.score[d$field.codes!='' & cover.score==''] <- 1

## create data.frame to return
cover.scores <- paste(cover.score, d$field.codes, sep=';')
cover.scores[cover.scores==';'] <- ''
c.by.t <- split(cover.scores, d$TransectID)
c.by.t <- lapply(c.by.t, function(x) x[x!=''])
plant.lists <- sapply(c.by.t, function(x) paste(unique(x), collapse=','))
key.split <- sapply(names(plant.lists), strsplit, split=';')

dd.res <-
  data.frame(Site=as.vector(sapply(key.split, function(x) x[[1]])),
             Date=as.vector(sapply(key.split, function(x) x[[2]])),
             Quad=as.vector(sapply(key.split, function(x) x[[3]])),
             TransectID=names(key.split),
             CoverScore=as.vector(plant.lists))
dd.res$syd <- make.keys(sites=dd.res$Site, dates=dd.res$Date)

write.csv(dd.res, file='my_data/2006-2011/cleaned/veg_mature_2009_2010.csv',
          row.names=FALSE)
