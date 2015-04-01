## ************************************************************
setwd("~/Dropbox/occupancy")
rm(list=ls())
source("data/src/misc.R")

dir <- "data/original/functional_traits"
traits.temp <- 
  read.csv(file.path(dir, "neal/bee-traits.csv"), as.is=TRUE)
it.span  <- 
  read.csv(file.path(dir, "neal/bee-itspan.csv"), as.is=TRUE)

## in the original database, "NA" was used for cases where a parasitic
## bee was coded for sociality, lecty, or excavation/renting -- I'm
## replacing these with 'parasite'
traits.temp[is.na(traits.temp)] <- "parasite"
## in the original database, "UK" was used for unknown, I'm replacing
## with ""
traits.temp[traits.temp=="UK"] <- ""

## Fixing some spelling errors:
gsp <- traits.temp$g_sp
gsp[gsp=="Synhalonia amsinckia"] <- "Synhalonia amsinckiae"
gsp[gsp=="Anthidium mormonorum"] <- "Anthidium mormonum"
gsp[gsp=="Xylocopa"]             <- "Xylocopa tabaniformis"
gsp[gsp=="Dialictus sp A"]       <- "Dialictus incompletum"
gsp[gsp=="Andrena cressonii infaseiata"] <- "Andrena cressonii infasciata"
gsp <- gsub("sp 1m", "sp 1M", gsp)
gsp <- gsub("sp 2m", "sp 2M", gsp)
gsp <- gsub("sp 3m", "sp 3M", gsp)
gsp <- gsub("sp 4m", "sp 4M", gsp)
gsp <- gsub("sp 5m", "sp 5M", gsp)
gsp <- gsub("sp 6m", "sp 6M", gsp)
gsp <- gsub("sp 7m", "sp 7M", gsp)
gsp <- gsub("sp 8m", "sp 8M", gsp)
gsp <- gsub("sp 8m", "sp 9M", gsp)
gsp <- gsub("sp 10m", "sp 10M", gsp)
gsp <- gsub("sp Dm", "sp DM", gsp)
traits.temp$g_sp <- gsp

## issues 1. there are species/subspecies that need to be merged,
## (Jessica notes that there are no sub-species in Ascher and
## Pickering 2012 world bee species list on Discover Life, therefore
## she dropped any sub-sp designations; nonetheless I decided to keep
## the sub-species designations since these come from Robbin's IDs and
## should be useful for matching names between HR and Neal's datasets,
## also there should not be more than one sub-sp per species-- so the
## subsp designation can always be dropped later).  Also Jessica notes
## there may be some spelling errors in Neal's subsp designations.
## For Sphecodes, Nomada they use numbers for morphospecies and we
## have letters.  Would need to check this match up with Robbin.
sp <- it.span$Species
sp[sp=="Andrena cressonii"]    <- "Andrena cressonii infasciata"
sp[sp=="Anthidiellum notatum"] <- "Anthidiellum notatum robertsoni" 
sp[sp=="Ashmeadiella aridula"] <- "Ashmeadiella aridula astragali"
sp[sp=="Hoplitis albifrons"] <- "Hoplitis albifrons maura"
sp[sp=="Hoplitis fulgida"] <- "Hoplitis fulgida platyura"
sp[sp=="Osmia montana quadriceps"] <- "Osmia montana"
sp[sp=="Perdita heliotropium"] <- "Perdita heliotropium perducta"
sp[sp=="Svastra obliqua"]      <- "Svastra obliqua expurgata"
sp[sp=="Synhalonia frater"]    <- "Synhalonia frater albopilosa"
it.span$Species <- sp

## re-merge the corrected data
guild.data <- merge(traits.temp, it.span,
                    by.x="g_sp", by.y="Species",
                    all=TRUE, sort=TRUE) 

