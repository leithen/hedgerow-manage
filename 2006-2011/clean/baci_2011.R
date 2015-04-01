rm(list=ls())
source("src/misc.R")
cat("clean/baci_2011.R\n")

## **************************************************
d.orig <- read.csv("original/2006-2011/baci_2011.csv")
n.entries <- dim(d.orig)[1]

## **************************************************
## unique.id
unique.id <- fix.white.space(d.orig$Unique.ID)

## **************************************************
## temp.id
temp.id <- as.character(d.orig$Temp.ID.)

## **************************************************
## bee.nonbee
bee.nonbee <- tolower(as.character(d.orig$Bee.NonBee))
bee.nonbee[bee.nonbee=="nonbee"] <- "non-bee"
bee.nonbee[bee.nonbee=="bee?"] <- ""
bee.nonbee[bee.nonbee=="non-bee?"] <- ""

## **************************************************
## general.id
D <- tolower(fix.white.space(d.orig$General.ID))
D[D=="bumblebee"] <- "bumblebee"
D[D=="tdb"] <- "tiny dark bee"
D[D=="sdb"] <- "tiny dark bee"
D[D=="shbb"] <- "striped hairy belly bee"
D[D=="hlb"] <- "hairy leg bee"
D[D=="ssb"] <- "striped sweat bee"
D[D=="mhbb"] <- "metallic hairy belly bee"
D[D=="ssb med"] <- "medium striped sweat bee"
D[D=="tdb drt"] <- "tiny dark bee, dull round tip"
D[D=="hopper"] <- "plant hopper"
general.id <- D

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

## **************************************************
## author
D <- fix.white.space(d.orig$Author)
D[D=="Cockerell&Sandhouse"] <- "Cockerell & Sandhouse"
D[D=="F. Smith"] <- "Smith"
D[D=="Nyland"] <- "Nylander"
author <- D

## **************************************************
## sex
sex <- tolower(fix.white.space(d.orig$Sex))
sex[sex=="queen"] <- "f"

## **************************************************
## determiner
determiner <- fix.white.space(d.orig$Determiner)

## **************************************************
## date.determined
date.determined <- fix.white.space(d.orig$Date.Determined)

## **************************************************
## site
site <- fix.white.space(d.orig$Site)

## **************************************************
## site.status
site.status <- fix.white.space(d.orig$Site.Status)

## **************************************************
## sample.round
sample.round <- d.orig$SR

## **************************************************
## date
date <- as.Date(fix.white.space(d.orig$Date), format='%Y-%m-%d')

## **************************************************
## collector
collector <- fix.white.space(d.orig$Collector)

## **************************************************
## net.pan
net.pan <- fix.white.space(d.orig$net.pan)

## **************************************************
## pan.color
D <- tolower(fix.white.space(d.orig$Field.ID.Pan.Color))
pan.color <- rep("", length(D))
pan.color[net.pan=="pan"] <- D[net.pan=="pan"]

## **************************************************
## pan.number
pan.number <- as.character(d.orig$Pan.Sweep.Number)
pan.number[net.pan=="net"] <- ""

## **************************************************
## net.number
net.number <- as.character(d.orig$Pan.Sweep.Number)
net.number[net.pan=="pan"] <- ""
net.number[net.number=="NR"] <- ""

## **************************************************
## plant.sp 
plant.sp <- fix.white.space(d.orig$Plant.Species)
plant.sp[plant.sp=="Convolvolus arvensis"] <- "Convolvulus arvensis"

## **************************************************
## final.plant.sp
D <- fix.white.space(d.orig$Final.Plant.Species.ID)
D[D=="Convolvolus arvensis"] <- "Convolvulus arvensis"
D[net.pan=="pan"] <- ""
final.plant.sp <- D

## **************************************************
## notes 
notes <- fix.white.space(d.orig$Notes)

## **************************************************
## start.time / end.time
start.time <- d.orig$start.time
end.time <- d.orig$end.time

## **************************************************
## temp.start / temp.end 
temp.start <- fix.white.space(d.orig$Temp..oC..start)
temp.end <- fix.white.space(d.orig$Temp..oC..end)
temp.start[temp.start=="nr"] <- ""
temp.end[temp.end=="nt"] <- ""
temp.end[temp.end=="nr"] <- ""

## **************************************************
## wind.start / wind.end
wind.start <- fix.white.space(d.orig$Wind..m.s..start)
wind.end <- fix.white.space(d.orig$Wind..m.s..end)
wind.start[wind.start=="nr"] <- ""
wind.end[wind.end=="nt"] <- ""

## **************************************************
## sky.start / sky.end
sky.start <- fix.white.space(d.orig$Sky.start)
sky.end <- fix.white.space(d.orig$Sky.end)

## **************************************************
## weather.notes
weather.notes <- fix.white.space(d.orig$Weather.Notes)
 
## **************************************************
## country / state / county
country <- fix.white.space(d.orig$Country)
state <- fix.white.space(d.orig$State)
county <- fix.white.space(d.orig$County)

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

write.csv(dd, file="my_data/2006-2011/cleaned/baci_2011.csv",
          row.names=FALSE)
