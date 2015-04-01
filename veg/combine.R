rm(list=ls())
source('src/misc.R')
cat('combine/veg/combine.R\n')

## **************************************************
## load veg data files
d.2011 <- read.csv('my_data/2006-2011/cleaned/veg_baci_2006_2011.csv',
                   as.is=TRUE)
d.mature <- read.csv('my_data/2006-2011/cleaned/veg_mature_2009_2010.csv',
                     as.is=TRUE)
d.2012 <- read.csv('my_data/2012/cleaned/veg.csv', as.is=TRUE)
d.2013 <- read.csv('my_data/2013/cleaned/veg.csv', as.is=TRUE)

## rbind data-sets together
dd <- rbind(d.mature, d.2011, d.2012, d.2013)

## **************************************************
## identify sites with no floral cover (to be added back in later)
cover.by.key <- split(dd$CoverScore, dd$syd)
any.plants <- sapply(cover.by.key, function(x) any(x!=''))
no.plants <- names(any.plants)[!any.plants]
dd.no.plants <- unique(dd[dd$syd %in% no.plants,
                          c('Site', 'Date', 'syd')])

## **************************************************
## drop quadrates without any plants
dd <- dd[dd$CoverScore!='',]

## **************************************************
## plant lists and cover scores
plant.codes <- read.csv('original/misc/plant_id.csv')

lists <- sapply(dd$CoverScore, strsplit, split=',')
lists <- sapply(lists, function(x)
                sapply(x, function(y) strsplit(y, split=';')[[1]]))

cover.scores <- lapply(lists, function(x) as.vector(x[1,]))
plants <- lapply(lists, function(x) as.vector(x[2,]))
num.plants <- sapply(plants, length)

plants <- as.vector(sapply(plants, paste, collapse=";"))
cover.scores <- as.vector(sapply(cover.scores, paste, collapse=";"))
dd$PlantSpecies <- gsub(' ', '', plants)
dd$CoverScores <- gsub(' ', '', cover.scores)

## **************************************************
## identify missing field codes
field.codes <- id(strsplit(paste(dd$PlantSpecies, collapse=";"),
                           split=';')[[1]])
if(any(!field.codes %in% plant.codes$FieldID)) {
  cat('missing field codes for:\n')
  print(field.codes[!field.codes %in% plant.codes$FieldID])
}

plant <- dd$PlantSpecies
for(code in field.codes[field.codes %in% plant.codes$FieldID])
  plant <- gsub(code, plant.codes$FullName[match(code, plant.codes$FieldID)], plant)

## to do:
## plant[grep('Raphanus', plant)] <- 'Raphanus sativus'
## plant[grep('Lavandula', plant)] <- 'Lavandula officinalis'
## plant[grep('Brassica', plant)] <- 'Brassica sp.'
## plant[grep('Lupinus', plant)] <- 'Lupinus sp.'
## plant[grep('Malva sp.', plant)] <- 'Malva neglecta'
## plant[grep('Salvia', plant)] <- 'Salvia sp.'
## plant[grep('Sonchus', plant)] <- 'Sonchus sp.'
## plant[grep('Vicia sp.', plant)] <- 'Vicia americana'
## id(plant)

dd$PlantSpecies <- plant

## **************************************************
## add back in sites with no plants
dd[(nrow(dd)+1):(nrow(dd)+nrow(dd.no.plants)),
   colnames(dd.no.plants)] <- dd.no.plants
rownames(dd) <- NULL

write.csv(dd,
          file='~/Dropbox/hedgerow/data_sets/traditional/veg-complete.csv',
          row.names=FALSE)
save(dd,
     file='~/Dropbox/hedgerow/data_sets/traditional/veg-complete.RData')
save(dd,
     file='~/Dropbox/occupancy/data/my_data/veg/veg-complete.RData')
