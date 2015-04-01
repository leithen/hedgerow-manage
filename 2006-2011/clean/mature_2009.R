rm(list=ls())
source("src/misc.R")
cat("clean/mature_2009.R\n")

## **************************************************
d.orig <- read.csv("original/2006-2011/mature_2009.csv")
n.entries <- dim(d.orig)[1]

## **************************************************
## unique.id
D <- as.character(d.orig$Barcode)
## general.id and genus also need updating here
general.id <- as.character(d.orig$General.ID)
general.id[D=="Carpenter Bee"] <- "Carpenter Bee"
d.orig$General.ID <- general.id
genus <- d.orig$Genus
genus[D=="Bombus"] <- "Bombus"
genus[D=="Carpenter Bee"] <- "Xylocopa"
d.orig$Genus <- genus
D[D=="Bombus"] <- ""
D[D=="Bombus vosnesenskii"] <- ""
D[D=="Dialictus"] <- ""
D[D=="honeybee"] <- ""
D[D=="Carpenter Bee"] <- ""
unique.id <- D

## **************************************************
## temp.id
temp.id <- d.orig$Temp.ID

## **************************************************
## bee.nonbee
bee.nonbee <- tolower(fix.white.space(d.orig$Bee.NonBee))
bee.nonbee[bee.nonbee=="nonbee"] <- "non-bee"
bee.nonbee[bee.nonbee=="bee?"] <- ""
bee.nonbee[bee.nonbee=="non-bee?"] <- ""

## **************************************************
## general.id
D <- tolower(fix.white.space(d.orig$General.ID))
D[D=="b. vos."] <- "bumblebee"
D[D=="bumble bee"] <- "bumblebee"
D[D=="gsb"] <- "green sweat bee"
D[D=="tdb"] <- "tiny dark bee"
D[D=="hlb"] <- "hairy leg bee"
D[D=="hbb"] <- "hairy belly bee"
D[D=="ssb"] <- "striped sweat bee"
D[D=="small dark bee"] <- "tiny dark bee"
tmp <-
  fix.white.space(d.orig$Genus.Subgenus.Species.Subspecies)
D[which(tmp=="Native bee")] <- "bee"
general.id <- D

## **************************************************
## group
group <- tolower(fix.white.space(d.orig$Group))
group[group=="honey bee"] <- "honeybee"

## **************************************************
## order
order <- fix.white.space(d.orig$Order)
## family
family <- fix.white.space(d.orig$Family)
## genus
genus <- fix.white.space(d.orig$Genus)
## sub.genus
sub.genus <- fix.white.space(d.orig$Subgenus)
## species
species <- fix.white.space(d.orig$Species)
## sub.species
sub.species <- fix.white.space(d.orig$Subspecies)

tmp <- fix.white.space(d.orig$Genus.Subgenus.Species.Subspecies)
family[tmp=="Syrphidae"] <- "Syrphidae"
genus[tmp=="Bombus sp"] <- "Bombus"
species[tmp=="Bombus sp" & species==""] <- "sp."

species[sub.genus=="Dialictus B"] <- "sp. B"
species[sub.genus=="Dialictus C"] <- "sp. C"
sub.genus[sub.genus=="Dialictus B"] <- "(Dialictus)"
sub.genus[sub.genus=="Dialictus C"] <- "(Dialictus)"
sub.genus[sub.genus=="Dialictus"] <- "(Dialictus)"
sub.genus[sub.genus=="Evylaeus"] <- "(Evylaeus)"

species[species=="B"] <- "sp. B"
species[species=="B sp."] <- "sp. B"
species[species=="E"] <- "sp. E"
species[species=="E sp."] <- "sp. E"
species[species=="J"] <- "sp. J"
species[species=="conspicuous"] <- "conspicuus"
species[species=="teguliforme"] <- "tegulariforme"
species[species=="kinkadii"] <- "kincaidii"
species[genus=="Xylocopa" & species==""] <- "sp."
species[species=="sp." & sub.species==""] <- ""

## fill in some missing families and orders
family[genus=="Bombus"] <- "Apidae"
family[genus=="Svastra"] <- "Apidae"
family[genus=="Xylocopa"] <- "Apidae"
family[genus=="Osmia"] <- "Megachilidae"
family[genus=="Toxomerus"] <- "Syrphidae"
order[family=="Apidae"] <- "Hymenoptera"
order[family=="Megachilidae"] <- "Hymenoptera"
order[family=="Syrphidae"] <- "Diptera"

ind <- which(species=="sp." & sub.species!="")
species[ind] <- paste("sp.", sub.species[ind])
sub.species[ind] <- ""

tmp <- c("sp. 3", "sp. B", "sp. C", "sp. E", "sp. J", "sp. MOR-I",
         "sp. MOR-IM", "sp. MOR-1M", "sp. MOR-2")
for(i in tmp) {
  sub.species[species==i] <- strsplit(i, ". ")[[1]][2]
  species[species==i] <- "sp."
}

