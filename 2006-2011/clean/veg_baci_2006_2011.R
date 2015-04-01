rm(list=ls())
source('src/misc.R')
cat('clean/veg_baci_2006_2010.R\n')

d <- read.csv('original/2006-2011/veg_baci_2006_2011.csv',
              as.is=TRUE)

## Site
site <- d$Site
site[site=='Beeman'] <- 'BC1'
site[site=='Beeman Control 2'] <- 'BC2'
site[site=='Bob'] <- 'Bobcat'
site[site=='BOB'] <- 'Bobcat'
site[site=='Fence'] <- 'Barger'
site[site=='Hrdy Control'] <- 'HC1'
site[site=='Hrdy control'] <- 'HC1'
site[site=='Man'] <- 'BC1'
site[site=='MAN'] <- 'BC1'
site[site=='Muller'] <- 'MullerB'
site[site=='MullerControl'] <- 'MC1'
site[site=='Muller control'] <- 'MC1'
site[site=='Muller Control'] <- 'MC1'
site[site=='Parcell'] <- 'Butler'
site[site=='PARCELL'] <- 'Butler'
site[site=='Sporandio'] <- 'Sperandio'
site[site=='Turkovitch'] <- 'Turkovich'
site[site=='Turk'] <- 'Turkovich'
site[site=='ROK'] <- 'Rock'
site[site=='ROC'] <- 'Rock'
d$Site <- site

## Date
d$Date <- as.Date(d$Date, format='%Y-%m-%d')
d$Year <- as.numeric(format(d$Date, format = '%Y'))

## Location
location <- d$Location
location[location=='T/2'] <- 'T'
location <- toupper(fix.white.space(location))
d$Location <- location

## make a new Transect ID
d$TransectID <- paste(d$Site, d$Date, paste(location, d$Quadrat,
                                            sep='-'), sep=';')

## clean up field IDs
##
## first drop unidentified plants
to.drop <- c('0',
             'Plantago sp.',
             'Solanum',
             'Solanum sp.',
             'missing from datasheet',
             'no data recorded',
             'no final plant ID',
             'no final plant ID (specimen not collected)',
             'no flowering plants present')
d$Final.ID[d$Final.ID %in% to.drop] <- ''
d$Final.ID[which(d$Final.ID=='Vicia sp.' & d$Site=='Gregory')] <- ''

