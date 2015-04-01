rm(list=ls())
source('src/misc.R')
cat('add/2011/syrphids.R\n')

sp.ids <- list(list(genus='Paragus', species='haemorrhous', sex='m',
                 temp.id=c(2684, 2685, 8950, 8951, 8985, 2678, 2677,
                 2676, 15661, 15694, 15632, 13015, 13014, 2649, 15628,
                 2648, 13936, 13010, 13954, 12957, 13009, 10525,
                 13888, 13008, 13007, 8984, 13212, 11155, 8983, 11661,
                 13211, 12961, 13164, 8981, 3437, 12941, 8982, 2732,
                 13158, 8973, 8962, 13129, 12953, 2686, 13127, 13119,
                 13118, 13113, 13086, 12944, 20475, 15720, 15716,
                 15715)),

               list(genus='Paragus', species='haemorrhous', sex='f',
                 temp.id=c(2709, 12829, 12943, 12925, 2687, 2012,
                 2029, 12952, 12956, 13162, 12959, 8949, 13902, 7576,
                 8921, 13012, 13013, 13018, 2652, 15651, 8961, 16179,
                 15721, 5787, 15768)),

               list(genus='Toxomerus', species='marginatus', sex='m',
                 temp.id=c(12244, 12695, 12245, 10444, 12115, 12114,
                 12100, 10408, 15400, 16260, 16225, 16202, 2937, 3089,
                 18597, 17817, 17818, 16502, 15852, 16478, 16503,
                 16504, 16505, 18232, 18233, 16466, 16456, 17883,
                 15869, 16467, 16457, 16459, 16470, 16460, 878, 17855,
                 16472, 16473, 15870, 17858, 17859, 16475, 16477,
                 16399, 16336, 11805, 18084, 16176, 18116, 17941,
                 17978, 17977, 20615, 20614, 20456, 20473, 20472,
                 20467, 8029, 15717, 4440, 8066, 18183, 20466, 20716,
                 20672, 20465, 20464, 20463, 20462, 20461, 18969,
                 5379, 8900, 9298, 15705, 18957, 18944, 8932, 19447,
                 18942, 18937, 19478, 18928, 18904, 18987, 5378,
                 19527, 15751, 20377, 20390, 20015, 20016, 20017,
                 20095, 20392, 20097, 20366, 20059, 20372, 20328,
                 19998, 19889, 15523, 18773, 18751, 18764, 15709,
                 15708, 15677, 15689, 15693, 15663, 16340, 15652,
                 15635, 15634, 15722, 17918, 17919)),

               list(genus='Toxomerus', species='marginatus', sex='f',
                 temp.id=c(16181, 16180, 18051, 18085, 20344, 20500,
                 20499, 20490, 20457, 20455, 20489, 20454, 20575,
                 20488, 20453, 20574, 20474, 20452, 20573, 20451,
                 20572, 20450, 20553, 20471, 20449, 20552, 16263,
                 18596, 18424, 16264, 16262, 16261, 16200, 16259,
                 16258, 16255, 16194, 16207, 16206, 16205, 10378,
                 10407, 16203, 16201, 16204, 16265, 15803, 15938,
                 16254, 16253, 15818, 15812, 15811, 16037, 16103,
                 16102, 18988, 1871, 18973, 18972, 1912, 1048, 19417,
                 15760, 15753, 20358, 20345, 20383, 20388, 20389,
                 20360, 20359, 20146, 20165, 20175, 19999, 20000,
                 19613, 20094, 20391, 20096, 20018, 20019, 20362,
                 20361, 20393, 20020, 20417, 20098, 20021, 20110,
                 20426, 20363, 20364, 20427, 20111, 20022, 20023,
                 20112, 20039, 20428, 20429, 20113, 20365, 20430,
                 20114, 20431, 20432, 19970, 20052, 19977, 19888,
                 20296, 20371, 14206, 14185, 13854, 13901, 13887,
                 13884, 7670, 13092, 12821, 12831, 12170, 12171,
                 12172, 12173, 12174, 12185, 12186, 12187, 12188,
                 12189, 12201, 12202, 12203, 12204, 12680, 12247,
                 12246, 12162, 12161, 10445, 10467, 12131, 12160,
                 9367, 12130, 10436, 12129, 10435, 12128, 12118,
                 10434, 10433, 12117, 12116, 10416, 10415, 10414,
                 10412, 12099, 10411, 12098, 12097, 10410, 10409,
                 11985, 10497, 10496, 10471, 18435, 16501, 16479,
                 16480, 16481, 1976, 2271, 18468, 18499, 16482, 16483,
                 18402, 16506, 16484, 16455, 1808, 1970, 16468, 16458,
                 1911, 1913, 17884, 17853, 16469, 17854, 16471, 16427,
                 16402, 1073, 17856, 17857, 5398, 858, 16474, 16401,
                 16400, 17860, 16476, 16337, 19207, 11166, 11777,
                 13497, 13442, 13339, 14004, 14021, 14153, 14149,
                 18143, 18145, 18144, 18164, 18146, 19221, 19061,
                 19206, 18068, 16182, 20470, 20448, 20447, 20468,
                 20529, 20446, 20528, 20527, 20526, 20525, 20775,
                 20524, 20503, 20460, 20502, 20501, 18872, 18864,
                 18971, 18863, 18970, 8406, 15759, 18846, 18968,
                 15765, 9299, 18901, 18945, 9140, 18900, 8960, 18897,
                 18943, 19599, 18889, 19416, 18883, 19415, 19601,
                 19600, 18933, 18882, 19477, 18932, 18929, 19569,
                 19580, 19614, 19568, 19450, 19449, 18931, 4192,
                 19448, 18926, 19987, 20329, 19997, 19900, 14305,
                 15504, 14346, 14372, 15505, 8122, 18774, 18785,
                 18772, 18771, 14399, 15555, 14393, 15556, 14480,
                 18752, 14092, 18616, 14494, 14559, 18617, 18836,
                 18659, 18837, 18518, 18835, 14865, 15853, 14866,
                 15032, 18581, 18834, 16341, 18831, 15662, 15033,
                 15040, 15653, 14802, 4191, 5380, 16342, 18828, 16343,
                 15110, 15111, 16282, 18822, 18827, 16281, 15112,
                 14155, 15113, 15718, 15154, 15777, 15155, 7520, 3712,
                 15871, 16165, 16164, 16184, 16183, 15872, 15827)),

               list(genus='Syritta', species='flaviventris', sex='m',
                 temp.id=c(8703, 18821, 8899, 11146)),

               list(genus='Syritta', species='flaviventris', sex='f',
                 temp.id=c(19193, 19036, 19109, 2711, 19060)),

               list(genus='Syritta', species='pipiens', sex='m',
                 temp.id=c(11047, 921, 942, 8728, 8959, 9370, 13160,
                 9574, 9393, 18396)),

               list(genus='Syritta', species='pipiens', sex='f',
                 temp.id=c(744, 8659, 10018, 19013)),

               list(genus='Sphaerophoria', species='pyrrhina',
                 sex='m', temp.id=c(15902, 1996, 18766, 20469, 15582,
                 16195)),
               
               list(genus='Sphaerophoria', species='pyrrhina',
                 sex='f', temp.id=c(15774, 18765, 18902, 8898, 15775,
                 8957, 8958, 8956, 8955, 12960, 15819)),

               list(genus='Sphaerophoria', species='contigua',
                 sex='m', temp.id=c(10907, 2689, 10686, 11034, 2528,
                 10955)),
               
               list(genus='Sphaerophoria', species='contigua',
                 sex='f', temp.id=c(13247, 8702)),

               list(genus='Sphaerophoria', species='sulphuripes',
                 sex='m', temp.id=c(747, 1966, 10954, 967, 6983, 9347,
                 11046, 5764, 8028, 8134)),
               
               list(genus='Sphaerophoria', species='sulphuripes',
                 sex='f', temp.id=c(8121, 15394, 3956, 2221, 45, 3078,
                 14741, 8151, 8119, 573, 1995, 14770)),

               list(genus='Eristalis', species='stipator', sex='m',
                 temp.id=c(19012, 10371, 18489)),
               
               list(genus='Eristalis', species='stipator', sex='f',
                 temp.id=c(19106, 19011, 18840)),
               
               list(genus='Scaeva', species='pyrastri', sex='m',
                 temp.id=c(7122, 7202, 7131, 5676, 5932, 6162, 6163,
                 5763)),
               
               list(genus='Scaeva', species='pyrastri', sex='f',
                 temp.id=c(5526, 5762, 6341, 1373, 6339, 6346, 6340,
                 1001)),

               list(genus='Eristalinus', species='aeneus', sex='m',
                 temp.id=c(15435, 16509, 18316, 9573, 10214)),
               
               list(genus='Eristalinus', species='aeneus', sex='f',
                 temp.id=c(10213, 18300, 18498, 18469, 18927, 18994,
                 10014)),

               list(genus='Tropidia', species='quadrata', sex='m',
                 temp.id=c(8897)),
               
               list(genus='Copestylum', species='mexicanum', sex='m',
                 temp.id=c(18463)),
               
               list(genus='Asemosyrphus', species='polygrammus',
                 sex='f', temp.id=c(7898)),
               
               list(genus='Eumerus', species='', sex='f',
                 temp.id=c(18738)),

               list(genus='Eristalis', species='arbustorum', sex='m',
                 temp.id=c(10685, 13156, 15462, 9838, 10215, 9570,
                 7667, 9572, 10015, 10016)),
               
               list(genus='Eristalis', species='arbustorum', sex='f',
                 temp.id=c(12873, 12798, 12876, 10374, 10372, 9571,
                 9837, 18820, 19107, 14158)),

               list(genus='Eupeodes', species='fumipennis', sex='m',
                 temp.id=c(7066, 7227, 4779, 4606, 4778, 4604, 4608,
                 4607, 4549, 4683, 3910, 16485, 16508, 3279, 16507,
                 4682, 15757, 15764, 15763, 6326, 4430, 6166, 6165,
                 6161, 6160, 6345, 8040, 6164, 15762, 15761, 15771,
                 15773, 6251, 6252, 4334, 4383, 3255, 971, 969, 7121,
                 973, 986, 1037, 2747, 2010, 2008, 2000, 1046, 879,
                 2021, 2020, 2017, 2016, 2015, 2014, 4777, 6330, 6331,
                 6329, 6332, 6333, 6328, 6334, 6327, 6335, 6409, 5790,
                 5625, 6991, 4445, 6338, 4384, 4444, 4465, 6336, 4776,
                 4681, 5324, 5191, 16266, 16403, 17920, 16486, 5151)),
               
               list(genus='Eupeodes', species='fumipennis', sex='f',
                 temp.id=c(824, 4550, 4951)),

               list(genus='Syrphus', species='opinator', sex='m',
                 temp.id=c(950, 984, 2028, 5258, 4605, 8039, 7999,
                 7120, 6337)),
               
               list(genus='Syrphus', species='opinator', sex='f',
                 temp.id=c(951, 985, 825, 2727, 7997, 7998, 8001,
                 7985)),

               list(genus='Syrphus', species='torvus', sex='m',
                 temp.id=c(7984)),

               list(genus='Platycheirus', species='stegnus', sex='m',
                 temp.id=c(6635, 8123, 758, 808, 1071, 974, 5115,
                 4007)),
               
               list(genus='Platycheirus', species='stegnus', sex='f',
                 temp.id=c(5624, 6982, 778, 823, 829, 975)),

               list(genus='Platycheirus', species='', sex='m',
               temp.id=c(8369)),

               list(genus='Helophilus', species='latifrons', sex='m',
                 temp.id=c(9842, 7954, 8895, 15501, 12872, 10373,
                 10684, 8896, 11145, 7579, 18870, 7057, 7955, 12871,
                 19612)),

               list(genus='Helophilus', species='latifrons', sex='f',
                 temp.id=c(18301, 6981, 12796, 9569, 12874, 10406,
                 12747, 10908, 15868, 10375, 8730, 12875, 7787, 12825,
                 12810, 12734, 9841, 9662, 18447, 9840, 12795, 12740,
                 18862, 1827)),
               
               list(genus='Ceriana', species='tridens', sex='m',
                 temp.id=c(6342, 5546, 5545, 8616, 13318, 8581,
                 13441)),
               
               list(genus='Ceriana', species='tridens', sex='f',
                 temp.id=c(13317, 15612)),
               
               list(genus='Allograpta', species='obliqua', sex='m',
                 temp.id=c(7979)),
               
               list(genus='Allograpta', species='obliqua', sex='f',
                 temp.id=c(8070)),
               
               list(genus='Allograpta', species='exotica', sex='m',
                 temp.id=c(10950, 8203)),
               
               list(genus='Allograpta', species='exotica', sex='f',
                 temp.id=c(13081, 9068)),
               
               list(genus='Toxomerus', species='occidentalis',
                 sex='m', temp.id=c(4362)),
               
               list(genus='Toxomerus', species='occidentalis',
                 sex='f', temp.id=c(10417, 19887, 15469, 18582)),

               list(genus='Eupeodes', species='volucris', sex='m',
                 temp.id=c(5550, 4363, 4496, 5789, 4382, 4497, 6325,
                 6700, 3716, 4780, 13089, 2013, 6184)),
               
               list(genus='Eupeodes', species='volucris', sex='f',
                 temp.id=c(7101, 3354, 968, 1000, 644, 2030, 2733,
                 3458)),

               list(genus='Eristalis', species='tenax', sex='m',
                 temp.id=c(972, 9663, 10683)),
               
               list(genus='Eristalis', species='tenax', sex='f',
                 temp.id=c(18903, 12797, 8894, 19161, 19105, 19162,
                 19035)))

