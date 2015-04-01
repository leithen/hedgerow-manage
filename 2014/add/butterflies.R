rm(list=ls())
source('src/misc.R')
source('src/data_entry.R')
cat('2014/add/butterflies.R\n')

sp.ids <- list(list(Family='Hesperiidae', Genus='Pyrgus',
                    Species='communis', Sex='', TempID=c()),

               list(Family='Hesperiidae', Genus='Atalopedes',
                    Species='campestris', Sex='', TempID=c()),

               list(Family='Hesperiidae', Genus='Pholisora',
                    Species='catullus', Sex='', TempID=c()),

               list(Family='Hesperiidae', Genus='Lerodea',
                    Species='eufala', Sex='', TempID=c()),

               list(Family='Lycaenidae', Genus='Atilides',
                    Species='halesus', Sex='', TempID=c()),

               list(Family='Lycaenidae', Genus='Lycaena',
                    Species='helloides', Sex='', TempID=c()),

               list(Family='Lycaenidae', Genus='Strymon',
                    Species='melinus', Sex='', TempID=c()),

               list(Family='Lycaenidae', Genus='Plebejus',
                    Species='acmon', Sex='', TempID=c()),

               list(Family='Lycaenidae', Genus='Cupido',
                    Species='amyntula', Sex='', TempID=c()),

               list(Family='Lycaenidae', Genus='Brephidium',
                    Species='exilis', Sex='', TempID=c()),

               list(Family='Nymphalidae', Genus='Vanessa',
                    Species='cardui', Sex='', TempID=c()), 

               list(Family='Nymphalidae', Genus='Junonia',
                    Species='coenia', Sex='', TempID=c()),

               list(Family='Nymphalidae', Genus='Phyciodes',
                    Species='mylitta', Sex='', TempID=c()),

               list(Family='Pieridae', Genus='Colias',
                    Species='eurytheme', Sex='m', TempID=c()),

               list(Family='Pieridae', Genus='Colias',
                    Species='eurytheme', Sex='f', TempID=c()),
               
               list(Family='Pieridae', Genus='Pieris',
                    Species='rapae', Sex='f', TempID=c()),
                      
                list(Family='Pieridae', Genus='Pieris',
                    Species='rapae', Sex='m', TempID=c()),
               
               list(Family='Pieridae', Genus='Pontia',
                    Species='protodice', Sex='f', TempID=c()),
               
               list(Family='Pieridae', Genus='Pontia',
                    Species='protodice', Sex='m', TempID=c()),
               
               list(Family='Papilionidae', Genus='Papilio',
                    Species='rutulus', Sex='', TempID=c()))

add.to.data(year=2014,
            sp.ids=sp.ids,
            case='lep',
            determiner='')
