update.taxonomy <- function(dd) {
  megachile <- read.csv('manage/taxonomy/2013/Megachile_changes.csv',
                        header=TRUE)

  dd$Species[match(megachile$unique.id, dd$UniqueID)] <-
    as.character(megachile$species)
  dd$SubSpecies[match(megachile$unique.id, dd$UniqueID)] <- ''
  dd$SubSpecies[which(dd$SubSpecies=='MOR-1')] <- '1'
  dd$SubSpecies[which(dd$SubSpecies=='MOR-1M')] <- '1M'
  dd$SubSpecies[which(dd$SubSpecies=='MOR-2M')] <- '2M'

  ## families
  bee.families <- read.csv('original/misc/bee_families.csv')
  known.to.genus <-
    which(dd$BeeNonbee=='bee' & dd$Genus!='')
  ind <- match(dd$Genus[known.to.genus], bee.families$Genus)
  dd$Family[is.na(dd$Family)] <- ''
  dd$Family[known.to.genus] <-
    as.character(bee.families$Family[ind])

  ## add in sub-genera
  dd$SubGenus[which(dd$Species=='incompletum')] <- '(Dialictus)'
  dd$SubGenus[which(dd$Species=='kincaidii')] <- '(Evylaeus)'
  dd$SubGenus[which(dd$Species=='tegulariforme')] <- '(Dialictus)'

  ## taxonomic updates

  ## Lasioglossum (Evylaeus)
  evylaeus.updates <- c(E='nigrescens',
                        K='nigrescens',
                        C='granosum',
                        F='diatretum',
                        G='orthocarpi',
                        H='orthocarpi')
  for(i in seq_along(evylaeus.updates)) {
    ind <- which(dd$Genus=='Lasioglossum' &
                 dd$SubGenus=='(Evylaeus)' &
                 dd$SubSpecies==names(evylaeus.updates)[i])
    if(length(ind)>0) {
      dd$Species[ind] <- evylaeus.updates[i]
      dd$SubSpecies[ind] <- ''
      dd$Determiner[ind] <- 'J. Gibbs'
    }
  }

  ## Lasioglossum (Dialictus)
  dialictus.updates <- c(H='incompletum',
                         R='incompletum',
                         F='impavidum',
                         J='punctatoventre',
                         C='punctatoventre',
                         E='brunneiiventre',
                         I='brunneiiventre',
                         K='megastictum',
                         D='megastictum',
                         B='diversopunctatum',
                         'B-1'='diversopunctatum')
  for(i in seq_along(dialictus.updates)) {
    ind <- which(dd$Genus=='Lasioglossum' &
                 dd$SubGenus=='(Dialictus)' &
                 dd$SubSpecies==names(dialictus.updates)[i])
    if(length(ind)>0) {
      dd$Species[ind] <- dialictus.updates[i]
      dd$SubSpecies[ind] <- ''
      dd$Determiner[ind] <- 'J. Gibbs'
    }
  }

  ind <- which(dd$Species=='tegulariforme')
  dd$Species[ind] <- 'tegulare group'
  dd$Determiner[ind] <- 'J. Gibbs'

  ## plants
  plant <- dd$FinalPlantSp
  plant[grep('Ambrosia', plant)] <- 'Ambrosia sp.'
  plant[grep('Brassica', plant)] <- 'Brassica sp.'
  plant[grep('Lavandula', plant)] <- 'Lavandula officinalis'
  plant[grep('Lupinus', plant)] <- 'Lupinus sp.'
  plant[grep('Malva sp.', plant)] <- 'Malva neglecta'
  plant[grep('Raphanus', plant)] <- 'Raphanus raphanistrum'
  plant[grep('Salvia', plant)] <- 'Salvia sp.'
  plant[grep('Sonchus', plant)] <- 'Sonchus sp.'
  plant[grep('Vicia sp.', plant)] <- 'Vicia americana'
  dd$FinalPlantSp <- plant

  dd
}
