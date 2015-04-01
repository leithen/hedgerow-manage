rm(list=ls())
source('src/misc.R')
source('src/data_entry.R')
cat('2013/add/wasps.R\n')

sp.ids <- list(list(Family='Chrysididae', Genus='Hedychridium',
                 Species='soliarellae', Sex='', TempID=c()),

               list(Family='Chrysididae', Genus='Chrysis',
                 Species='amala', Sex='', TempID=c()),

               list(Family='Chrysididae', Genus='Chrysura',
                 Species='inusitata', Sex='', TempID=c()),

               list(Family='Crabronidae', Genus='Belomicrus',
                 Species='sericeum', Sex='', TempID=c()),

               list(Family='Crabronidae', Genus='Bembix',
                 Species='americana', Sex='', TempID=c()), 

               list(Family='Crabronidae', Genus='Ectemnius',
                 Species='areuatus', Sex='', TempID=c()),

               list(Family='Crabronidae', Genus='Ectemnius',
                 Species='spinifer', Sex='', TempID=c()),

               list(Family='Crabronidae', Genus='Tachytes',
                 Species='distinctus', Sex='',
                 TempID=c()),

               list(Family='Sphecidae', Genus='Prionyx',
                 Species='attratus', Sex='', TempID=c()),

               list(Family='Sphecidae', Genus='Prionyx',
                 Species='parkeri', Sex='', TempID=c(4882)),

               list(Family='Sphecidae', Genus='Sphex',
                 Species='pensylvanicus', Sex='', TempID=c(8665)),

               list(Family='Sphecidae', Genus='Chlorion',
                 Species='aerarium', Sex='', TempID=c()),

               list(Family='Sphecidae', Genus='Chalybion',
                 Species='californicum', Sex='', TempID=c()),

               list(Family='Sphecidae', Genus='Isodontia',
                 Species='elegans', Sex='', TempID=c()),

               list(Family='Sphecidae', Genus='Sceliphron',
                 Species='caementarium', Sex='', TempID=c(3905,
                 5629))) 

add.to.data(year=2013,
            sp.ids=sp.ids,
            case='was',
            determiner='L. S. Kimsey')