## next fix typos / inconsistencies / etc
final.id <- d$Final.ID
final.id[final.id=='Anagalis arvensis'] <- 'Anagallis arvensis'
final.id[final.id=='Atriplex lentiformus'] <- 'Atriplex lentiformis'
final.id[final.id=='Capsella bursa pastoralis'] <- 'Capsella bursa-pastoris'
final.id[final.id=="Ceanothus sp. 'darkstar'"] <- 'Ceanothus sp.'
final.id[final.id=='Centaurea solsistialis'] <- 'Centaurea solstitialis'
final.id[final.id=='Convolvolus arvensis'] <- 'Convolvulus arvensis'
final.id[final.id=='Eschschulzia californica'] <- 'Eschscholzia californica'
final.id[final.id=='Fremontodendron californicum'] <- 'Fremontia californica'
final.id[final.id=='Galium aparine'] <- 'Galium sp.'
final.id[final.id=='Helenium puburulum'] <- 'Helenium puberulum'
final.id[final.id=='Kicksia elatine'] <- 'Kickxia elatine'
final.id[final.id=='Lotus corniculata'] <- 'Lotus corniculatus'
final.id[final.id=='Melilotus alba'] <- 'Melilotus albus'
final.id[final.id=='Melilotus Officinalis'] <- 'Melilotus officinalis'
final.id[final.id=='Malva sp.' & d$Site=='MullerB'] <- 'Malva parviflora'
final.id[final.id=='Malva sp.' & d$Site!='MullerB'] <- 'Malva neglecta'
final.id[final.id=='Marubium vulgare'] <- 'Marrubium vulgare'
final.id[final.id=='Nicotina glauca'] <- 'Nicotiana glauca'
final.id[final.id=='Picris echioidea'] <- 'Picris echioides'
final.id[final.id=='Picris echioides? See notes in all flower worksheet'] <- 'Picris echioides'
final.id[final.id=='Raphanus Sativa'] <- 'Raphanus sativus'
final.id[final.id=='Raphanus sativa'] <- 'Raphanus sativus'
final.id[final.id=='Rhamnus californicus'] <- 'Rhamnus californica'
final.id[final.id=='Rosa Californica'] <- 'Rosa californica'
final.id[final.id=='Salix Sp.'] <- 'Salix sp.'
final.id[final.id=='Taraxacum officinale'] <- 'Taraxicum officianalis'
final.id[final.id=='Trifolium repense'] <- 'Trifolium repens'
final.id[final.id=='Vicia sativa sp. sativa'] <- 'Vicia sativa'
final.id[final.id=='Vicia nigricans sp. gigantea'] <- 'Vicia nigricans'
final.id[final.id=='Vicia sp' & d$Site=='Gnoss'] <- 'Vicia americana'
final.id[final.id=='Vicia sp.' & d$Site=='HC1'] <- 'Vicia villosa'
final.id[grep('Brassica', final.id)] <- 'Brassica sp.'
final.id[grep('Calendula', final.id)] <- 'Calendula officinalis'
final.id[grep('Juglans', final.id)] <- 'Juglans californica'
final.id[grep('Lupinus', final.id)] <- 'Lupinus sp.'
final.id[grep('Phacelia sp.', final.id)] <- 'Phacelia californica'
final.id[grep('Polygonum sp.', final.id)] <- 'Polygonum arenastrum'
final.id[grep('Portulaca sp.', final.id)] <- 'Portulaca oleracea'
final.id[grep('Punica sp.', final.id)] <- 'Punica granatum'
final.id[grep('Sambucus', final.id)] <- 'Sambucus mexicana'
final.id[grep('Sonchus', final.id)] <- 'Sonchus sp.'
final.id[grep('Trifolium sp.', final.id)] <- 'Trifolium sp.'
final.id <- gsub('Sp.', 'sp.', final.id)
d$Final.ID <- final.id

## add plant codes for consistency with later years
plant.codes <- read.csv('original/misc/plant_id.csv')
not.empty <- which(d$Final.ID!='')
d$field.codes <- rep('', nrow(d))
d$field.codes[not.empty] <-
  as.character(plant.codes$FieldID[match(d$Final.ID[not.empty],
                                         plant.codes$FullName)])

d <- unique(d)

## Cover.Score
cover.score <- d$Cover.Score
cover.score[d$field.codes==''] <- ''
cover.score[cover.score=='data not collected -- see notes'] <- ''
cover.score[cover.score=='many flowers/cluster'] <- ''
cover.score[cover.score=='no cluster data recorded'] <- ''
cover.score[cover.score=='no data recorded'] <- ''
cover.score[cover.score=='+'] <- '1'
cover.score[d$field.codes!='' & cover.score==''] <- '1'

## create data.frame to return
cover.scores <- paste(cover.score, d$field.codes, sep=';')
cover.scores[cover.scores==';'] <- ''
c.by.t <- split(cover.scores, d$TransectID)
c.by.t <- lapply(c.by.t, function(x) x[x!=''])
plant.lists <- sapply(c.by.t, function(x) paste(unique(x), collapse=','))
key.split <- sapply(names(plant.lists), strsplit, split=';')

key.split <- sapply(names(plant.lists), strsplit, split=';')

dd.res <-
  data.frame(Site=as.vector(sapply(key.split, function(x) x[[1]])),
             Date=as.vector(sapply(key.split, function(x) x[[2]])),
             Quad=as.vector(sapply(key.split, function(x) x[[3]])),
             TransectID=names(key.split),
             CoverScore=as.vector(plant.lists))

dd.res$syd <- make.keys(sites=dd.res$Site, dates=dd.res$Date)

## add in missing site that purportedly had

head(dd.res)


write.csv(dd.res, file='my_data/2006-2011/cleaned/veg_baci_2006_2011.csv',
          row.names=FALSE)
