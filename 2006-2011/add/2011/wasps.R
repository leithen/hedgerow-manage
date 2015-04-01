rm(list=ls())
source('src/misc.R')
cat('add/2011/wasps.R\n')

sp.ids <- list(list(Family='Chrysididae', Genus='Hedychridium',
                    Species='soliarellae', Sex='',
                    UniqueID=c('M2011SR2Hrdy_14640',
                    'M2011SR1USS_3983', 'M2009SR3Barger_25',
                    'M2009SR2Gregory_139', 'M2011SR1Gregory_2923',
                    'M2011SR2USS_12683', 'M2011SR2Spiva_13860',
                    'M2011SR2Spiva_13859', 'M2011SR3BC2_15067',
                    'M2011SR1Butler_2037', 'M2011SR1Hrdy_5470')),

               list(Family='Chrysididae', Genus='Hedychridium',
                    Species='paulum', Sex='',
                    UniqueID=c('M2011SR2USS_12673',
                    'M2009SR2Gregory_123')),

               list(Family='Chrysididae', Genus='Chrysis',
                    Species='scitule', Sex='',
                    UniqueID=c('M2009SR1Muller_71')),

               list(Family='Chrysididae', Genus='Chrysis',
                    Species='amala', Sex='',
                    UniqueID=c('Morandin2011_4498')),

               list(Family='Chrysididae', Genus='Chrysura',
                    Species='pacifica', Sex='',
                    UniqueID=c('M2008SR1MC1_041',
                    'M2008SR1Sporandio_002', 'M2008SR1MC1_040')),

               list(Family='Chrysididae', Genus='Chrysura',
                    Species='sagmatis', Sex='',
                    UniqueID=c('M2009SR1BC2_152')),

               list(Family='Chrysididae', Genus='Chrysura',
                    Species='inusitata', Sex='',
                    UniqueID=c('M2009SR1BC2_161')),

               list(Family='Sphecidae', Genus='Sceliphron',
                    Species='caementarium', Sex='',
                    UniqueID=c('M2007SR2Muller_045',
                    'M2009SR2Muller_74')),

               list(Family='Sphecidae', Genus='Isodontia',
                    Species='elegans', Sex='',
                    UniqueID=c('M2007SR2Turkovitch_032',
                    'M2008SR2Fong_002', 'M2007SR2Turkovitch_033')),

               list(Family='Sphecidae', Genus='Prionyx',
                    Species='thomae', Sex='',
                    UniqueID=c('M2007SR3H16_034')),

               list(Family='Crabronidae', Genus='Tachytes',
                    Species='distinctus', Sex='',
                    UniqueID=c('Morandin2011_14129',
                    'M2008SR2Fong_001', 'M2008SR2Fong_003',
                    'M2008SR2Muller_007', 'M2011SR3Muller_15614')),

               list(Family='Crabronidae', Genus='Aporinellus',
                    Species='fasciatus', Sex='',
                    UniqueID=c('M2008SR2BC2_015')),

               list(Family='Crabronidae', Genus='Ectemnius',
                    Species='spinifer', Sex='',
                    UniqueID=c('Morandin2011_4341',
                    'Morandin2011_7324', 'M2011SR1DQU_1072',
                    'M2011SR3Sperandio_18386', 'Morandin2011_13338',
                    'Morandin2011_14150', 'Morandin2011_13569',
                    'Morandin2011_19204', 'M2009SR2Spiva_89')),

               list(Family='Crabronidae', Genus='Belomicrus',
                    Species='sericeum', Sex='',
                    UniqueID=c('Morandin2011_4366')),
               
               ## the following was id-ed by J.M. Carpenter 2012
               
               list(Family='Vespidae', Genus='Polistes',
                    Species='dorsalis', SubSpecies='californicus',
                    Sex='', UniqueID=c('M2008SR2Muller_019',
                    'M2008SR2Muller_040', 'M2008SR1Butler_036',
                    'M2009SR1Hrdy_1')),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Polistes',
                    Species='dominula', Sex='',
                    UniqueID=c('M2008SR2DQU_021',
                    'M2011SR1Muller_3080', 'M2011SR1Muller_3081',
                    'M2011SR1Muller_3082', 'M2011SR3Muller_15629',
                    'M2009SR1Butler_81', 'M2009SR1Hrdy_2',
                    'M2009SR1Muller_32', 'M2008SR2DQU_029',
                    'M2009SR3Sporandio_97', 'M2007SR2Muller_044',
                    'M2008SR2DQU_020', 'M2008SR2Muller_021',
                    'M2009SR2DQU_90', 'M2008SR2Gregory_026',
                    'M2007SR1MC1_002', 'Morandin2011_3667')),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Eumenes',
                    Species='crucifera', Sex='',
                    UniqueID=c('Morandin2011_5590')),
               
               ## the following was id-ed by J.M. Carpenter 2013

               list(Family='Vespidae', Genus='Ancistrocerus',
                    Species='lineativentris', Sex='',
                    UniqueID=c('M2011SR2Barger_8451')),
               
               ## the following was id-ed by J.M. Carpenter 2013

               list(Family='Vespidae', Genus='Polistes',
                    Species='aurifer', Sex='',
                    UniqueID=c('M2008SR2Spiva_010',
                    'M2008SR2Muller_041', 'M2008SR2Muller_020',
                    'M2007SR1Muller_027', 'M2009SR1Hrdy_4',
                    'M2009SR3Chamberlain_115', 'M2007SR1Muller_042',
                    'M2011SR1H16_717', 'M2007SR1Muller_026',
                    'Morandin2011_4478', 'Morandin2011_4345',
                    'M2009SR1Hrdy_3', 'Morandin2011_7304')),
               
               ## the following was id-ed by J.M. Carpenter 2013 -
               ## "Turkovitch" misspelled...
               
               list(Family='Vespidae', Genus='Euodynerus',
                    Species='hidalgo', Sex='',
                    UniqueID=c('M2011SR2Butler_8854',
                    'M2008SR3USS_025', 'M2007SR1Turkovitch_007',
                    'M2011SR2Muller_13117')),
               
               ## the following was id-ed by J.M. Carpenter 2013

               list(Family='Vespidae', Genus='Euodynerus',
                    Species='annulatus', Sex='',
                    UniqueID=c('M2007SR3Hrdy_019',
                    'M2007SR3Barger_048', 'Morandin2011_4442',
                    'Morandin2011_4399', 'Morandin2011_4398')),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Stenodynerus',
                    Species='cochisensis', Sex='',
                    UniqueID=c('M2007SR1BC1_001', 'Morandin2011_6410',
                    'Morandin2011_4410', 'Morandin2011_4409',
                    'Morandin2011_4441', 'M2011SR1Turkovich_2465',
                    'M2011SR2Barger_14226', 'M2007SR2Gregory_038',
                    'M2007SR1Muller_010')),

               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Stenodynerus',
                    Species='blandus', Sex='',
                    UniqueID=c('M2008SR2Butler_010',
                    'M2011SR1Gregory_2497', 'M2011SR1Spiva_459',
                    'M2008SR2Fong_052')),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Euodynerus',
                    Species='foraminatus', Sex='',
                    UniqueID=c('M2007SR1Gregory_012')),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Stenodynerus',
                    Species='claremontensis', Sex='',
                    UniqueID=c('Morandin2011_4443',
                    'Morandin2011_4400', 'Morandin2011_4477')),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Leptochilus',
                    Species='rufinodus', Sex='',
                    UniqueID=c('M2009SR3Spiva_546',
                    'M2007SR1Muller_011')),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Leptochilus',
                    Species='irwini', Sex='',
                    UniqueID=c('M2009SR3Spiva_547',
                    'M2008SR1Butler_041'))
               
               )

lengths <- sapply(sp.ids, function(x) length(x$UniqueID))
family <- sapply(sp.ids, function(x) x$Family)
genus <- sapply(sp.ids, function(x) x$Genus)
species <- sapply(sp.ids, function(x) x$Species)
sex <- sapply(sp.ids, function(x) x$Sex)
unique.id <- sapply(sp.ids, function(x) x$UniqueID)
dd <- data.frame(unique.id=unlist(unique.id),
                 family=rep(family, lengths),
                 genus=rep(genus, lengths),
                 species=rep(species, lengths),
                 sex=rep(sex, lengths))

## lood data:
D <- read.csv(file='my_data/2006-2011/cleaned/specimen.csv',
              as.is=TRUE)

ind <- match(dd$unique.id, D$UniqueID)

D$BeeNonbee[ind] <- 'non-bee'
D$Order[ind] <- 'Hymenoptera'
D$Family[ind] <- as.character(dd$family)
D$Genus[ind] <- as.character(dd$genus)
D$Species[ind] <- as.character(dd$species)
D$Sex[ind] <- as.character(dd$sex)
D$Determiner[ind] <- 'L. S. Kimsey'

write.csv(D, file='my_data/2006-2011/cleaned/specimen.csv',
          row.names=FALSE)