## Issue 2.  Note that IT span in Neal's dataset often not matching
## mean ITspan in jessica's dataset.  The reason for this is that
## earlier, measurements were taken on bees from outside the region
## (from USDA collection in Utah) and on male or female bees.
## Jessica's measurements all from yolo bees and all females.  Thus,
## the IT span measurement from Neal's trait database should be
## dropped, except for qualitative uses (such as deciding which
## species to be in a common guild for Lonsdorf modeling).  For
## community traits database I will drop this column, and we will need
## to measure those species, as needed.

## Merge traits data with BACI HR data along with pan vs net columns

## Making names in d.neal.traits consistent with HR species databases
gsp <- gsub("Dialictus", "Lasioglossum (Dialictus)", guild.data$g_sp)
gsp <- gsub("Evylaeus", "Lasioglossum (Evylaeus)", gsp)
gsp <- gsub("Synhalonia", "Eucera", gsp)
gsp[gsp=="Lasioglossum (Dialictus) incompletum"]  <- 
  "Lasioglossum incompletum"
gsp[gsp=="Lasioglossum (Dialictus) tegulariforme"]  <- 
  "Lasioglossum tegulariforme" 
gsp[gsp=="Triepeolus timberlakeii"] <-
  "Triepeolus timberlakei"
gsp[gsp=="Ashmeadiella cactorum"] <-
  "Ashmeadiella cactorum basalis"
gsp[gsp=="Xylocopa tabaniformis"] <-
  "Xylocopa tabaniformis orpifex"
guild.data$g_sp <- gsp

keep <- c("g_sp", "NestLoc", "Excavate", "Sociality",
          "Lecty", "female_ITD", "MeanIT", "Specimen1", "Specimen2",
          "Specimen3", "Specimen4", "Specimen5")
guild.data <- guild.data[,keep]
names(guild.data) <- c("GenusSp", "NestLoc", "Excavate", "Sociality", 
                       "Lecty", "FemaleITD", "MeanITD", "Specimen1", 
                       "Specimen2", "Specimen3", "Specimen4",
                       "Specimen5")

## make some slight adjustments to correct for discrepancies between
## data-sets
guild.genus.sp <- gsub(" sp"," sp.", guild.data$GenusSp)
guild.genus.sp <- gsub("MOR-1M","1M", guild.genus.sp)
guild.genus.sp <- gsub("MOR-2M","2M", guild.genus.sp)
guild.genus.sp <- gsub("MOR-1","1", guild.genus.sp)
guild.data$GenusSp <- guild.genus.sp

## create empty entries for species we have that are not present in
## Neal's data set
dd <- read.csv("data/my_data/relational/traditional/specimens-complete.csv")
dd <- dd[dd$BeeNonbee=="bee",]

gsp <- fix.white.space(paste(dd$Genus,
                             dd$SubGenus,
                             dd$Species,
                             dd$SubSpecies))

gsp.id <- id(gsp)
not.present <- setdiff(gsp.id, guild.data$GenusSp)
guild.data.addition <- guild.data[rep(1, length(not.present)),]
guild.data.addition[,] <- ""
guild.data.addition$GenusSp <- not.present

guild.data.total <- rbind(guild.data, guild.data.addition)

meanITD <- as.numeric(guild.data$MeanITD)
from.neal <- rep("yes", length(meanITD))
from.neal[is.na(from.neal)] <- "no"

guild.data.total$Neal <-
  c(from.neal, rep("no", nrow(guild.data.addition)))

InKremen <- rep("no", nrow(guild.data.total))
InKremen[guild.data.total$GenusSp %in% gsp] <- "yes"
guild.data.total$InKremen <- InKremen

guild.data.total[is.na(guild.data.total)] <- ""
guild.data.total[guild.data.total==0] <- ""
guild.data.total <- guild.data.total[guild.data.total$GenusSp!="",]
guild.data.total <- guild.data.total[order(guild.data.total$GenusSp),]

write.csv(guild.data.total,
          "data/my_data/functional_traits/neal/bee-traits.csv",
          row.names=FALSE)
