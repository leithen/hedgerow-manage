rm(list=ls())
source("src/misc.R")
cat("clean/mature_2011.R\n")

## **************************************************
d.orig <- read.csv("original/2006-2011/mature_2011.csv")
n.entries <- dim(d.orig)[1]

## **************************************************
## unique.id
unique.id <- as.character(d.orig$Unique.ID)

## **************************************************
## temp.id
temp.id <- as.character(d.orig$Temp.ID)

## **************************************************
## bee.nonbee
bee.nonbee <- tolower(fix.white.space(d.orig$Bee.NonBee))
bee.nonbee[bee.nonbee=="nonbee"] <- "non-bee"
bee.nonbee[bee.nonbee=="bee?"] <- ""
bee.nonbee[bee.nonbee=="non-bee?"] <- ""

## **************************************************
## general.id
D <- tolower(fix.white.space(d.orig$General.ID))
D[D=="bumble bee"] <- "bumblebee"
D[D=="tdb"] <- "tiny dark bee"
D[D=="sdb"] <- "tiny dark bee"
D[D=="shbb"] <- "striped hairy belly bee"
general.id <- D

## **************************************************
## group
group <- rep("", n.entries)

## **************************************************
## order
order <- fix.white.space(d.orig$Order)
## family
family <- fix.white.space(d.orig$Family)
## genus
genus <- fix.white.space(d.orig$Genus)
## sub.genus
sub.genus <- fix.white.space(d.orig$sub.genus)
## species
species <- fix.white.space(d.orig$Species)
## sub.species
sub.species <- fix.white.space(d.orig$sub.species)
species[species=="sp." & sub.species==""] <- ""

group[species=="mellifera"] <- "honeybee"
group[bee.nonbee=="bee" & group!="honeybee"] <- "native bee"
group[family=="Syrphidae"] <- "syrphid"

## **************************************************
## author
author <- fix.white.space(d.orig$Author)
author[author=="Cockerell&Sandhouse"] <- "Cockerell & Sandhouse"
author[author=="F. Smith"] <- "Smith"

## **************************************************
## sex
sex <- tolower(fix.white.space(d.orig$Sex))

## **************************************************
## determiner
determiner <- fix.white.space(d.orig$Determiner)

## **************************************************
## date.determined
date.determined <- fix.white.space(d.orig$Date.Determined)

## **************************************************
## site
site <- fix.white.space(as.character(d.orig$Site))

## **************************************************
## site.status
site.status <- fix.white.space(d.orig$Site.Status)
site.status[site.status=="R"] <- "H"

## **************************************************
## sample.round
sample.round <- d.orig$SR

## **************************************************
## date
date <- as.Date(fix.white.space(d.orig$Date), format='%Y-%m-%d')

## **************************************************
## collector
D <- fix.white.space(as.character(d.orig$Collector))
D[D=="Angela Zetter"] <- "A. Zetter"
D[D=="Kenna Lehmann"] <- "K. Lehmann"
D[D=="Natalie Solares"] <- "N. Solares"
D[D=="Rob Hanifin"] <- "R. Hanifin"
D[D=="Sara Kaiser"] <- "S. Kaiser"
collector <- D

## **************************************************
## net.pan
net.pan <- fix.white.space(as.character(d.orig$net.pan))

## **************************************************
## pan.color
pan.color <- tolower(fix.white.space(d.orig$Field.ID.Pan.Color))
pan.color[net.pan=="net"] <- ""

## **************************************************
## pan.distance
pan.distance <- rep(0, n.entries)

## **************************************************
## pan.number
pan.number <- fix.white.space(d.orig$Pan.Sweep.Number)
pan.number[net.pan=="net"] <- ""
pan.number <- as.numeric(pan.number)

## **************************************************
## pan.orientation
pan.orientation <- rep("", n.entries)

## **************************************************
## pan.location
pan.location <- rep("", n.entries)

## **************************************************
## net.number
net.number <- fix.white.space(d.orig$Pan.Sweep.Number)
net.number[net.pan=="pan"] <- ""

## **************************************************
## plant.sp 
plant.sp <- fix.white.space(d.orig$Plant.Species)
plant.sp[plant.sp=="Convolvolus arvensis"] <- "Convolvulus arvensis"

## **************************************************
## final.plant.sp
final.plant.sp <- fix.white.space(d.orig$Final.Plant.Species.ID)
final.plant.sp[final.plant.sp=="Convolvolus arvensis"] <-
  "Convolvulus arvensis"
final.plant.sp[net.pan=="pan"] <- ""

## **************************************************
## notes 
notes <- fix.white.space(d.orig$Notes)

## **************************************************
## start.time / end.time
start.time <- d.orig$start.time
end.time <- d.orig$end.time

## **************************************************
## temp.start / temp.end 
temp.start <- fix.white.space(d.orig$Temp.start)
temp.end <- fix.white.space(d.orig$Temp.end)
temp.start[temp.start=="nr"] <- ""
temp.end[temp.end=="nr"] <- ""

## **************************************************
## wind.start / wind.end
wind.start <- fix.white.space(d.orig$Wind.start)
wind.end <- fix.white.space(d.orig$Wind.end)
wind.start[wind.start=="NA"] <- ""
wind.end[wind.end=="nr"] <- ""

## **************************************************
## sky.start / sky.end
sky.start <- fix.white.space(d.orig$Sky.start)
sky.end <- fix.white.space(d.orig$Sky.end)

## **************************************************
## weather.notes
weather.notes <- rep("", n.entries)

## **************************************************
## country / state / county
country <- fix.white.space(d.orig$Country)
state <- fix.white.space(d.orig$State)
county <- fix.white.space(d.orig$County)

## **************************************************
## data.entry
data.entry <- fix.white.space(d.orig$Data.Entry.by)
data.entry[data.entry=="SK"] <- "S. Kaiser"

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
write.csv(data, file="my_data/2006-2011/cleaned/mature_2011.csv",
          row.names=FALSE) 
