rm(list=ls())
source('src/misc.R')
cat('combine/honeybee.R\n')

## *******************************************************
## combine mature and baci datasets
## *******************************************************
B <- read.csv('my_data/2006-2011/cleaned/baci_honeybee.csv')
B$pan.distance <- rep(0, nrow(B))

M <- read.csv('my_data/2006-2011/cleaned/mature_honeybee.csv')

common.names <- intersect(names(B), names(M))
D <- rbind(B[,common.names], M[,common.names])

## make project key
D$project <- c(rep('kremen-baci', nrow(B)),
               rep('kremen-mature', nrow(M)))

date <- as.Date(D$date, format='%Y-%m-%d')
year <- as.numeric(format(date, format = '%Y'))

## update site statuses
status <- as.character(D$site.status)
status[status=='C' | status=='TBR']            <- 'control'
status[status=='H' | status=='reference site'] <- 'mature'
status[status=='R']                            <- 'restored'
status[D$site=='Hrdy'      & year>=2009]       <- 'maturing'
status[D$site=='Butler'    & year>=2009]       <- 'maturing'
status[D$site=='MullerB'    & year>=2009]      <- 'maturing'
status[D$site=='Sperandio' & year>=2011]       <- 'maturing'
status[D$site=='Barger'    & year>=2011]       <- 'maturing'
status[D$site=='Bobcat']                       <- 'reference'
D$site.status <- status

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
final.plant.sp[final.plant.sp=='Fremontodendron californicum'] <-
  'Fremontodendron californica'
final.plant.sp[final.plant.sp=='Yellow aster'] <- ''
D$final.plant.sp <- final.plant.sp

write.csv(D, file='my_data/2006-2011/cleaned/honeybee.csv',
          row.names=FALSE)
