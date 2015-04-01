rm(list=ls())
source('src/misc.R')
source('src/data_entry.R')
cat('2014/add/syrphids.R\n')

sp.ids <- list(list(Genus='Paragus', Species='haemorrhous', Sex='m',
                    TempID=c()),

               list(Genus='Paragus', Species='haemorrhous', Sex='f',
                    TempID=c()),

               list(Genus='Paragus', Species='haemorrhous', Sex='',
                    TempID=c()),

               list(Genus='Platycheirus', Species='stegnus', Sex='m',
                    TempID=c()),
               
               list(Genus='Platycheirus', Species='stegnus', Sex='f',
                    TempID=c()),

               list(Genus='Toxomerus', Species='marginatus', Sex='m',
                    TempID=c()),

               list(Genus='Toxomerus', Species='marginatus', Sex='f',
                    TempID=c()),

               list(Genus='Toxomerus', Species='marginatus', Sex='',
                    TempID=c()),

               list(Genus='Syritta', Species='flaviventris', Sex='m',
                    TempID=c()),

               list(Genus='Syritta', Species='flaviventris', Sex='f',
                    TempID=c()),

               list(Genus='Syritta', Species='pipiens', Sex='m',
                    TempID=c()),

               list(Genus='Syritta', Species='pipiens', Sex='f',
                    TempID=c()),

               list(Genus='Sphaerophoria', Species='pyrrhina',
                    Sex='m', TempID=c()),
               
               list(Genus='Sphaerophoria', Species='pyrrhina',
                    Sex='f', TempID=c()),

               list(Genus='Sphaerophoria', Species='contigua',
                    Sex='m', TempID=c()),
               
               list(Genus='Sphaerophoria', Species='contigua',
                    Sex='f', TempID=c()),

               list(Genus='Sphaerophoria', Species='sulphuripes',
                    Sex='m', TempID=c()),
               
               list(Genus='Sphaerophoria', Species='sulphuripes',
                    Sex='f', TempID=c()),

               list(Genus='Eristalis', Species='hirta', Sex='m',
                    TempID=c()),

               list(Genus='Eristalis', Species='stipator', Sex='m',
                    TempID=c()),
               
               list(Genus='Eristalis', Species='stipator', Sex='f',
                    TempID=c()),
               
               list(Genus='Scaeva', Species='pyrastri', Sex='m',
                    TempID=c()),
               
               list(Genus='Scaeva', Species='pyrastri', Sex='f',
                    TempID=c()),

               list(Genus='Eristalinus', Species='aeneus', Sex='m',
                    TempID=c()),
               
               list(Genus='Eristalinus', Species='aeneus', Sex='f',
                    TempID=c()),

               list(Genus='Tropidia', Species='quadrata', Sex='m',
                    TempID=c()),

               list(Genus='Tropidia', Species='quadrata', Sex='f',
                    TempID=c()),
               
               list(Genus='Copestylum', Species='mexicanum',
                    Sex='m', TempID=c()),

               list(Genus='Copestylum', Species='mexicanum',
                    Sex='f', TempID=c()),
               
               list(Genus='Asemosyrphus', Species='polygrammus',
                    Sex='m', TempID=c()),

               list(Genus='Asemosyrphus', Species='polygrammus',
                    Sex='f', TempID=c()),
               
               list(Genus='Eristalis', Species='arbustorum', Sex='m',
                    TempID=c()),
               
               list(Genus='Eristalis', Species='arbustorum', Sex='f',
                    TempID=c()),

               list(Genus='Eupeodes', Species='fumipennis', Sex='m',
                    TempID=c()),
               
               list(Genus='Eupeodes', Species='fumipennis', Sex='f',
                    TempID=c()),

               list(Genus='Syrphus', Species='opinator', Sex='m',
                    TempID=c()),
               
               list(Genus='Syrphus', Species='opinator', Sex='f',
                    TempID=c()),

               list(Genus='Syrphus', Species='torvus', Sex='m',
                    TempID=c()),
               
               list(Genus='Syrphus', Species='torvus', Sex='f',
                    TempID=c()),

               list(Genus='Helophilus', Species='latifrons', Sex='m',
                    TempID=c()),

               list(Genus='Helophilus', Species='latifrons', Sex='f',
                    TempID=c()),
               
               list(Genus='Ceriana', Species='tridens', Sex='m',
                    TempID=c()),
               
               list(Genus='Ceriana', Species='tridens', Sex='f',
                    TempID=c()),
               
               list(Genus='Allograpta', Species='obliqua', Sex='f',
                    TempID=c()),
               
               list(Genus='Allograpta', Species='obliqua', Sex='m',
                    TempID=c()),
               
               list(Genus='Allograpta', Species='obliqua', Sex='',
                    TempID=c()),

               list(Genus='Allograpta', Species='exotica', Sex='f',
                    TempID=c()),

               list(Genus='Allograpta', Species='exotica', Sex='m',
                    TempID=c()),
               
               list(Genus='Toxomerus', Species='occidentalis',
                    Sex='m', TempID=c()),
               
               list(Genus='Toxomerus', Species='occidentalis',
                    Sex='f', TempID=c()),

               list(Genus='Eupeodes', Species='volucris', Sex='m',
                    TempID=c()),
               
               list(Genus='Eupeodes', Species='volucris', Sex='f',
                    TempID=c()),

               list(Genus='Eristalis', Species='tenax', Sex='m',
                    TempID=c()),
               
               list(Genus='Eristalis', Species='tenax', Sex='f',
                    TempID=c()),

               list(Genus='Palpada', Species='alhambra', Sex='m',
                    TempID=c()),

               list(Genus='Palpada', Species='alhambra', Sex='f',
                    TempID=c()),
               
               list(Genus='Myathropa', Species='florea', Sex='f',
                    TempID=c()),
               
               list(Genus='Pipiza', Species='', Sex='f',
                    TempID=c()),
               
               list(Genus='Parhelophilus', Species='laetus', Sex='m',
                    TempID=c()),
               
               list(Genus='Eumerus', Species='strigatus', Sex='m',
                    TempID=c()),
               
               list(Genus='Eumerus', Species='strigatus', Sex='f',
                    TempID=c()),
               
               list(Genus='Platycheirus', Species='obscurus', Sex='m',
                    TempID=c()),

               list(Genus='Platycheirus', Species='obscurus', Sex='f',
                    TempID=c()),

               list(Genus='Platycheirus', Species='quadratus', Sex='m',
                    TempID=c()),

               list(Genus='Platycheirus', Species='quadratus', Sex='f',
                    TempID=c())## ,
               
               ## list(Genus='', Species='', Sex='',
               ##   TempID=c()),
               
               ## list(Genus='', Species='', Sex='',
               ##   TempID=c())

               )

add.to.data(year=2014,
            sp.ids=sp.ids,
            case='syr',
            determiner='')
