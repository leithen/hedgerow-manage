rm(list=ls())
source("src/misc.R")
source('src/data_entry.R')
cat("2012/add/butterflies.R\n")

sp.ids <- list(list(Family='Pieridae', Genus='Colias',
                    Species='eurytheme', Sex='m', TempID=c(12783,
                    16532, 13099, 2994, 38302, 13100, 13098, 13105,
                    13101, 13104, 13102, 13109, 13107, 38291, 38113,
                    38120, 38122, 38123, 38124, 38125, 38127, 38128,
                    38133, 38134, 38135, 38137, 38138, 38139, 38141,
                    38145, 38146, 38149, 38150, 38151, 38152, 38158,
                    38164, 38165, 38166, 38170, 38173, 38178, 38179,
                    38180, 38181, 38188, 38189, 38190, 38191, 38192,
                    38193, 38194, 38195, 38196, 38197, 38201, 38202,
                    38203, 38206, 38207, 38209, 38210, 38212, 38217,
                    38226, 38228)),

               list(Family='Pieridae', Genus='Colias',
                    Species='eurytheme', Sex='f', TempID=c(10786,
                    10787, 10788, 19075, 38059, 38060, 38061, 38062,
                    38063, 5536, 3706, 38301, 38064, 13106, 13097,
                    13108, 13110, 38111, 38112, 38114, 38115, 38116,
                    38117, 38118, 38119, 38121, 38132, 38136, 38142,
                    38147, 38148, 38153, 38154, 38156, 38159, 38160,
                    38161, 38162, 38168, 38182, 38183, 38184, 38185,
                    38198, 38199, 38200, 38208, 38211, 38218, 38220,
                    38223, 38227)),

               list(Family='Pieridae', Genus='Pieris',
                    Species='rapae', Sex='m', TempID=c(12781, 1130,
                    5360, 2086, 37995, 38004, 38008, 38011, 38026,
                    38027, 38028, 38035, 38040, 38044, 38053, 38054,
                    38304, 38065, 38066, 38069, 38070, 38107, 38108,
                    38229)),

               list(Family='Pieridae', Genus='Pieris',
                    Species='rapae', Sex='f', TempID=c(1240, 1131,
                    5330, 2080, 1666, 5314, 12784, 1923, 1993, 1165,
                    10785, 18295, 13103, 12782, 27893,37991,
                    37992, 37993, 37994, 37996, 37997, 37998, 37999,
                    38000, 38001, 38002, 38003, 38005, 38006, 38007,
                    38009, 38010, 38012, 38013, 38014, 38015, 38016,
                    38017, 38018, 38019, 38020, 38021, 38022, 38023,
                    38024, 38025, 38029, 38030, 38031, 38032, 38033,
                    38034, 38036, 38037, 38038, 38039, 38041, 38042,
                    38043, 38045, 38046, 38047, 38048, 38049, 38050,
                    38051, 38052, 38055, 38056, 38057, 38058, 38303,
                    38305, 38306, 38307, 38308, 38067, 38068, 38071,
                    38072, 38073, 38074, 38075, 38076, 38077, 38078,
                    38079, 38080, 38081, 38082, 38083, 38084, 38085,
                    38086, 38087, 38088, 38089, 38090, 38091, 38092,
                    38093, 38094, 38095, 38096, 38097, 38098, 38099,
                    38100, 38101, 38102, 38103, 38104, 38105, 38106,
                    38109, 38110, 38126, 38129, 38130, 38131, 38140,
                    38143, 38144, 38155, 38157, 38163, 38167, 38169,
                    38171, 38172, 38174, 38175, 38176, 38177, 38186,
                    38187, 38204, 38205, 38213, 38214, 38215, 38216,
                    38219, 38221, 38222, 38224, 38225, 38230, 38231,
                    38232)),
				
               list(Family='Papilionidae', Genus='Battus',
                    Species='philenor', Sex='', TempID=c(38240)),

               list(Family='Nymphalidae', Genus='Limentis',
                    Species='lorquini', Sex='', TempID=c(38256)),

               list(Family='Nymphalidae', Genus='Vanessa',
                    Species='cardui', Sex='', TempID=c(38249, 38250,
                    38251, 38241, 16476, 1042, 1166, 1041, 5449, 5534,
                    5288, 1043, 5448, 5262, 1071, 1167, 38259)),

               list(Family='Nymphalidae', Genus='Junonia', 
                    Species='coenia', Sex='', TempID=c(38292, 5243)), 
               
               list(Family='Lycaenidae', Genus='Atilides', 
                    Species='halesus', Sex='', TempID=c(5537)), 
               
               list(Family='Lycaenidae', Genus='Lycaena',
                    Species='helloides', Sex='', TempID=c(13060,
                    13057, 5272, 13055, 5283, 38299, 38285, 38246,
                    38266, 38239, 38263, 5287, 13056, 1935)),
               
               list(Family='Lycaenidae', Genus='Strymon',
                    Species='melinus', Sex='', TempID=c(38284, 38288,
                    38297, 38253, 38238, 38233, 14878, 10817)),
               
               list(Family='Lycaenidae', Genus='Plebejus',
                    Species='acmon', Sex='', TempID=c(13059, 38278,
                    38298, 5381)),
               
               list(Family='Lycaenidae', Genus='Cupido',
                    Species='amyntula', Sex='', TempID=c(10454, 38272,
                    38235, 38247, 38281, 38279)),
               
               list(Family='Lycaenidae', Genus='Brephidium',
                    Species='exilis', Sex='', TempID=c(38276, 38275,
                    38273, 38271, 11111, 11132)),
               
               list(Family='Nymphalidae', Genus='Coenonympha', 
                    Species='tullia', Sex='', TempID=c(38290)), 
               
               list(Family='Nymphalidae', Genus='Phyciodes',
                    Species='mylitta', Sex='', TempID=c(38289, 17161,
                    38234, 38236)),
               
               list(Family='Hesperiidae', Genus='Pyrgus',
                    Species='communis', Sex='', TempID=c(38260, 38261,
                    38262, 38264, 38268, 38267, 38280, 38282, 38286,
                    38287, 38248, 38270, 28692, 4153, 4138, 1040,
                    1129, 5400, 5399, 5361, 5362, 5363, 5364, 5365,
                    5345, 5346, 5354, 5286)),
               
               list(Family='Hesperiidae', Genus='Lerodea',
                    Species='eufala', Sex='', TempID=c(10789, 12779,
                    12780, 38252, 38255, 38257, 38243, 38242, 38300,
                    38265)),
               
               list(Family='Hesperiidae', Genus='Pholisora', 
                    Species='catullus', Sex='', TempID=c(38245)), 
               
               list(Family='Hesperiidae', Genus='Pyrgus',
                    Species='scriptura', Sex='', TempID=c(13058,
                    27997, 38274)),
               
               list(Family='Hesperiidae', Genus='Atalopedes',
                    Species='campestris', Sex='', TempID=c(38237,
                    38293, 38283, 19074, 1073, 2084, 2085))

               )

add.to.data(year=2012, 
            sp.ids=sp.ids, 
            case='lep', 
            determiner='K. Cutler')
