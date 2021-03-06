rm(list=ls())
source('src/misc.R')
source('src/data_entry.R')
cat('2012/add/syrphids.R\n')

sp.ids <- list(list(Genus='Paragus', Species='haemorrhous',
                 Sex='m', TempID=c(3440, 9218, 9212, 8840, 9243, 9245,
                 8670, 6422, 6926, 6940, 6937, 6942, 6943, 6816, 6817,
                 2072, 3387, 2068, 2051, 2032, 6868, 6869, 6046, 5765,
                 4586, 6190, 11625, 10729, 7510, 11226, 6779, 14854,
                 14842, 14868, 14877, 5380, 6785, 5607, 1065)),

               list(Genus='Paragus', Species='haemorrhous',
                 Sex='f', TempID=c(9240, 8634, 6906, 6905, 6939, 3386,
                 3411, 3450, 2069, 2067, 2064, 2057, 2052, 2003, 6748,
                 6870, 6853, 5446, 1038, 6076, 1981, 1991, 5596, 5601,
                 4583, 4579, 5767, 5377, 1100, 5436, 2077, 6126,
                 22849, 22338, 11680, 11677, 7492)),

               list(Genus='Paragus', Species='haemorrhous',
                 Sex='', TempID=c(6904, 6815, 6218, 3393, 5776, 22880,
                 22882, 7508)),

               list(Genus='Toxomerus', Species='marginatus', Sex='m',
                 TempID=c(9359, 9361, 9538, 7982, 9440, 2021, 1994,
                 10336, 1971, 6464, 6452, 6496, 10413, 14751, 14752,
                 15310, 30943, 15318, 30452, 15320, 15362, 18943,
                 30166, 30196, 30198, 30299, 28741, 30304, 30318,
                 30317, 30693, 30694, 30695, 30737, 30754, 30954,
                 30957, 29255, 29256, 29372, 27913, 29413, 29425,
                 29427, 29982, 31202, 18996, 10217, 10047, 10036,
                 10376, 10334, 10025, 10024, 10044, 10026, 10030,
                 10029, 10028, 10022, 10021, 10019, 10016, 10027,
                 10008, 9893, 10007, 10018, 10032, 10031, 10038,
                 10015, 10009, 10119, 10232, 10199, 10212, 9709, 9704,
                 10096, 10110, 10104, 9710, 10046, 10033, 10034,
                 10042, 4253, 6029, 4244, 9700, 10011, 9572, 9618,
                 9790, 32997, 9672, 32620, 14663, 10679, 10692, 10682,
                 10660, 10690, 10665, 10652, 10658, 10681, 10657,
                 10683, 10603, 10646, 10649, 10650, 10506, 10495,
                 10526, 10511, 10867, 7931, 7509, 10677, 10676, 10671,
                 10670, 10668, 10667, 10703, 10700, 10856, 10698,
                 10697, 10696, 10694, 10711, 10708, 10858, 10993,
                 11054, 11047, 11040, 11095, 6101, 4145, 5278, 10290,
                 10415, 8874, 8879, 8911, 8922, 8923, 6380, 6420,
                 6419, 6417, 6399, 8793, 8619, 8620, 8621, 1862,
                 10324, 9329, 8616, 9483, 9487, 9202, 9488, 9530,
                 9544, 9543, 9529, 6535, 6549, 6570, 9277, 9280, 9474,
                 14281, 14310, 13720, 34584, 34585, 21240, 14154,
                 20943, 33383, 19191, 34620, 19052, 24227, 36140,
                 33788, 11563, 11532, 11518, 11539, 11548, 32978,
                 17223, 17241, 23153, 23390, 23391, 23779, 11848,
                 24021, 24078, 24261, 24263, 24265, 24339, 25821,
                 25819, 25853, 25855, 25863, 25908, 25922, 25919,
                 25918, 25917, 25915, 25905, 25912, 25925, 25948,
                 25962, 25970, 25987, 27534, 26533, 27319, 27331,
                 30052, 27194, 11851, 11852, 11853, 11855, 11845,
                 11831, 11834, 11829, 11846, 11823, 11820, 11688,
                 11642, 11669, 11692, 11901, 11892, 11894, 11862,
                 11891, 11902, 11900, 11925, 11874, 11869, 11924,
                 11887, 11880, 11878, 11867, 11899, 11897, 11875,
                 11929, 9565, 9613, 12402, 12530, 11353, 26738, 9892,
                 11847, 32582, 6348, 10710, 11241, 28095, 23053,
                 27853, 28383, 31174, 37292, 19013, 19012, 19011,
                 15257, 36787, 30054, 25873, 25634, 29739, 30880,
                 30885, 37529, 32685, 32684, 29734, 37340, 37341,
                 37237, 37241, 37514, 37521, 37519, 37532, 37533,
                 37534, 37535, 37536, 37537, 37538, 37540, 37541,
                 37542, 37551, 37552, 37553, 37555, 37556, 35729,
                 37222, 37225, 37227, 37562, 9501)),

               list(Genus='Toxomerus', Species='marginatus', Sex='f',
                 TempID=c(8006, 5842, 5671, 5647, 6117, 6110, 10361,
                 3836, 5519, 6084, 8872, 5677, 5758, 5757, 6424,
                 14981, 10285, 6116, 10330, 10249, 10320, 10414,
                 10412, 6379, 10323, 10335, 10404, 9084, 10347, 8912,
                 8924, 6398, 6401, 8722, 8788, 8797, 8778, 8787, 8755,
                 8749, 8718, 8719, 8761, 8798, 8758, 8786, 9365, 9332,
                 8614, 8630, 8615, 8712, 8710, 9163, 9167, 9168, 9480,
                 9481, 9175, 9169, 9500, 9528, 8789, 6547, 6545, 8993,
                 9185, 3403, 10968, 6331, 1955, 3425, 1954, 1956,
                 6781, 6473, 3795, 10348, 10465, 10331, 10998, 8951,
                 14559, 15309, 15308, 15192, 15182, 15168, 14662,
                 15353, 18731, 18934, 18935, 27215, 18995, 18994,
                 18993, 30142, 30167, 30197, 30284, 30301, 30315,
                 30316, 30423, 30687, 30690, 29410, 30713, 30753,
                 30755, 30756, 30757, 30758, 30767, 30867, 14578,
                 30944, 14588, 29246, 29254, 29257, 29371, 29524,
                 29525, 27915, 29859, 29895, 29921, 29974, 29975,
                 29980, 29981, 31436, 31452, 27990, 10048, 10035,
                 10460, 10332, 10378, 10377, 10017, 6985, 10010,
                 10223, 10224, 10005, 10225, 10201, 9659, 6239, 10083,
                 10092, 10094, 9472, 10109, 10072, 5769, 1917, 9711,
                 1704, 10045, 6028, 5617, 5520, 9634, 9586, 9660,
                 23055, 32585, 32627, 32590, 32587, 32538, 33537,
                 14015, 14387, 14403, 16069, 14139, 14155, 19072,
                 34586, 14014, 28892, 35496, 10794, 10689, 10887,
                 10661, 10678, 10659, 10644, 10651, 10876, 10653,
                 10684, 10931, 10517, 10662, 10666, 10516, 10927,
                 10881, 10964, 10647, 10655, 7942, 10519, 10500,
                 10573, 10874, 7956, 7975, 8216, 8090, 7925, 8082,
                 10674, 10707, 10709, 10714, 10699, 10791, 10701,
                 10702, 10672, 10673, 10718, 10801, 10790, 10860,
                 10770, 10712, 10704, 10725, 10705, 10843, 10750,
                 10836, 10716, 10833, 10715, 10865, 10849, 10844,
                 10988, 11076, 11070, 11071, 11061, 11037, 11072,
                 11074, 11075, 11056, 11057, 11048, 11038, 11039,
                 11022, 11021, 10325, 11027, 11028, 11017, 11002,
                 11089, 11003, 11004, 11085, 11087, 11088, 11099,
                 11110, 11218, 11221, 11232, 11228, 11238, 11234,
                 11247, 24283, 24243, 35560, 36087, 36070, 35287,
                 34936, 34725, 3385, 5076, 4252, 11266, 6800, 11643,
                 11547, 11541, 11562, 22850, 22858, 11540, 11564,
                 11531, 11542, 11515, 11517, 11538, 23152, 23155,
                 23156, 23168, 17196, 16160, 23122, 23103, 16610,
                 23476, 24019, 24020, 24043, 24077, 24096, 24098,
                 24234, 24248, 24249, 24260, 24325, 24328, 18388,
                 18185, 25874, 25830, 25822, 25817, 25839, 25851,
                 25852, 25854, 25860, 25861, 25888, 25890, 25900,
                 25901, 25906, 25907, 25923, 25924, 25926, 25927,
                 25928, 25929, 25936, 25949, 25961, 25966, 25986,
                 25988, 25989, 26529, 26542, 26710, 26711, 26715,
                 26716, 30053, 27191, 11870, 11854, 11832, 11833,
                 11849, 11850, 11822, 11665, 11653, 11916, 11923,
                 11922, 11893, 11957, 11949, 11882, 11903, 12456,
                 12499, 12493, 12494, 11866, 11885, 12820, 12491,
                 12430, 11886, 11915, 11877, 11890, 11889, 11876,
                 11888, 11898, 11927, 11910, 11861, 9566, 9746, 9751,
                 9793, 9886, 9885, 9581, 9650, 12578, 12560, 12466,
                 12509, 13083, 13068, 11821, 11681, 6100, 996, 14574,
                 11516, 30418, 32621, 9162, 34689, 23161, 28051,
                 33227, 31166, 27154, 27460, 33555, 15540, 37298,
                 36782, 32610, 19010, 15193, 14556, 15410, 17197,
                 27186, 32686, 32687, 37477, 37301, 37299, 37300,
                 37478, 36885, 36827, 37317, 37304, 25811, 37239,
                 37513, 37520, 37530, 37531, 37549, 37550, 37226,
                 37229, 37554, 9510, 9482)),

               list(Genus='Toxomerus', Species='marginatus',
                 Sex='', TempID=c(11170, 11036)),

               list(Genus='Syritta', Species='flaviventris',
                 Sex='m', TempID=c(10289, 6542, 6069, 6415, 6270,
                 2039, 2038, 2001, 8666, 1939, 6326, 8832, 6832,
                 10597)),

               list(Genus='Syritta', Species='flaviventris',
                 Sex='f', TempID=c(5344, 6325, 1998, 10354, 22500,
                 6823, 11284, 11293, 10522)),

               list(Genus='Syritta', Species='pipiens', Sex='m',
                 TempID=c(5432, 5714, 6039, 5869, 5270, 5443, 10117,
                 5715, 6055, 6187, 5234, 6045, 6074, 6188, 10118,
                 5713, 11577, 10116, 10108, 22354, 6269, 6271, 2040,
                 6741, 22913, 11135, 6774, 6776, 6814, 11126, 11139,
                 10717, 10567, 10562)),

               list(Genus='Syritta', Species='pipiens', Sex='f',
                 TempID=c(8658, 11117, 11130, 10643, 6576, 11125,
                 6772, 22398, 6791, 6370, 6372, 11115, 11282, 10080,
                 10103, 10093, 10220, 5748, 9393)),

               list(Genus='Sphaerophoria', Species='pyrrhina',
                 Sex='m', TempID=c(9441, 10685, 10925, 11683, 8790,
                 8767, 8794, 9330, 9333, 9451, 6414, 9407, 9405, 9406,
                 10020, 10006, 10095, 9439, 5774, 1820, 10523, 22473,
                 14640, 14766, 9437, 1989, 36127, 9283, 11684, 11819,
                 36097, 36124, 36139, 36137, 36128, 9367, 36014)),
               
               list(Genus='Sphaerophoria', Species='pyrrhina',
                 Sex='f', TempID=c(9702, 11546, 11571, 36078, 36088,
                 15319, 22479, 14750, 11561, 8791, 8760, 8756, 8757,
                 8753, 9360, 9281, 9279, 22331, 6244, 6246, 1930,
                 8711, 14749, 10841, 8792, 5780, 9364, 10466, 11281,
                 10945, 9429, 9358, 10216, 5706, 14879, 5787, 11627,
                 36136, 23119, 9442, 30303, 6245, 10926, 37305, 37315,
                 37290)),

               list(Genus='Sphaerophoria', Species='contigua',
                 Sex='m', TempID=c(10895, 6371, 2060, 2023, 1230,
                 2059)),
               
               list(Genus='Sphaerophoria', Species='contigua',
                 Sex='f', TempID=c(1995, 6577, 10898, 2081, 3394, 35,
                 9658, 6111)),

               list(Genus='Sphaerophoria', Species='sulphuripes',
                 Sex='m', TempID=c(2476, 6587, 1128, 3462, 10566,
                 6451, 2234, 6524, 1044, 3478, 1107, 1055, 6390, 3464,
                 3463, 1397, 1196, 1214, 2341, 1104, 1399, 2457)),
               
               list(Genus='Sphaerophoria', Species='sulphuripes',
                 Sex='f', TempID=c(11317, 11318, 11340, 92, 1219, 306,
                 22488, 11342, 13979, 1164, 14880, 10909, 2596, 6412,
                 263, 10074)),

               list(Genus='Eristalis', Species='hirta', Sex='m',
                 TempID=c(1866)),

               list(Genus='Eristalis', Species='stipator', Sex='m',
                 TempID=c(6407, 10293, 5962)),
               
               list(Genus='Eristalis', Species='stipator', Sex='f',
                 TempID=c(8731, 10151, 6128, 9381, 11292, 9419)),
               
               list(Genus='Scaeva', Species='pyrastri', Sex='m',
                 TempID=c(1796, 2033)),
               
               list(Genus='Scaeva', Species='pyrastri', Sex='f',
                 TempID=c(2037, 1124, 1045, 964, 1203, 1138)),

               list(Genus='Eristalinus', Species='aeneus',
                 Sex='m', TempID=c(6365, 11524, 5625, 11523, 6031,
                 12437, 5265, 5255, 6062, 6067, 5212, 11120, 11101,
                 6384, 5872, 10243, 10254, 10296, 5264, 30724,
                 30727, 31331)),
               
               list(Genus='Eristalinus', Species='aeneus',
                 Sex='f', TempID=c(11637, 11522, 11533, 11543, 11556,
                 11520, 12436, 1076, 11667, 5435, 11519, 11521, 11525,
                 10645, 11507, 11508, 11081, 14787, 14833, 10976,
                 11636, 11668, 27339)),

               list(Genus='Tropidia', Species='quadrata', Sex='m',
                 TempID=c(1957)),
               
               list(Genus='Copestylum', Species='mexicanum',
                 Sex='f', TempID=c(5289, 37984)),
               
               list(Genus='Asemosyrphus', Species='polygrammus',
                 Sex='f', TempID=c(1025)),
               
               list(Genus='Eristalis', Species='arbustorum',
                 Sex='m', TempID=c(10253, 10248, 5857, 9341, 5709)),
               
               list(Genus='Eristalis', Species='arbustorum',
                 Sex='f', TempID=c(10247, 9421, 5423, 6123, 9374)),

               list(Genus='Eupeodes', Species='fumipennis',
                 Sex='m', TempID=c(1185, 1058, 1001, 1023, 1234,
                 10897, 1191, 1092, 1002, 22868, 1188, 1239, 405,
                 1695, 22864, 10314, 1236, 1083, 10297, 961, 27991,
                 35048, 924, 2915, 19402, 22489, 25831, 1212, 1187,
                 1072, 22491, 10574, 1681, 10258, 10257, 1094, 1148)),
               
               list(Genus='Eupeodes', Species='fumipennis',
                 Sex='f', TempID=c(10327, 1031, 10317, 981, 10831,
                 10318, 9559, 10328, 11506, 11687, 1204, 1030, 10656,
                 11339, 10326, 10805, 10244, 10319, 11638, 10846,
                 1022, 10226, 6154, 10337, 10321, 11633)),

               list(Genus='Syrphus', Species='opinator',
                 Sex='m', TempID=c(1223, 1221, 1225, 966, 965, 979,
                 1057, 1079, 1125, 982, 983, 984, 985, 986, 963,
                 1078, 16945)),
               
               list(Genus='Syrphus', Species='opinator',
                 Sex='f', TempID=c(976, 1026, 987, 988, 989, 1656,
                 1658, 1669, 1172, 968, 977, 1087, 980, 1657, 1222)),

               list(Genus='Helophilus', Species='latifrons', Sex='m',
                 TempID=c(6288, 6279, 10329, 6287, 10315, 6304, 6733,
                 6930, 19259, 30889, 26670, 2047, 10974, 1795, 2005,
                 10316, 33131, 35050, 6285, 34735, 28421, 32553,
                 22335, 6766, 33251, 27187, 1940, 1066, 11591, 12441,
                 6739, 6013, 6762, 5627, 5638, 6819, 3408, 2071, 1810,
                 5439, 6825, 10738, 6283, 5635,
                 10719, 5300, 6467, 6108, 6809)),

               list(Genus='Helophilus', Species='latifrons',
                 Sex='f', TempID=c(12442, 6788, 6266, 6143, 19089,
                 10630, 10088, 11094, 31957, 6764, 10591, 10987, 1997,
                 5640, 14929, 6146, 6113, 6160, 6286, 1904, 6303,
                 30958, 6240, 26671, 10958, 33008, 28211, 17243)),
               
               list(Genus='Ceriana', Species='tridens', Sex='m',
                 TempID=c(1687, 6469, 1689, 10098, 10256, 1828, 22348,
                 1969, 5510, 5526, 6468, 5469, 22352, 1962, 6020,
                 5481, 5468)),
               
               list(Genus='Ceriana', Species='tridens', Sex='f',
                 TempID=c(22363, 14892, 5490, 5522, 5523, 10255, 2018,
                 22349, 6213, 8740)),
               
               list(Genus='Allograpta', Species='obliqua', Sex='f',
                 TempID=c(6099, 10210, 10097, 11527, 6083, 11509,
                 11512, 15317)),
               
               list(Genus='Allograpta', Species='obliqua', Sex='m',
                 TempID=c(11526, 11285, 11664, 10654, 8754)),

               list(Genus='Allograpta', Species='exotica', Sex='f',
                 TempID=c(6097, 9707, 995, 10322, 1926, 2026, 10211,
                 1671, 11289, 11305, 1183, 6161, 6938, 6073, 10214,
                 1876, 1710, 10222, 10215, 10221, 14931)),

               list(Genus='Allograpta', Species='exotica', Sex='m',
                 TempID=c(22334, 2041, 2031, 9470, 11306, 22480,
                 2014)),
               
               list(Genus='Toxomerus', Species='occidentalis',
                 Sex='m', TempID=c(8717, 27193)),
               
               list(Genus='Toxomerus', Species='occidentalis',
                 Sex='f', TempID=c(10231, 10693, 10669, 11510, 8770,
                 11830, 29742)),

               list(Genus='Eupeodes', Species='volucris', Sex='m',
                 TempID=c(1102, 1093, 17047)),
               
               list(Genus='Eupeodes', Species='volucris', Sex='f',
                 TempID=c(14786, 6109, 14790, 10896, 6329, 10233,
                 1028, 1892)),

               list(Genus='Eristalis', Species='tenax', Sex='m',
                 TempID=c(10086, 1186, 5235, 5444)),
               
               list(Genus='Eristalis', Species='tenax', Sex='f',
                 TempID=c(1082)),

               list(Genus='Palpada', Species='alhambra', Sex='m',
                 TempID=c(10240)),
               
               list(Genus='Myathropa', Species='florea', Sex='f',
                 TempID=c(5610, 5611)),
               
               list(Genus='Pipiza', Species='', Sex='f',
                 TempID=c(11188)),
               
               list(Genus='Parhelophilus', Species='laetus', Sex='m',
                 TempID=c(29216)),
               
               list(Genus='Platycheirus', Species='stegnus', Sex='m',
                 TempID=c(992, 1232, 1823, 1825, 1106, 1189, 1048,
                 1024, 937, 1897, 1105, 1984, 1089, 2016, 1067, 974,
                 967, 1133)),

               list(Genus='Platycheirus', Species='stegnus', Sex='f',
                 TempID=c(991, 1701, 994, 1809, 1662, 1927, 1660,
                 1663, 1074, 990, 1068, 938)),

               list(Genus='Platycheirus', Species='obscurus', Sex='f',
                 TempID=c(962, 1019, 975, 1665, 1661, 1924)),

               list(Genus='Platycheirus', Species='obscurus', Sex='f',
                 TempID=c(1655, 1846)),

               list(Genus='Tropidia', Species='quadrata', Sex='m',
                 TempID=c(5425, 5431, 6231, 1182)),

               list(Genus='Tropidia', Species='quadrata', Sex='f',
                 TempID=c(2011))## ,
               
               ## list(Genus='', Species='', Sex='',
               ##   TempID=c()),
               
               ## list(Genus='', Species='', Sex='',
               ##   TempID=c())
               )

add.to.data(year=2012,
            sp.ids=sp.ids,
            case='syr',
            determiner='M. Hauser')
