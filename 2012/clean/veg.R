## **************************************************
rm(list=ls())
source('src/misc.R')
cat('2012/clean/veg.R\n')

dd <- read.csv('original/2012/veg.csv')

## **************************************************
## Site
Site <- fix.white.space(as.character(dd$Site))
Site[Site=='Beeman'] <- 'BC2'
Site[Site=='MullerControl'] <- 'MC1'
dd$Site <- Site

## **************************************************
## Date
dd$Date <- as.character(dd$Date)
## drop the following, as this data was discarded
dd <- dd[!(dd$Site=='Butler' & dd$Date=='2012-06-07'),]

## **************************************************
## make syd keys
dd$syd <- make.keys(sites=dd$Site, dates=dd$Date)

## **************************************************
## make a new Transect ID
dd$TransectID <- paste(dd$Site, dd$Date,
                       paste(dd$Position, dd$Quad, sep='-'), sep=';')

## **************************************************
## CoverScore
dd$CoverScore <- gsub(' ', '', dd$CoverScore)
dd$CoverScore <- gsub('plus', '1', dd$CoverScore)
dd$CoverScore[dd$FieldID==''] <- ''
dd$CoverScore[dd$FieldID!='' & dd$CoverScore==''] <- 1

dd <- unique(dd)

## **************************************************
## update 2012 veg data to same format as later years
cover.scores <- paste(dd$CoverScore, dd$FieldID, sep=';')
cover.scores[cover.scores==';'] <- ''
c.by.t <- split(cover.scores, dd$TransectID)
c.by.t <- lapply(c.by.t, function(x) x[x!=''])
c.by.t <- sapply(c.by.t, function(x) paste(unique(x), collapse=','))

## for consistency with earlier years
dd$Quad <- paste(dd$Position, dd$Quad, sep='-')

dd.new <- unique(dd[,c('Site',
                       'Date',
                       'Quad',
                       'TransectID',
                       'syd')])
dd.new$CoverScore <- as.character(c.by.t[match(dd.new$TransectID,
                                               names(c.by.t))])

## **************************************************
## write new dataset
keep <- c('Site', 'Date', 'Quad', 'TransectID',
          'CoverScore', 'syd')
dd.keep <- dd.new[,keep] 
write.csv(dd.keep, file='my_data/2012/cleaned/veg.csv',
          row.names=FALSE)
