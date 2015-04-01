rm(list=ls())
source('src/misc.R')
cat('clean/baci_2006_2010.R\n')

## **************************************************
d.orig <- read.csv('original/2006-2011/baci_2006_2010.csv')

## drop empty pan rows as they were only recorded for 2008
d.orig <-
  d.orig[-which(tolower(fix.white.space(d.orig$Bee.NonBee))=='empty pan'),]

n.entries <- dim(d.orig)[1]

## **************************************************
## unique.id
D <- as.character(d.orig$Unique.ID)
## general.id also needs updating here
D.general_id <- as.character(d.orig$General.ID)
D.general_id[D=='Alfalfa butterfly'] <- 'alfalfa butterfly'
D.general_id[D=='Alfalfa Butterfly'] <- 'alfalfa butterfly'
D.general_id[D=='Bombus'] <- 'bumblebee'
D.general_id[D=='Bombus Queen'] <- 'bumblebee queen'
D.general_id[D=='Green and Black Beetle'] <-
  'green and black beetle'
D.general_id[D=='Green Ladybug Beetle'] <-
  'green ladybug beetle'
D.general_id[D=='Honey Bee'] <- 'honeybee'
D.general_id[D=='Ladybug Beetle'] <- 'ladybug beetle'
d.orig$general_id <- D.general_id

D[D == 'Unclear whether Bombus collected or caught and released'] <- ''
D[D == 'Xylocopa'] <- ''
D[D=='Beetle'] <- ''
D[D=='fly'] <- ''
D[D=='Empty Pan'] <- ''
D[D=='Honey Bee'] <- ''
D[D=='lep'] <- ''
D[D=='Lepidoptera'] <- ''
D[D=='Alfalfa butterfly'] <- ''
D[D=='Alfalfa Butterfly'] <- ''
D[D=='Bombus'] <- ''
D[D=='Bombus Queen'] <- ''
D[D=='Green and Black Beetle'] <- ''
D[D=='Green Ladybug Beetle'] <- ''
D[D=='Ladybug Beetle'] <- ''

unique.id <- D

## **************************************************
## temp.id
temp.id <- d.orig$Database..

## **************************************************
## bee.nonbee
bee.nonbee <- tolower(fix.white.space(d.orig$Bee.NonBee))
bee.nonbee[bee.nonbee=='nonbee'] <- 'non-bee'
bee.nonbee[bee.nonbee=='empty pan'] <- ''
bee.nonbee[bee.nonbee=='bee?'] <- ''
bee.nonbee[bee.nonbee=='non-bee?'] <- ''

## **************************************************
## general.id
D <- tolower(fix.white.space(d.orig$General.ID))
D[D=='unknown'] <- ''
D[D=='honey bee'] <- 'honeybee'
D[D=='bumble bee'] <- 'bumblebee'
general.id <- D

## **************************************************
## order
order <- fix.white.space(d.orig$Order)
order[order=='?'] <- ''
## family
family <- fix.white.space(d.orig$Family)
family[family=='bug'] <- ''
## genus
genus <- fix.white.space(d.orig$Genus)
non.genus.labels <- c('Ant', 'beetle', 'Beetle', 'bug', 'Bug',
                      'Bug/Beetle', 'Butterfly', 'dragonfly',
                      'Dragonfly', 'Empty Pan', 'fly', 'Fly', 'Fly?',
                      'Grasshopper', 'Green and Black Beetle',
                      'lepidoptera', 'Lepidoptera', 'Moth',
                      'Moth/Fly', 'NonBee', 'Spider', 'tachinid fly',
                      'True Bug', 'wasp', 'Wasp', 'wasp?', 'Wasp?',
                      'Wasp/Fly?')
genus[genus%in%non.genus.labels] <- ''
## sub.genus
sub.genus <- fix.white.space(d.orig$sub.genus)

## species/sub.species
##
## update typos/inconsistencies in sub.species and then update both
## species and sub.species
sub.species <- fix.white.space(d.orig$sub.species)
sub.species[sub.species=='nr. A'] <- 'A'
sub.species[sub.species=='nr. AM'] <- 'AM'
sub.species[sub.species=='BM'] <- 'BM'
sub.species[sub.species=='3M'] <- '3M'
sub.species[sub.species=='bug'] <- ''

species <- fix.white.space(d.orig$Species)
species[species=='conspicuous'] <- 'conspicuus'
species[species=='Ligatus'] <- 'ligatus'
species[species=='spp.'] <- 'sp.'
species[species=='sp.' & sub.species==''] <- ''
species[species=='longistyles'] <- 'longistylis'

sub.species[species=='sp. A'] <- 'A'
species[species=='sp. A'] <- 'sp.'
sub.species[species=='sp. B'] <- 'B'
species[species=='sp. B'] <- 'sp.'
sub.species[species=='sp. D'] <- 'D'
species[species=='sp. D'] <- 'sp.'

## **************************************************
## author
author <- fix.white.space(d.orig$Author)
author[author=='Ckll&Sndhse'] <- 'Cockerell & Sandhouse'
author[author=='Osten Sacken'] <- 'Sacken'
author[author=='SAy'] <- 'Say'
first <- substr(author, 1, 1)
author[which(first=='(')] <-  substr(author[which(first=='(')], 2,
                                     nchar(author[which(first=='(')])-1)