lengths <- sapply(sp.ids, function(x) length(x$temp.id))
genus <- sapply(sp.ids, function(x) x$genus)
species <- sapply(sp.ids, function(x) x$species)
sex <- sapply(sp.ids, function(x) x$sex)
temp.id <- sapply(sp.ids, function(x) x$temp.id)

dd <- data.frame(temp.id=unlist(temp.id),
                 genus=rep(genus, lengths),
                 species=rep(species, lengths),
                 sex=rep(sex, lengths))

## lood data:
D <- read.csv(file='my_data/2006-2011/cleaned/specimen.csv', as.is=TRUE)

date <- as.Date(D$Date, format='%Y-%m-%d')
year <- as.numeric(format(date, format = '%Y'))

ind <- match(paste(dd$temp.id, '2011'), paste(D$TempID, year))
D$BeeNonbee[ind] <- 'non-bee'
D$Order[ind] <- 'Diptera'
D$Family[ind] <- 'Syrphidae'
D$Genus[ind] <- as.character(dd$genus)
D$Species[ind] <- as.character(dd$species)
D$Sex[ind] <- as.character(dd$sex)
D$Determiner[ind] <- 'M. Hauser'

## Remove entries for specimens that were either not caught (but
## entered) or thrown away

D <- D[-which(D$Family=='Syrphidae' & year==2011 & D$Genus==''),]

write.csv(D, file='my_data/2006-2011/cleaned/specimen.csv',
          row.names=FALSE) 
