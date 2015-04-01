rm(list=ls())
source('src/misc.R')
cat('combine/specimen.R\n')

## *******************************************************
## combine mature and baci datasets
## *******************************************************
B <- read.csv('my_data/2006-2011/cleaned/baci_combined.csv')
B$pan.distance <- rep(0, nrow(B))

M <- read.csv('my_data/2006-2011/cleaned/mature_combined.csv')

common.names <- intersect(names(B), names(M))
D <- rbind(B[,common.names], M[,common.names])

## make project key
D$project <- c(rep('kremen-baci', nrow(B)),
               rep('kremen-mature', nrow(M)))

## corrections to orders, families, etc
order <- as.character(D$order)
family <- as.character(D$family)
genus <- as.character(D$genus)
sub.genus <- as.character(D$sub.genus)
species <- as.character(D$species)
sub.species <- as.character(D$sub.species)

order[D$bee.nonbee=='bee'] <- 'Hymenoptera'
order[genus=='Sphaerophoria'] <- 'Diptera'
family[genus=='Hylaeus'] <- 'Colletidae'
family[genus=='Halictus'] <- 'Halictidae'
family[genus=='Lasioglossum'] <- 'Halictidae'
family[genus=='Diadasia'] <- 'Apidae'
sub.genus[species=='incompletum'] <- '(Dialictus)'
species[family=='Syrphidae' & species=='longistylis'] <- 'longistylus'
sub.species[sub.species=='MOR-IM'] <- 'MOR-1M'
sub.species[sub.species=='MOR-I'] <- '1'

D$order <- order
D$family <- family
D$species <- species
D$sub.species <- sub.species

## drop incorrectly labelled specimens
D <- D[-which(D$sub.species=='A' & D$sex=='m'),]
D <- D[-which(D$sub.species=='B' & D$sex=='m'),]

## corrections to group
group <- as.character(D$group)
group[D$bee.nonbee=='bee'] <- 'native bee'
group[D$family=='Syrphidae'] <- 'syrphid'
D$group <- group

## update author
author <- as.character(D$author)
gen.sp <- paste(D$genus, D$species)
author[gen.sp=='Andrena chlorogaster'] <- 'Viereck'
author[gen.sp=='Anthophorula chionura'] <- 'Cockerell'
author[gen.sp=='Bombus californicus'] <- 'Smith'
author[gen.sp=='Bombus crotchii'] <- 'Cresson'
author[gen.sp=='Bombus melanopygus'] <- 'Nylander'
author[gen.sp=='Bombus vosnesenskii'] <- 'Radoszkowski'
author[gen.sp=='Ceratina arizonensis'] <- 'Cockerell'
author[gen.sp=='Megachile rotundata'] <- 'Frabricius'
author[gen.sp=='Osmia nemoris'] <- 'Sandhouse'
D$author <- author

date <- as.Date(D$date, format='%Y-%m-%d')
year <- as.numeric(format(date, format = '%Y'))

## update site statuses
status <- as.character(D$site.status)
status[status=='C' | status=='TBR']            <- 'control'
status[status=='H' | status=='reference site'] <- 'mature'
status[status=='R']                            <- 'restored'
status[D$site=='Hrdy'      & year>=2009]       <- 'maturing'
status[D$site=='Butler'    & year>=2009]       <- 'maturing'
status[D$site=='MullerB'   & year>=2009]       <- 'maturing'
status[D$site=='Sperandio' & year>=2011]       <- 'maturing'
status[D$site=='Barger'    & year>=2011]       <- 'maturing'
status[D$site=='Bobcat']                       <- 'reference'
D$site.status <- status

## update incorrect field id
plant.sp <- as.character(D$plant.sp)
plant.sp[plant.sp=='FRA CAL'] <- 'RHA CAL'
D$plant.sp <- plant.sp

## update final.plant.sp
final.plant.sp <- as.character(D$final.plant.sp)
final.plant.sp[final.plant.sp=='Calendula sp.'] <-
  'Calendula officinalis'
final.plant.sp[final.plant.sp=='Ceonothus sp.'] <-
  'Ceanothus sp.'
final.plant.sp[final.plant.sp=='Juglans sp.'] <-
  'Juglans californica'
final.plant.sp[final.plant.sp=='Lavendula sp.'] <-
  'Lavandula sp.'
final.plant.sp[final.plant.sp=='Lavandula sp.'] <-
  'Lavandula officinalis'
final.plant.sp[final.plant.sp=='Sambucus sp.'] <-
  'Sambucus mexicana'
final.plant.sp[final.plant.sp=='Convolvolus arvensis'] <-
  'Convolvulus arvensis'
final.plant.sp[final.plant.sp=='Fraxinus californica'] <- 
  'Rhamnus californica'
final.plant.sp[final.plant.sp=='Fremontodendron californicum'] <-
  'Fremontodendron californica'
final.plant.sp[final.plant.sp=='Yellow aster'] <- ''
D$final.plant.sp <- final.plant.sp

## udpate site names
site <- as.character(D$site)
site[site=='MullerControl'] <- 'MC1'
D$site <- site

## make names consistent with those used in later years
names(D) <- c('UniqueID', 'TempID', 'BeeNonbee', 'GeneralID', 'Order',
              'Family', 'Genus', 'SubGenus', 'Species', 'SubSpecies',
              'Author', 'Sex', 'Determiner', 'DateDetermined', 'Site',
              'SiteStatus', 'SampleRound', 'Date', 'Collector',
              'NetPan', 'PanColor', 'PanNumber', 'NetNumber',
              'PlantSp', 'FinalPlantSp', 'Notes', 'StartTime',
              'EndTime', 'TempStart', 'TempEnd', 'WindStart',
              'WindEnd', 'SkyStart', 'SkyEnd', 'WeatherNotes',
              'Country', 'State', 'County', 'PanDistance',
              'PanLocation', 'PanOrientation', 'Group', 'DataEntry',
              'Project')

write.csv(D, file='my_data/2006-2011/cleaned/specimen.csv',
          row.names=FALSE)