## **************************************************
## sex
sex <- fix.white.space(d.orig$Sex)
sex[sex=='label says \'wrong association M/F\''] <- ''

## **************************************************
## determiner
determiner <- fix.white.space(d.orig$Determiner)
f.r <- function(find, replace) {
  tmp <- unique(grep(find, determiner, value=TRUE))
  tmp <- as.vector(unlist(sapply(tmp, function(x)
                                 which(determiner==x))))
  determiner[tmp] <- replace
  determiner
}
determiner <- f.r(find='Thorp', replace='R. Thorp')
determiner <- f.r(find='Hauser', replace='M. Hauser')
determiner <- f.r(find='Shih', replace='T. Shih')
determiner <- f.r(find='Threatt', replace='A. Harmon-Threatt')

## **************************************************
## date.determined
D <- fix.white.space(d.orig$Date.Determined)
split.dd <- sapply(D, strsplit, split='-')
lengths <- sapply(split.dd, length)
D[lengths==2] <- 'Mar-2009'
year <- sapply(split.dd[lengths==3], function(x)
               paste(20, x[3], sep=''))
month <- sapply(split.dd[lengths==3], function(x) x[2])
day <- sapply(split.dd[lengths==3], function(x) x[1])
D[lengths==3] <- paste(day, month, year, sep='-')
D[D=='01-Jun-2006'] <- '2006-06-01'
D[D=='02-Jul-2008'] <- '2008-07-02'
D[D=='05-Jul-2006'] <- '2006-07-05'
D[D=='06-Jul-2006'] <- '2006-07-06'
D[D=='08-Jul-2006'] <- '2006-07-08'
D[D=='12-Apr-2011'] <- '2011-04-12'
D[D=='12-Aug-2006'] <- '2006-08-12'
D[D=='16-Jun-2006'] <- '2006-06-16'
D[D=='18-Jun-2006'] <- '2006-06-18'
D[D=='19-Jun-2006'] <- '2006-06-19'
D[D=='20-Jun-2007'] <- '2007-06-20'
D[D=='21-Jul-2008'] <- '2008-07-21'
D[D=='22-Jan-2010'] <- '2010-01-22'
D[D=='28-May-2006'] <- '2006-05-28'
D[D=='Mar-2009'] <- '2009-03'
date.determined <- D

## **************************************************
## site
site <- fix.white.space(d.orig$Site)
site[which(site=='Parcell')] <- 'Butler'
site[which(site=='Fence')] <- 'Barger'

## **************************************************
## site.status
site.status <- fix.white.space(d.orig$Site.Status)
site.status[site=='Fong' & site.status=='NA'] <- 'reference site'
site.status[site=='CLBL' & site.status=='NA'] <- 'reference site'
site.status[site.status=='H'] <- 'R'
site.status[site.status=='R/TBR (see metadata)'] <- 'TBR'

## **************************************************
## sample.round
sample.round <- d.orig$SR

## **************************************************
## date
date <- as.Date(fix.white.space(d.orig$Date), format='%Y-%m-%d')

## **************************************************
## collector
D <- fix.white.space(d.orig$Collector)
## clean up the white space around the slashes
tmp <- strsplit(as.character(D), '/ ')
D <- sapply(tmp, function(x) paste(x, collapse='/'))
D <- strsplit(as.character(D), '/')
D <- lapply(D, sort)
collector <- sapply(D, function(x) paste(x, collapse='/'))

## **************************************************
## net.pan
net.pan <- tolower(as.character(d.orig$net.pan))

## **************************************************
## pan.color
pan.color <- fix.white.space(d.orig$Field.ID.Pan.Color)
pan.color[net.pan=='net'] <- ''
pan.color[pan.color=='NA'] <- ''
pan.color[pan.color=='Blue'] <- 'b'
pan.color[pan.color=='White'] <- 'w'
pan.color[pan.color=='White/Yellow'] <- ''
pan.color[pan.color=='Yellow'] <- 'y'

## **************************************************
## pan.number
pan.number <- fix.white.space(d.orig$Pan.Number)
pan.number[pan.number=='NA'] <- ''

## **************************************************
## net.number
net.number <- rep('', n.entries)

## **************************************************
## plant.sp 
plant.sp <- fix.white.space(d.orig$Plant.Species)
plant.sp[net.pan=='pan'] <- ''

## **************************************************
## final.plant.sp
D <- fix.white.space(d.orig$Final.Plant.Species.ID)
D[net.pan=='pan'] <- ''
## first deal with missing floral data
missing <- unique(c(grep('missing', D, value=TRUE),
                    grep('no f', D, value=TRUE),
                    grep('net', D, value=TRUE),
                    grep('pan', D, value=TRUE)))
no.floral <- as.vector(unlist(sapply(missing, function(x)
                                     which(D==x)))) 