## **************************************************
## author
author <- fix.white.space(d.orig$Author)
author[author=="Ckll&Sndhse"] <- "Cockerell & Sandhouse"
author[author=="Osten Sacken"] <- "Sacken"
author[author=="SAy"] <- "Say"
author[author=="Linnaus"] <- "Linnaeus"
author[author=="F. Smith"] <- "Smith"

## **************************************************
## sex
sex <- tolower(as.character(d.orig$Sex))

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
determiner <- f.r(find="Thorp", replace="R. Thorp")
determiner <- f.r(find="Hauser", replace="M. Hauser")

## **************************************************
## date.determined
D <- fix.white.space(d.orig$Date.Determined)
D[D=="12-Apr-11"] <- "2011-04-12"
D[D=="21-Jan-10"] <- "2010-01-21"
D[D=="22-Jan-10"] <- "2010-01-22"
D[D=="23-Jan-10"] <- "2010-01-23"
D[D=="24-Jan-10"] <- "2010-01-24"
date.determined <- D

## **************************************************
## site
site <- fix.white.space(d.orig$Site)
site <- substr(site, 3, nchar(site)) ## first two characters

## **************************************************
## site.status
site.status <- fix.white.space(d.orig$trt)
site.status <- substr(site.status, 1, 1)

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
D <- strsplit(as.character(D), "/ ")
D <- sapply(D, function(x) paste(x, collapse="/"))
D <- strsplit(as.character(D), "/")
D <- lapply(D, sort)
collector <- sapply(D, function(x) paste(x, collapse="/"))

## **************************************************
## net.pan
net.pan <- tolower(as.character(d.orig$Pan.Net.Sweep))

## **************************************************
## pan.color
pan.color <- tolower(fix.white.space(d.orig$Color))

## **************************************************
## pan.distance
pan.distance <- tolower(fix.white.space(d.orig$Distance))
pan.distance[net.pan=="net"] <- ""

## **************************************************
## pan.number
pan.number <- tolower(fix.white.space(d.orig$Orient.No))
pan.number[pan.distance!="0"] <- ""
pan.number <- as.numeric(pan.number)

## **************************************************
## pan.orientation
pan.orientation <- tolower(fix.white.space(d.orig$Orient.No))
pan.orientation[pan.distance=="0"] <- ""

## **************************************************
## pan.location
pan.location <- tolower(fix.white.space(d.orig$location))
pan.location[net.pan=="net"] <- ""

## **************************************************
## net.number
net.number <- rep("", n.entries)

## **************************************************
## plant.sp
plant.sp <-
  fix.white.space(d.orig$Plant.Species.Code.or.Field.Nickname)

## **************************************************
## final.plant.sp
D <- fix.white.space(d.orig$Plant.Species.Pan.info)
## fix unknown data
D[D=="?"] <- ""
D[D=="Unidentified 1 (UID 1)"] <- ""
D[D=="Unidentified 2 (UID 2)"] <- ""
D[D=="Unknown yellow daisy"] <- ""
D[D=="unknown"] <- ""
## fix typos, etc
D[D=="Brassica Sp."] <- "Brassica sp."
D[D=="Sambucus Sp."] <- "Sambucus sp."
D[D=="Rosa sp."] <- "Rosa californica"
D[D=="Malva sp."] <- "Malva neglecta"
D[D=="Eriogonum sp."] <- "Eriogonum fasciculatum"
D[D=="Salvia sp. (white)"] <- "Salvia sp."
D[D=="Salvia sp. (blue)"] <- "Salvia sp."
D[D=="Salvia sp. 1"] <- "Salvia sp."
D[D=="Salvia sp. 3"] <- "Salvia sp."
D[net.pan=="pan"] <- ""
final.plant.sp <- D

## **************************************************
## notes 
notes <- fix.white.space(d.orig$Notes)

## **************************************************
## useful function for below
remove.non.entries <- function(d) {
  d[d=="missing from datasheet"] <- ""
  d[d=="no data on data sheet"] <- ""
  d[d=="no datasheet"] <- ""
  d[d=="not recorded"] <- ""
  d
}

## **************************************************
## stuff not collected
start.time <- rep("", n.entries)
end.time <- rep("", n.entries)
temp.start <- rep("", n.entries)
temp.end <- rep("", n.entries)
wind.start <- rep("", n.entries)
wind.end <- rep("", n.entries)
sky.start <- rep("", n.entries)
sky.end <- rep("", n.entries)
weather.start <- rep("", n.entries)
weather.end <- rep("", n.entries)
weather.notes <- rep("", n.entries)
## **************************************************

## **************************************************
## country / state / county
country <- fix.white.space(as.character(d.orig$country))
state <- fix.white.space(as.character(d.orig$state))
county <- fix.white.space(as.character(d.orig$county))

## **************************************************
## data.entry
data.entry <- rep("", n.entries)

## *******************************************************
## make new dataset
data <- data.frame(unique.id,
                   temp.id,
                   bee.nonbee,
                   general.id,
                   group,
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
                   pan.distance,
                   pan.number,
                   pan.orientation,
                   pan.location,
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
                   county,
                   data.entry)
write.csv(data, file="my_data/2006-2011/cleaned/mature_2009.csv",
          row.names=FALSE)
