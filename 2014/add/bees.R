rm(list=ls())
source('src/misc.R')
source('src/data_entry.R')
cat('2014/add/bees.R\n')

sp.ids <- list(list(Genus='Agapostemon', SubGenus='', Species='texanus',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Agapostemon', SubGenus='', Species='texanus',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='angustitarsata',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='auricoma',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='candida',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='candida',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='cerasifolii',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='chlorogaster',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='chlorogaster',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='cressonii',
                    SubSpecies='infasciata', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='knuthiana',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='knuthiana',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='nigrocaerulea',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='piperi',
                    SubSpecies='', Sex='f', TempID=c()),            

               list(Genus='Andrena', SubGenus='', Species='subchalybea',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='scurra',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='scurra',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='subaustralis',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Andrena', SubGenus='', Species='subaustralis',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Anthidiellum', SubGenus='', Species='notatum',
                    SubSpecies='robertsoni', Sex='m', TempID=c()),

               list(Genus='Anthidiellum', SubGenus='', Species='notatum',
                    SubSpecies='robertsoni', Sex='f', TempID=c()),

               list(Genus='Anthophora', SubGenus='', Species='urbana',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Anthophora', SubGenus='', Species='urbana',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Ashmeadiella', SubGenus='', Species='aridula',
                    SubSpecies='astragali', Sex='m', TempID=c()),

               list(Genus='Ashmeadiella', SubGenus='', Species='aridula',
                    SubSpecies='astragali', Sex='f', TempID=c()),

               list(Genus='Ashmeadiella', SubGenus='', Species='bucconis',
                    SubSpecies='denticulata', Sex='m', TempID=c()),
               
               list(Genus='Ashmeadiella', SubGenus='', Species='bucconis',
                    SubSpecies='denticulata', Sex='f', TempID=c()),

               list(Genus='Ashmeadiella', SubGenus='', Species='cactorum',
                    SubSpecies='basalis', Sex='m', TempID=c()),

               list(Genus='Ashmeadiella', SubGenus='', Species='cactorum',
                    SubSpecies='basalis', Sex='f', TempID=c()),

               list(Genus='Bombus', SubGenus='', Species='californicus',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Bombus', SubGenus='', Species='melanopygus',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Bombus', SubGenus='', Species='vandykei',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Bombus', SubGenus='', Species='vandykei',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Bombus', SubGenus='', Species='vosnesenskii',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Calliopsis', SubGenus='', Species='hesperia',
                    SubSpecies='equina', Sex='f', TempID=c()),

               list(Genus='Calliopsis', SubGenus='', Species='scitula',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Calliopsis', SubGenus='', Species='scitula',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Ceratina', SubGenus='', Species='acantha',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Ceratina', SubGenus='', Species='acantha',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Ceratina', SubGenus='', Species='arizonensis',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Ceratina', SubGenus='', Species='dallatorreana',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Ceratina', SubGenus='', Species='nanula',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Coelioxys', SubGenus='', Species='apacheiorum',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Coelioxys', SubGenus='', Species='novomexicana',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Coelioxys', SubGenus='', Species='novomexicana',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Coelioxys', SubGenus='', Species='octodentata',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Coelioxys', SubGenus='', Species='gilensis',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Colletes', SubGenus='', Species='hyalinus',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Colletes', SubGenus='', Species='hyalinus',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Ceratina', SubGenus='', Species='punctigena',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Diadasia', SubGenus='', Species='diminuta',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Diadasia', SubGenus='', Species='enavata',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Diadasia', SubGenus='', Species='enavata',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Diadasia', SubGenus='', Species='ochracea',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Dianthidium', SubGenus='', Species='ulkei',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Eucera', SubGenus='', Species='actuosa',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Halictus', SubGenus='', Species='ligatus',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Halictus', SubGenus='', Species='ligatus',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Halictus', SubGenus='', Species='tripartitus',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Halictus', SubGenus='', Species='tripartitus',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Hylaeus', SubGenus='', Species='bisinuatus',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Hylaeus', SubGenus='', Species='bisinuatus',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Hylaeus', SubGenus='', Species='calvus',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Hylaeus', SubGenus='', Species='conspicuus',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Hylaeus', SubGenus='', Species='conspicuus',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Hylaeus', SubGenus='', Species='episcopalis',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Hylaeus', SubGenus='', Species='mesillae',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Hylaeus', SubGenus='', Species='mesillae',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Hylaeus', SubGenus='', Species='rudbeckiae',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Dialictus)',
                    Species='',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Dialictus)',
                    Species='incompletum',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='', Species='kincaidii',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='', Species='kincaidii',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Lasioglossum', SubGenus='', Species='sisymbrii',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='', Species='tegulariforme',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='', Species='tegulariforme',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='', Species='titusi',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='', Species='titusi',
                    SubSpecies='',
                    Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Dialictus)',
                    Species='sp.',
                    SubSpecies='B', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Dialictus)',
                    Species='sp.',
                    SubSpecies='C', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Dialictus)',
                    Species='sp.',
                    SubSpecies='D', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Dialictus)',
                    Species='sp.',
                    SubSpecies='E', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Dialictus)',
                    Species='sp.',
                    SubSpecies='F', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Dialictus)',
                    Species='sp.',
                    SubSpecies='I', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Evylaeus)',
                    Species='sp.',
                    SubSpecies='C', Sex='f', TempID=c()),

               list(Genus='Lasioglossum', SubGenus='(Evylaeus)',
                    Species='sp.',
                    SubSpecies='E', Sex='f', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='angelarum',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='apicalis',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='apicalis',
                    SubSpecies='', Sex='f', TempID=c()),
                 
               list(Genus='Megachile', SubGenus='', Species='brevis',
                 SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='brevis',
                 SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='coquilletti',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='coquilletti',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='fidelis',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='frugalis',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='gentilis',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='gentilis',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='rotundata',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='rotundata',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='lippiae',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='lippiae',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='montivaga', 
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='onobrychidis',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='onobrychidis',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Megachile', SubGenus='', Species='parallela',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Melissodes', SubGenus='', Species='agilis',
                    SubSpecies='', Sex='m', TempID=c()),
               
               list(Genus='Melissodes', SubGenus='', Species='agilis',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Melissodes', SubGenus='', Species='lupina',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Melissodes', SubGenus='', Species='lupina',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Melissodes', SubGenus='', Species='robustior',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Melissodes', SubGenus='', Species='robustior',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Melissodes', SubGenus='', Species='stearnsi',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Melissodes', SubGenus='', Species='stearnsi',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Melissodes', SubGenus='', Species='tepida',
                    SubSpecies='timberlakei', Sex='m', TempID=c()),

               list(Genus='Melissodes', SubGenus='', Species='tepida',
                    SubSpecies='timberlakei', Sex='f', TempID=c()),

               list(Genus='Nomada', SubGenus='', Species='sp.',
                    SubSpecies='3', Sex='f', TempID=c()),

               list(Genus='Nomada', SubGenus='', Species='sp.',
                    SubSpecies='5', Sex='f', TempID=c()),

               list(Genus='Nomada', SubGenus='', Species='sp.',
                    SubSpecies='CK-1M', Sex='m', TempID=c()),

               list(Genus='Nomada', SubGenus='', Species='sp.',
                    SubSpecies='CK-2M', Sex='m', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='aglaia',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='atrocyanea',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='gaudiosa',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='granulosa',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='laeta',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='laeta',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='lignaria',
                    SubSpecies='propinqua', Sex='f', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='nemoris',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='nemoris',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='regulina',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='regulina',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='texana',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Osmia', SubGenus='', Species='texana',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Peponapis', SubGenus='', Species='pruinosa',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Sphecodes', SubGenus='', Species='sp.',
                    SubSpecies='B', Sex='f', TempID=c()),

               list(Genus='Sphecodes', SubGenus='', Species='sp.',
                    SubSpecies='D', Sex='f', TempID=c()),

               list(Genus='Svastra', SubGenus='', Species='obliqua',
                    SubSpecies='expurgata', Sex='m', TempID=c()),

               list(Genus='Svastra', SubGenus='', Species='obliqua',
                    SubSpecies='expurgata', Sex='f', TempID=c()),

               list(Genus='Triepeolus', SubGenus='', Species='concavus',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Triepeolus', SubGenus='', Species='concavus',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Triepeolus', SubGenus='', Species='heterurus',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Triepeolus', SubGenus='', Species='heterurus',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Triepeolus', SubGenus='', Species='melanarius',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Triepeolus', SubGenus='', Species='subnitens',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Triepeolus', SubGenus='', Species='subnitens',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Triepeolus', SubGenus='', Species='timberlakei',
                    SubSpecies='', Sex='m', TempID=c()),

               list(Genus='Triepeolus', SubGenus='', Species='timberlakei',
                    SubSpecies='', Sex='f', TempID=c()),
               
               list(Genus='Xeromelecta', SubGenus='', Species='californica',
                    SubSpecies='', Sex='f', TempID=c()),

               list(Genus='Xylocopa', SubGenus='', Species='tabaniformis',
                    SubSpecies='orpifex', Sex='m', TempID=c()),

               list(Genus='Xylocopa', SubGenus='', Species='tabaniformis',
                    SubSpecies='orpifex', Sex='f', TempID=c()),

               list(Genus='Xylocopa', SubGenus='', Species='varipuncta',
                    SubSpecies='', Sex='f', TempID=c()))

add.to.data(year=2014,
            sp.ids=sp.ids,
            case='bee',
            determiner='R. Thorp')