D[no.floral] <- ''
## Brassicas
D[D=='Brassica sp./ Hirschfeldia sp.'] <- 'Brassica sp.'
D[D=='Brassica nigra/Hirschfeldia incana'] <- 'Brassica sp.'
## Lavander
D[D=='Lavandula officianalis var (?)'] <- 'Lavandula officinalis'
D[D=='Lavandula sp.'] <- 'Lavandula officinalis'
## Polygonum sp. 
D[D=='Polygonum arenastrum (P. aviculare)'] <- 'Polygonum arenastrum'
D[D=='Polygonum argyrocoleon'] <- 'Polygonum arenastrum'
## Salvia
D[D=='Salvia sp. #1'] <- 'Salvia sp.'
D[D=='Salvia sp. #2'] <- 'Salvia sp.'
## Sonchus
D[D=='Sonchus asper'] <- 'Sonchus sp.'
D[D=='Sonchus asper/oleraceus'] <- 'Sonchus sp.'
D[D=='Sonchus oleraceus'] <- 'Sonchus sp.'
## misc
D[D=='Aster chilense'] <- 'Aster chilensis'
D[D=='Fremontia sp.'] <- 'Fremontodendron californica'
D[D=='Echinacea sp.'] <- 'Echinacea purpurea'
D[D=='Pedicularis sp.'] <- 'Pedicularis densiflora'
D[D=='Penstemon?'] <- 'Penstemon sp.'
D[D=='Phacelia sp.'] <- 'Phacelia californica'
D[D=='Sambucus sp.'] <- 'Sambucus mexicana'
D[D=='Trifolium sp.'] <- 'Trifolium pratense'
D[D=='Ceonothus Sp.'] <- 'Ceonothus sp.'
D[D=='Vicia Sp.'] <- 'Vicia sp.'
D[plant.sp=='Vicia americana'] <-  'Vicia americana'
D[plant.sp=='white marrubium-like'] <- 'Marrubium vulgare' 
final.plant.sp <- D

## **************************************************
## notes 
notes <- fix.white.space(d.orig$Notes)

## **************************************************
## useful function for below
remove.non.entries <- function(d) {
  d[d=='missing from datasheet'] <- ''
  d[d=='no data on data sheet'] <- ''
  d[d=='no datasheet'] <- ''
  d[d=='not recorded'] <- ''
  d
}

## **************************************************
## start.time / end.time
start.time <- fix.white.space(d.orig$start.time)
start.time <- remove.non.entries(start.time)
end.time <- fix.white.space(d.orig$end.time)
end.time <- remove.non.entries(end.time)

## **************************************************
## temp.start / temp.end 
temp.start <- fix.white.space(d.orig$Temp..oC..start)
temp.start <- remove.non.entries(temp.start)
temp.end <- fix.white.space(d.orig$Temp..oC..end)
temp.end <- remove.non.entries(temp.end)

## **************************************************
## wind.start / wind.end
wind.start <- fix.white.space(d.orig$Wind..m.s..start)
wind.start <- remove.non.entries(wind.start)
wind.start[wind.start=='low'] <- ''
wind.end <- fix.white.space(d.orig$Wind..m.s..end)
wind.end <- remove.non.entries(wind.end)
wind.end[wind.end=='none'] <- ''

## **************************************************
## sky.start / sky.end
sky.start <- tolower(fix.white.space(d.orig$Sky.start))
sky.start <- remove.non.entries(sky.start)
sky.end <- tolower(fix.white.space(d.orig$Sky.end))
sky.end <- remove.non.entries(sky.end)
sky.end[sky.end=='p cloudy'] <- 'partly cloudy'
sky.end[sky.end=='clear/clear'] <- 'clear'

## ## **************************************************
## ## weather.start / weather.end
## weather.start <- fix.white.space(d.orig$Weather.Start)
## weather.start[weather.start=='see \'bee notes\' worksheet'] <- ''
## weather.end <- fix.white.space(d.orig$Weather.End)
## weather.end[weather.end=='see \'bee notes\' worksheet'] <- ''

## **************************************************
## weather.notes
weather.notes <- fix.white.space(d.orig$Weather.Notes)
 
## **************************************************
## country / state / county
country <- fix.white.space(as.character(d.orig$Country))
state <- fix.white.space(as.character(d.orig$State))
county <- fix.white.space(as.character(d.orig$County))

## *******************************************************
## make new dataset
dd <- data.frame(unique.id,
                 temp.id,
                 bee.nonbee,
                 general.id,
                 order,
                 family,
                 genus,
                 sub.genus,
                 species,
                 sub.species,
                 author,
                 sex,
                 determiner,
                 date.determined,
                 site,
                 site.status,
                 sample.round,
                 date,
                 collector,
                 net.pan,
                 pan.color,
                 pan.number,
                 net.number,
                 plant.sp,
                 final.plant.sp,
                 notes,
                 start.time,
                 end.time,
                 temp.start,
                 temp.end,
                 wind.start,
                 wind.end,
                 sky.start,
                 sky.end,
                 weather.notes,
                 country,
                 state,
                 county)

write.csv(dd, file='my_data/2006-2011/cleaned/baci_2006_2010.csv',
          row.names=FALSE)
