rm(list=ls())
source('src/misc.R')
source('src/data_entry.R')
cat('2012/add/wasps.R\n')

sp.ids <- list(list(Family='Chrysididae', Genus='Hedychridium', 
                 Species='soliarellae', Sex='', TempID=c(104, 587, 
                 2864, 2863, 2827)), 

               list(Family='Chrysididae', Genus='Chrysis', 
                 Species='amala', Sex='', TempID=c(5531)), 

               list(Family='Chrysididae', Genus='Chrysura', 
                 Species='inusitata', Sex='', TempID=c(2958)), 

               list(Family='Crabronidae', Genus='Belomicrus', 
                 Species='sericeum', Sex='', TempID=c(9415)), 

               list(Family='Crabronidae', Genus='Bembix', 
                 Species='americana', Sex='', TempID=c(6181)), 

               list(Family='Crabronidae', Genus='Ectemnius', 
                 Species='areuatus', Sex='', TempID=c(933)), 

               list(Family='Crabronidae', Genus='Ectemnius', 
                 Species='spinifer', Sex='', TempID=c(6030, 10266, 
                 6051, 6234, 6050, 6052, 10283, 1875, 6034, 6035, 
                 1830, 6033, 1868, 2049, 396, 6053, 8524, 9427, 1972, 
                 9398, 9331)), 

               list(Family='Crabronidae', Genus='Tachytes', 
                 Species='distinctus', Sex='', 
                 TempID=c(6438, 6232, 10155, 10134, 5791, 6206, 6236, 
                 6173, 6437, 8636, 6728, 6176, 4276, 5254, 6205, 6211, 
                 4280)), 

               list(Family='Sphecidae', Genus='Prionyx', 
                 Species='attratus', Sex='', TempID=c(2048, 5789)), 

               list(Family='Sphecidae', Genus='Prionyx', 
                 Species='parkeri', Sex='', TempID=c(5291, 10592, 
                 25211)), 

               list(Family='Sphecidae', Genus='Sphex', 
                 Species='pensylvanicus', Sex='', TempID=c(8652, 
                 11140, 11579)), 

               list(Family='Sphecidae', Genus='Chlorion', 
                 Species='aerarium', Sex='', TempID=c(11818, 22601)), 

               list(Family='Sphecidae', Genus='Chalybion', 
                 Species='californicum', Sex='', TempID=c(5343)), 

               list(Family='Sphecidae', Genus='Isodontia', 
                 Species='elegans', Sex='', TempID=c(2212)), 

               list(Family='Sphecidae', Genus='Sceliphron', 
                 Species='caementarium', Sex='', TempID=c(5292, 10493, 
                 10120)), 
               
               ## the following was id-ed by J.M. Carpenter 2013

               list(Family='Vespidae', Genus='Polistes',
                    Species='dorsalis', Subspecies = 'californicus', Sex='',
                    TempID=c(2028, 2054, 5859, 17016)),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Polistes',
                 Species='dominula', Sex='', TempID=c(1911, 18, 1122,
                 1781, 1782, 17669, 17682, 10121, 6216, 8640, 8641,
                 8655, 5382, 1685, 5457, 6174, 5996, 5861, 6215, 1804,
                 1860, 1945, 1797, 1798, 1859, 5298, 10125, 2030,
                 6256, 5870, 8430)),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Eumenes',
                 Species='crucifera', Sex='', TempID=c(5763, 6265,
                 5209, 5742)),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Ancistrocerus',
                 Species='catskill', Sex='', TempID=c(5862, 1967)),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Ancistrocerus',
                 Species='spilogaster', Sex='', TempID=c(5873)),
               
               ## the following was id-ed by J.M. Carpenter 2013

               list(Family='Vespidae', Genus='Polistes',
                 Species='aurifer', Sex='', TempID=c(1827, 1966,
                 10133, 6178, 1050, 1959, 1822, 9287, 5753, 5871,
                 5311, 5301, 2022, 10438, 5860)),
               
               ## the following was id-ed by J.M. Carpenter 2013
               
               list(Family='Vespidae', Genus='Euodynerus',
                 Species='hidalgo', Sex='', TempID=c(6233, 5426, 2078,
                 1947, 5236, 6572, 5284, 5598, 6175)),
               
               ## the following was id-ed by J.M. Carpenter 2013

               list(Family='Vespidae', Genus='Euodynerus',
                 Species='annulatus', Sex='', TempID=c(8633, 1953,
                 1952, 9208, 15991, 5401, 2062, 6209, 13865, 2079,
                 10241, 6060, 5295, 9213, 6812, 6026, 10618, 5368)),
               
               ## the following was id-ed by J.M. Carpenter 2013

               list(Family='Vespidae', Genus='Stenodynerus',
                 Species='cochisensis', Sex='', TempID=c(1116, 5397,
                 6541, 1963, 1976, 1965, 10621, 1688, 8649, 5347,
                 5414, 5528, 6586, 5407, 5353, 2050, 5511)),
               
               ## the following was id-ed by J.M. Carpenter 2013

               list(Family='Vespidae', Genus='Stenodynerus',
                 Species='blandus', Sex='', TempID=c(8548, 8543, 88,
                 9432, 1831, 89, 10308, 10107, 1829, 10847)),
               
               ## the following was id-ed by J.M. Carpenter 2013
               list(Family='Vespidae', Genus='Stenodynerus',
                 Species='claremontensis', Sex='', TempID=c(9456)),
               
               ## the following was id-ed by J.M. Carpenter 2013
               list(Family='Vespidae', Genus='Leptochilus',
                 Species='irwini', Sex='', TempID=c(3098))

                 )

add.to.data(year=2012, 
            sp.ids=sp.ids, 
            case='was', 
            determiner='L. S. Kimsey')
