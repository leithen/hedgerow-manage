rm(list=ls())
source('src/misc.R')
source('src/data_entry.R')
cat('2013/add/syrphids.R\n')

sp.ids <- list(list(Genus='Paragus', Species='haemorrhous', Sex='m',
                    TempID=c(2259, 2260, 2261, 2262, 2263, 2264, 2267,
                    2268, 2269, 2270, 2271, 2272, 2273, 2257, 2258,
                    2276, 2275, 2278, 2279, 2280, 2281, 2282, 2283,
                    2266, 2300, 2301, 2285, 2286, 2287, 2288, 2289,
                    2290, 2292, 2307, 2308, 2309, 2294, 2295, 2296,
                    2297, 2298, 2299, 2312, 2313, 2314, 2317, 2318,
                    2302, 2303, 2284, 2304, 2311, 9905, 2291, 2605,
                    2414, 2418, 2417, 2416, 2415, 2323, 2363, 2328,
                    2337, 2346, 2066, 2355, 1262, 2356, 1429, 2366,
                    1324, 2365, 1265, 2335, 2336, 2327, 2326, 2325,
                    2324, 212, 2669, 1334, 1269, 2387, 2068, 1267,
                    1766, 2367, 1335, 2353, 2352, 2362, 2351, 2361,
                    2360, 2349, 1263, 2348, 2358, 1270, 2344, 2342,
                    2332, 2341, 2331, 2340, 2330, 2339, 2329, 9296,
                    4040, 738, 5019, 8441, 3940, 5424, 5423, 8444,
                    8434, 8599, 5626, 8196, 8412, 6571, 5625, 3941,
                    4818, 6011, 5299, 739, 5918, 6572, 8438, 8086,
                    7614, 5628, 8598, 4586, 5492, 2320, 2321, 4085,
                    8440, 5425, 5621, 4153, 8567, 4152, 5226, 5224,
                    5233, 5232, 4379, 1820, 3532, 5624, 5623, 20, 442,
                    2924, 2925, 4658, 3578, 8429, 8414, 4155, 4154,
                    7616, 7219, 4159, 4142, 2447, 2439, 2440, 2322,
                    4090, 4088, 3575, 3574, 1357, 1258, 1259, 1190,
                    8439, 2345, 1430, 2347, 8435, 40, 65, 632, 1061,
                    799, 816, 814, 813, 1257, 4144, 8036, 3576, 3614,
                    3607, 3577, 19, 72, 71, 131, 135, 134, 172, 173,
                    3399, 3236, 3219, 3190, 174, 175, 177, 178, 179,
                    180, 181, 182, 3125, 197, 198, 199, 184, 185, 186,
                    188, 189, 190, 5394, 5396, 5412, 192, 279, 193,
                    194, 195, 5415, 5419, 5420, 5421, 5422, 5459,
                    5460, 201, 5393, 7929, 7922, 5708, 7919, 7920,
                    7923, 7924, 7925, 5414, 3085, 3084, 3101, 3807,
                    3730, 4083, 7927, 7921, 7948, 3108, 3058, 3057,
                    3056, 3055, 3122, 3123, 3098, 3086, 2535, 2536,
                    3121, 3120, 3119, 3118, 3117, 3115, 3114, 2534,
                    2584, 2585, 2586, 2547, 2546, 2544, 2541, 2554,
                    2552, 2549, 2563, 2560, 2558, 2557, 2574, 2571,
                    2583, 2582, 2581, 2580, 2579, 2577, 2576, 2575,
                    2210, 2441, 2446, 1275, 1274, 8179, 6493, 8274,
                    8313, 2256, 8026, 8030, 8025, 8311, 8314, 2265)),

               list(Genus='Paragus', Species='haemorrhous', Sex='f',
                    TempID=c(9900, 9875, 3254, 2364, 1271, 1272, 2668,
                    2427, 1674, 2359, 2388, 2357, 1268, 1266, 1323,
                    1264, 2333, 2334, 1719, 2343, 2338, 1261, 2389,
                    1787, 1474, 2350, 2067, 8437, 7615, 6570, 4569,
                    1488, 8442, 8436, 8443, 8445, 6178, 4839, 8198,
                    8413, 3731, 4151, 9295, 5627, 4158, 5279, 3921,
                    5225, 4640, 5018, 5017, 4380, 3942, 9037, 9815,
                    7747, 5622, 4587, 6651, 5254, 6179, 6243, 3076,
                    2882, 1312, 826, 2604, 1260, 2428, 2429, 8433,
                    7969, 4150, 1045, 1044, 815, 812, 802, 801, 800,
                    2430, 2413, 21, 68, 64, 654, 620, 653, 631, 980,
                    1126, 3542, 3400, 3005, 7242, 4143, 93, 5406,
                    5413, 196, 183, 187, 176, 133, 149, 162, 7928,
                    6827, 5473, 5474, 3756, 3752, 5418, 200, 5395,
                    3069, 3062, 3099, 3097, 3095, 3083, 3082, 3100,
                    7926, 2540, 2542, 2543, 2545, 3107, 2537, 2538,
                    3116, 3081, 2564, 2565, 2548, 2550, 2551, 2553,
                    2555, 2556, 2539, 2566, 2567, 2568, 2569, 2570,
                    2572, 2559, 2561, 2562, 8310, 8309, 1273, 1276,
                    2443, 2445, 2444, 2442, 2578, 2305, 2306, 2310,
                    2293, 2277, 2573, 191, 2274, 8312, 2315, 2316,
                    2319)),

               list(Genus='Paragus', Species='haemorrhous', Sex='',
                    TempID=c()),

               list(Genus='Platycheirus', Species='stegnus', Sex='m',
                    TempID=c(5468, 974, 590, 3503, 3103, 6, 3686,
                    3866, 918, 1205, 835, 59, 7597, 3355, 833, 7598,
                    686, 1166, 770, 756, 838, 9868, 797, 3078, 7688,
                    875, 864, 879, 125, 924, 3508, 4057, 249, 250,
                    253, 254, 837, 881, 5469)),
               
               list(Genus='Platycheirus', Species='stegnus', Sex='f',
                    TempID=c(5392, 3104, 1348, 876, 821, 247, 5437,
                    60, 3079, 3886, 3751, 3349, 926, 7612, 1349, 3105,
                    3073, 836)),

               list(Genus='Toxomerus', Species='marginatus', Sex='m',
                    TempID=c(6250, 6229, 6853, 6850, 2720, 8428, 7335,
                    758, 6231, 737, 5536, 6237, 736, 5673, 6307, 759,
                    5458, 5456, 5454, 6845, 3189, 3092, 3070, 3342,
                    6971, 3500, 7036, 7035, 6618, 3096, 3064, 3068,
                    6007, 5056, 5063, 6649, 7746, 7743, 7737, 351, 91,
                    8645, 1026, 7730, 7731, 7732, 707, 571, 7696,
                    7695, 570, 8642, 7165, 7167, 7177, 267, 270, 554,
                    117, 629, 4123, 4126, 4125, 558, 555, 556, 615,
                    7971, 560, 76, 970, 1071, 1079, 1088, 859, 1028,
                    1089, 751, 6925, 1191, 2606, 1187, 7486, 7485,
                    789, 763, 761, 7484, 7033, 930, 4117, 3124, 7031,
                    257, 933, 932, 9219, 9294, 1461, 9609, 1478, 566,
                    934, 935, 9630, 9813, 8753, 7222, 7227, 7228,
                    9035, 9229, 9221, 931, 9636, 4148, 4156, 8900,
                    9507, 9517, 8899, 8715, 644, 561, 275, 7, 567,
                    7482, 7735, 4087, 7733, 7725, 7726, 7729, 9226,
                    4089, 8810, 5483, 6258, 6260, 9051, 9053, 9054,
                    9095, 9744, 7221)),

               list(Genus='Toxomerus', Species='marginatus', Sex='f',
                    TempID=c(5917, 5477, 3974, 5481, 5478, 5491, 6152,
                    5490, 6234, 6242, 6251, 6290, 353, 6567, 3243,
                    5993, 5916, 3945, 3944, 3939, 6252, 4998, 3518,
                    8464, 2679, 6854, 5675, 5674, 7324, 7344, 1490,
                    5801, 5725, 3872, 3947, 760, 7918, 7917, 5677,
                    3519, 7333, 7345, 7337, 5676, 5439, 456, 5405,
                    3938, 5707, 726, 460, 459, 6233, 5472, 5450, 5451,
                    5452, 5455, 5453, 5457, 5449, 5438, 4583, 6619,
                    6617, 3188, 3141, 3150, 6975, 3348, 5471, 3967,
                    3966, 6972, 6973, 5820, 5828, 5821, 5827, 3971,
                    5092, 9901, 9894, 6515, 6006, 6053, 6506, 6517,
                    6516, 3985, 4124, 972, 216, 6514, 6513, 6519,
                    6518, 6008, 6667, 6665, 6005, 5062, 6650, 6648,
                    6647, 6308, 6646, 4566, 5045, 7745, 7742, 7739,
                    229, 234, 235, 256, 1186, 1027, 944, 4120, 12,
                    573, 6608, 66, 77, 572, 31, 263, 9526, 9532, 9531,
                    9173, 973, 909, 1060, 969, 1418, 7738, 8465, 9283,
                    9284, 9285, 9286, 9289, 9287, 9288, 9189, 9290,
                    9291, 9292, 9293, 9158, 9157, 9178, 9179, 9183,
                    9222, 9225, 7608, 9014, 9036, 7220, 7229, 7226,
                    7225, 7224, 7223, 7579, 7567, 9832, 9625, 9224,
                    9716, 9701, 9490, 9491, 9492, 9493, 9501, 8841,
                    8842, 8844, 8845, 8846, 8847, 8849, 8851, 8852,
                    8853, 8854, 8872, 9574, 9575, 6259, 9052, 9080,
                    9081, 9083, 9109, 9099, 9717, 6501, 6499, 7736,
                    7483, 624, 6763, 6761, 6760, 6502, 7734, 8601,
                    7727, 7728, 1847, 1457, 7349, 6418, 75, 643, 7693,
                    8661, 2098, 4095, 8657, 8643, 8646, 8638, 8048,
                    7164, 7174, 1070, 1072, 1201, 1256, 1829, 1830,
                    6924, 2678, 6928, 7034, 5482, 5494, 5493, 6970,
                    1828, 6591, 90, 92, 936, 8843, 78, 7032, 208,
                    1182, 4098, 6620, 7175, 569)),

               list(Genus='Toxomerus', Species='marginatus', Sex='',
                    TempID=c()),

               list(Genus='Syritta', Species='flaviventris', Sex='m',
                    TempID=c(3452, 3451, 7191, 9056, 8897, 1713, 9278,
                    7194, 7837, 8290, 9280, 6892, 7914, 6895, 2008,
                    2009, 1424, 1184, 7193, 3692, 3693, 9010, 7241,
                    3461, 3477, 6758, 9276)),

               list(Genus='Syritta', Species='flaviventris', Sex='f',
                    TempID=c(8898, 8308, 9279, 8986, 5874, 5826, 6367,
                    6365, 6177, 3691, 3694, 3697, 6922, 6368, 9594,
                    7916, 9277, 8017, 8307, 8291, 13287, 7915, 5298,
                    7697, 6919, 9804)),

               list(Genus='Syritta', Species='pipiens', Sex='m',
                    TempID=c(1815, 7999, 8000, 8639, 8640, 8641, 6349,
                    5732, 4093, 8112, 8637, 8629, 7998, 8633, 7990,
                    8634, 1388, 440, 3887, 5091, 439, 8604, 8270,
                    8268, 8269, 8082, 1179, 63, 4094, 4896, 4972,
                    4973, 2861, 1914, 9629, 9434, 8635, 2923, 7611,
                    7613, 8072, 8073, 3015, 3698, 8632, 9860, 9861,
                    9859, 9858, 9856, 6569, 6566, 3217, 5537, 3020,
                    3794, 3793, 3810, 3017, 6920, 6921, 6923, 2063,
                    155, 167, 166, 1756, 1757, 5543, 5544, 5545, 5546,
                    2922, 735, 8122, 6917, 6918, 5528, 4974, 5391,
                    4763, 7913, 601, 5540, 5542, 5541, 589, 600, 3796,
                    3797, 3358, 3359, 3360, 4092, 8636, 3795, 3696,
                    3798, 6347, 3799)),

               list(Genus='Syritta', Species='pipiens', Sex='f',
                    TempID=c(4127, 8037, 7993, 7992, 6366, 4128, 3792,
                    3018, 7989, 7602, 6540, 7192, 7190, 8631, 2010,
                    2777, 2011, 6568, 4001, 3690, 3695, 1416, 2756,
                    3884, 4060, 724, 5390, 5539, 4837, 7912, 3927,
                    8165, 8597, 9275, 6348)),

               list(Genus='Sphaerophoria', Species='pyrrhina',
                    Sex='m', TempID=c(8045, 7740, 7744, 446, 8052,
                    8663, 8162, 8053, 8658, 4097, 8058, 966, 5013,
                    5003, 13282, 5010, 6814, 4994, 4999, 5000, 6235,
                    3091, 3802, 5011, 3161, 3080, 6254, 6840, 6851,
                    5278, 5016, 1406, 269, 217, 7240, 8039, 6413,
                    9637, 3972, 9742, 9624, 9851, 9588, 6926, 5014,
                    3166, 5001)),
               
               list(Genus='Sphaerophoria', Species='pyrrhina',
                    Sex='f', TempID=c(5002, 5389, 8987, 4081, 5277,
                    6852, 5012, 1699, 5915, 3803, 5015, 9168, 5009,
                    6253, 5006, 6839, 6248, 6236, 4997, 3936, 5005,
                    6338, 6811, 3642, 3390, 3389, 3356, 387, 6017,
                    4585, 4584, 994, 7606, 5007, 9626, 1706, 9634, 84,
                    4096, 1711, 1705, 952, 6230, 4116, 4119, 3850,
                    3688, 9138, 9572, 9573, 9104, 9055, 9633, 9586,
                    6815, 4993, 6764, 8061, 1772, 1700, 1698, 1697,
                    6927, 6844, 8659, 1696, 8056, 8038, 4118, 3819,
                    3804, 4115, 957, 8054, 4122, 6492, 8043, 8060,
                    6753, 6762, 8057, 9870, 8041, 8042, 8040, 9874,
                    9871, 3934)),

               list(Genus='Sphaerophoria', Species='contigua',
                    Sex='m', TempID=c(7680, 170, 274, 7724, 887, 953,
                    1024, 7692, 2438, 1814, 4653, 3929, 3928, 5387,
                    3689, 3013, 3930, 5008, 3748, 3937, 3933, 3932,
                    3931, 5276, 1816, 397, 333, 3357, 335, 342, 341,
                    386, 5388, 211, 3112, 86, 7691, 7600, 7601, 7580,
                    5212)),
               
               list(Genus='Sphaerophoria', Species='contigua',
                    Sex='f', TempID=c(3571, 6012, 4002, 9887, 3551,
                    5213, 811, 967, 956, 939, 938, 3361)),

               list(Genus='Sphaerophoria', Species='sulphuripes',
                    Sex='m', TempID=c(557, 788, 844, 61, 628, 213,
                    5706, 3218, 725, 215, 156, 259, 258, 783, 261,
                    130, 262, 165, 616, 113, 7604, 3949, 87)),
               
               list(Genus='Sphaerophoria', Species='sulphuripes',
                    Sex='f', TempID=c(747, 1765, 3639, 7605, 348, 116,
                    5488, 626, 163, 627, 264, 810, 9282)),

               list(Genus='Eristalis', Species='hirta', Sex='m',
                    TempID=c()),

               list(Genus='Eristalis', Species='stipator', Sex='m',
                    TempID=c()),
               
               list(Genus='Eristalis', Species='stipator', Sex='f',
                    TempID=c(7350, 9424, 9422, 2004, 3820, 6639)),
               
               list(Genus='Scaeva', Species='pyrastri', Sex='m',
                    TempID=c(608, 607, 982, 3089, 7652, 7647, 3546,
                    7463, 983, 1337, 5051, 7701, 3028, 2, 1326)),
               
               list(Genus='Scaeva', Species='pyrastri', Sex='f',
                    TempID=c(7651, 7648, 3268, 1338, 1295, 786, 645,
                    646, 3278, 981, 5253, 7645, 660, 831, 785, 35,
                    1356, 3030, 3029, 4020, 3022, 126, 755, 7462,
                    3250, 7671, 3276, 3484, 3512, 3026, 3325, 3493)),

               list(Genus='Eristalinus', Species='aeneus', Sex='m',
                    TempID=c(4105, 8826, 8823, 8821, 8816, 8815, 8814,
                    4107, 9614, 9698, 9697, 9696, 9694, 8834, 8833,
                    8832, 8831, 3411, 9593, 4191, 4101, 4190, 3667,
                    4102, 8614, 9750, 9603, 3412, 4075, 1288, 9847,
                    8813, 8615, 4103, 9484, 4192, 9585, 3418, 3779,
                    3778, 4194, 3669, 1991, 769, 1996, 768, 6510,
                    6956, 6278, 3420, 3419, 3414, 3413, 6415, 3009,
                    3780, 4795, 4798, 4797, 4799, 4800, 1804, 1802,
                    6504, 13283, 13284, 4761, 4762, 4049, 5293, 5297,
                    5295, 465, 464, 7904, 4796, 1989, 1759, 1958,
                    1990, 164, 1995, 4533, 4535, 4538, 4539, 9863,
                    4068, 767, 1875)),
               
               list(Genus='Eristalinus', Species='aeneus', Sex='f',
                    TempID=c(8830, 3665, 2062, 3668, 7180, 3776, 3777,
                    4193, 8817, 7179, 9739, 9695, 6496, 8828, 9498,
                    3666, 8088, 4104, 8829, 8827, 8825, 8824, 8822,
                    8820, 2061, 8819, 8818, 3417, 3416, 4106, 3388,
                    6495, 8759, 9693, 9499, 9519, 8860, 6860, 7299,
                    6508, 6509, 5485, 5484, 6345, 6280, 6279, 6268,
                    1679, 1680, 1998, 4534, 5292, 5296, 5294, 7903,
                    7905, 5667, 6511, 1992, 1997, 2776, 921, 6497,
                    1994, 1993, 3663, 3664)),

               list(Genus='Tropidia', Species='quadrata', Sex='m',
                    TempID=c(2607)),

               list(Genus='Tropidia', Species='quadrata', Sex='f',
                    TempID=c(3354, 5173)),
               
               list(Genus='Copestylum', Species='mexicanum',
                    Sex='m', TempID=c(13285, 2203)),

               list(Genus='Copestylum', Species='mexicanum',
                    Sex='f', TempID=c(2206)),
               
               list(Genus='Asemosyrphus', Species='polygrammus',
                    Sex='m', TempID=c(3213)),

               list(Genus='Asemosyrphus', Species='polygrammus',
                    Sex='f', TempID=c(1007, 7431, 3926)),
               
               list(Genus='Eristalis', Species='arbustorum', Sex='m',
                    TempID=c(7906, 3650, 4099, 3843, 1607, 4590, 5080,
                    6645, 6641, 2680, 3781, 1606, 7006, 3415)),
               
               list(Genus='Eristalis', Species='arbustorum', Sex='f',
                    TempID=c(7351, 3845, 2005, 4650, 4592, 4591, 8608,
                    6642, 1988, 6640, 4989, 3830, 4077, 4108, 1999,
                    1678)),

               list(Genus='Eupeodes', Species='fumipennis', Sex='m',
                    TempID=c(3303, 3302, 3301, 3300, 3299, 7473, 7474,
                    7475, 7477, 7476, 7478, 7479, 7466, 7467, 7468,
                    7469, 7470, 7472, 7646, 7658, 7657, 7656, 7674,
                    7654, 7653, 7687, 7675, 7672, 7668, 7683, 7678,
                    7667, 7659, 7660, 7686, 7685, 7689, 7465, 7464,
                    5475, 3878, 4012, 4013, 3044, 4044, 3252, 3025,
                    244, 3023, 3212, 3506, 4011, 3043, 1340, 1343,
                    1344, 847, 648, 912, 913, 915, 923, 960, 917, 916,
                    1198, 112, 1197, 1196, 979, 962, 1203, 1202, 1200,
                    1199, 1193, 1194, 1195, 978, 991, 986, 987, 988,
                    989, 1155, 809, 798, 782, 999, 998, 1005, 2437,
                    1067, 992, 993, 7684, 865, 897, 863, 860, 984,
                    1084, 7596, 7594, 7590, 7587, 7573, 1615, 7708,
                    7710, 7706, 7713, 7714, 7702, 7704, 7705, 7699,
                    7700, 7707, 7703, 2672, 682, 2533, 1281, 3314,
                    7718, 7679, 3267, 3238, 3239, 3046, 3240, 3253,
                    100, 94, 829, 99, 98, 97, 96, 5486, 95, 4050,
                    3745, 4991, 4990, 5476, 4051, 5466, 5465, 4052,
                    3914, 3915, 3042, 3515, 1625, 3882, 3892, 3913,
                    1157, 683, 9862, 9865, 9866, 9867, 636, 36, 74, 3,
                    3367, 705, 7650, 688, 670, 7663, 7664, 2397, 661,
                    647, 637, 101, 3875, 240, 127, 3307, 3285, 3284,
                    85, 3312, 3311, 3310, 3309, 3308, 3501, 3499,
                    3306, 3305, 3489, 3353, 3502, 241, 243, 3498,
                    3491, 3490, 3283, 3281, 3488, 3344, 3487, 3486,
                    3485, 3483, 3482, 3184, 3266, 3481, 3480, 3479,
                    3261, 3262, 3263, 3264, 3265, 239, 3269, 3270,
                    3271, 3272, 3273, 3274, 3275, 3282, 3280, 3277,
                    3279, 3286, 3287, 3288, 3289, 3297, 3298, 3296,
                    3295, 3294, 3293, 3292, 3291, 3290, 3304, 3241,
                    3879, 3514, 7655, 9864)),
               
               list(Genus='Eupeodes', Species='fumipennis', Sex='f',
                    TempID=c(7599, 7588, 1165, 1154, 9581, 8835, 1342,
                    1345, 1300, 7665, 3620, 7712, 3632, 694, 614, 609,
                    238, 7471, 7669, 7677, 6507, 3024, 3883, 3880,
                    961, 3185, 232, 4053, 4992)),

               list(Genus='Syrphus', Species='opinator', Sex='m',
                    TempID=c(679, 677, 669, 662, 667, 1052, 1040, 24,
                    676, 668, 665, 663, 664, 671, 684, 658, 656, 655,
                    696, 3034, 102, 3031, 610, 2646, 832, 1152, 781,
                    1039, 697, 849, 9892, 9891, 9890, 9893, 678, 700,
                    680)),
               
               list(Genus='Syrphus', Species='opinator', Sex='f',
                    TempID=c(1050, 819, 672, 674, 666, 675, 7711,
                    1041, 1151, 820, 3033, 3260, 7649, 3918, 985,
                    1153, 830, 3547, 775, 690, 673, 23, 1156, 659,
                    914, 576, 302, 689, 30, 685)),

               list(Genus='Syrphus', Species='torvus', Sex='m',
                    TempID=c(1082, 657)),
               
               list(Genus='Syrphus', Species='torvus', Sex='f',
                    TempID=c()),

               list(Genus='Helophilus', Species='latifrons', Sex='m',
                    TempID=c(3832, 13286, 5586, 3654, 4010, 3829,
                    3647, 3827, 3655, 6175, 6056, 3821, 3652, 3648,
                    3410, 3823, 3825, 3834, 3923, 3890, 3826, 6644,
                    1441, 5547, 4555, 3844, 3837, 5385, 3835, 6643,
                    4853, 3839, 5, 5384, 3211, 3964, 3841, 3836, 3210,
                    3656, 8985, 7593)),

               list(Genus='Helophilus', Species='latifrons', Sex='f',
                    TempID=c(5943, 5404, 9421, 6908, 5386, 3828, 3838,
                    3653, 3833, 3831, 3824, 3651, 3864, 3649, 8, 3646,
                    3187, 3215, 3840, 326, 3214, 4076, 3066, 3343,
                    6226, 6272, 6273, 1824, 237, 435, 6274, 6275,
                    6276, 6277, 5585, 1339, 1676, 2006, 2000, 2001,
                    2002, 2003, 1825, 7003, 7352, 1677, 3842, 9828,
                    9043, 7591, 7592, 9751, 4648, 5403, 1, 5587)),
               
               list(Genus='Ceriana', Species='tridens', Sex='m',
                    TempID=c(9895, 9896, 3331, 3330, 3384, 9012, 4909,
                    9897, 577, 1293, 3332, 3329, 4580, 3383, 3381,
                    3386, 3328, 4905, 4906, 681, 575, 4520, 4908)),
               
               list(Genus='Ceriana', Species='tridens', Sex='f',
                    TempID=c(3387, 3010, 4907, 3385, 3382, 3333, 4910,
                    3999, 3998, 4830, 9011)),
               
               list(Genus='Allograpta', Species='obliqua', Sex='f',
                    TempID=c(3619, 3350, 3216, 5036, 6422, 9281, 3871,
                    1178, 6423)),
               
               list(Genus='Allograpta', Species='obliqua', Sex='m',
                    TempID=c(6421, 5825)),
               
               list(Genus='Allograpta', Species='obliqua', Sex='',
                    TempID=c()),

               list(Genus='Allograpta', Species='exotica', Sex='f',
                    TempID=c(5489, 4654, 3755, 3351, 3870, 3750, 1810,
                    964, 38, 39, 1043, 958, 959, 7610, 4911, 3049,
                    3048, 7607, 1695, 1714, 1764, 1982, 210, 5470,
                    9326, 1735, 955, 9873, 9869, 8644, 7694, 3818,
                    4045, 4047, 4058, 968, 954, 9612, 3494, 965, 62)),

               list(Genus='Allograpta', Species='exotica', Sex='m',
                    TempID=c(9699, 3113, 776, 1023, 9769, 1600, 3572,
                    6453, 2247, 3032, 9872)),
               
               list(Genus='Toxomerus', Species='occidentalis',
                    Sex='m', TempID=c(8840, 625, 3867, 3869)),
               
               list(Genus='Toxomerus', Species='occidentalis',
                    Sex='f', TempID=c(3749, 3640, 6299, 6298, 568,
                               8850)),

               list(Genus='Eupeodes', Species='volucris', Sex='m',
                    TempID=c(3555, 3315, 3316, 3324, 3323, 3322, 3321,
                    3320, 3319, 3318, 3317, 708, 37, 613, 108, 3345,
                    132, 5487, 332, 3036, 3047, 5467, 963, 951, 1002,
                    1001, 3513, 5436, 3888, 2681, 5055, 4041, 6512,
                    4022, 5058, 4026, 4054, 3894, 5417, 359, 454, 466,
                    3242, 7682, 7681, 7676, 7670, 7673, 7666, 7662,
                    7480, 7690, 649, 922, 1204, 1206, 1289, 1210,
                    1209, 1208, 1207, 1078, 1069, 651, 26, 25, 3054,
                    3492, 7716, 7719, 7741, 7720, 7722, 7723, 7709,
                    7715, 1008, 1284, 7586, 927, 929, 7481, 9899)),
               
               list(Genus='Eupeodes', Species='volucris', Sex='f',
                    TempID=c(1068, 1336, 3925, 109, 9, 3891, 3516,
                    3517, 7661, 1341, 3045, 455, 4056, 1296, 7589,
                    9580, 9518, 252, 612, 3035)),

               list(Genus='Eristalis', Species='tenax', Sex='m',
                    TempID=c(3822)),
               
               list(Genus='Eristalis', Species='tenax', Sex='f',
                    TempID=c(4189, 1917)),

               list(Genus='Palpada', Species='alhambra', Sex='m',
                    TempID=c()),

               list(Genus='Palpada', Species='alhambra', Sex='f',
                    TempID=c(1059, 5033)),
               
               list(Genus='Myathropa', Species='florea', Sex='f',
                    TempID=c(9902)),
               
               list(Genus='Pipiza', Species='', Sex='f',
                    TempID=c()),
               
               list(Genus='Parhelophilus', Species='laetus', Sex='m',
                    TempID=c()),
               
               list(Genus='Eumerus', Species='strigatus', Sex='m',
                    TempID=c(6757, 5177)),
               
               list(Genus='Eumerus', Species='strigatus', Sex='f',
                    TempID=c(5126, 7016, 9523, 9365, 5127, 6756)),
               
               list(Genus='Platycheirus', Species='obscurus', Sex='m',
                    TempID=c(687, 1042, 878, 3507, 874, 880)),

               list(Genus='Platycheirus', Species='obscurus', Sex='f',
                    TempID=c(11, 877)),

               list(Genus='Platycheirus', Species='quadratus', Sex='m',
                    TempID=c(7603, 7721, 3106)),

               list(Genus='Platycheirus', Species='quadratus', Sex='f',
                    TempID=c(3067, 3948, 5480))## ,
               
               ## list(Genus='', Species='', Sex='',
               ##   TempID=c()),
               
               ## list(Genus='', Species='', Sex='',
               ##   TempID=c())

               )

add.to.data(year=2013,
            sp.ids=sp.ids,
            case='syr',
            determiner='M. Hauser')
