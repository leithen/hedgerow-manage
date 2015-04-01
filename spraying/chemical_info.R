cat('manage/spraying/chemical_info.R\n')

path <- 'data/original/spraying'

## below is only needed so we can limit to relevant epa numbers
spray.hist <- read.csv('data/my_data/spraying/records.csv',
                       as.is=TRUE)

get.chars <- function(d, start, stop)
  sapply(d, substr, start, stop, USE.NAMES = FALSE)

load.dat <- function(s) {
  dd <- read.table(file.path(path, s), sep='\n',
                   header=FALSE, row.names=NULL,
                   colClasses=c('character'),
                   quote='', comment.char='')
  as.vector(unlist(dd))
}

## product info file
tmp <- load.dat('productdb/product.dat')
product <-
  data.frame(PRODNO=as.numeric(get.chars(tmp, 1, 7)),
             MFG_FIRMNO=as.numeric(get.chars(tmp, 8, 14)),
             LABEL_SEQ_NO=as.numeric(get.chars(tmp, 22, 26)),
             REVISION_NO=get.chars(tmp, 27, 28))
product$epa.reg.no <- c(paste(product$MFG_FIRMNO,
                              product$LABEL_SEQ_NO,
                              product$REVISION_NO, sep='-'))
product <- product[product$epa.reg.no %in% spray.hist$epa.reg.no,]

## sum(spray.hist$epa.reg.no %in% product$epa.reg.no)

## chemical info file
tmp <- load.dat('productdb/prod_chem.dat')
prod.chem <-
  data.frame(PRODNO=as.numeric(get.chars(tmp, 1, 7)),
             CHEM_CODE=as.numeric(get.chars(tmp, 8, 12)),
             CHEMSTAT_SW=get.chars(tmp, 13, 13),
             PRODCHEM_PCT=as.numeric(get.chars(tmp, 14, 22)))

## chemical vocabulary
tmp <- load.dat('productdb/chem_com.dat')
chem.com <-
  data.frame(CHEM_CODE=as.numeric(get.chars(tmp, 1, 5)),
             COMNAME=sapply(tmp, function(x)
               get.chars(x, 6, nchar(x))))

## product type
tmp <- load.dat('productdb/prod_type_pesticide.dat')
prod.type.pesticide <-
  data.frame(PRODNO=as.numeric(get.chars(tmp, 1, 7)),
             TYPEPEST_CD=get.chars(tmp, 8, 9))

## product type
tmp <- load.dat('productdb/type_pesticide.dat')
type.pesticide <-
  data.frame(TYPEPEST_CD=get.chars(tmp, 1, 2),
             TYPEPEST_CAT=get.chars(tmp, 3, 52))

## environmental hazards
tmp <- load.dat('productdb/prod_env_hazard.dat')
prod.env.hazard <-
  data.frame(PRODNO=as.numeric(get.chars(tmp, 1, 7)),
             ENVHZRD_CD=get.chars(tmp, 8, 9))

## envrionemtal hazard vocabulary
tmp <- load.dat('productdb/env_hazard.dat')
env.hazard <-
  data.frame(ENVHZRD_CD=get.chars(tmp, 1, 2),
             ENVHZRD_DSC=get.chars(tmp, 3, 52))

## --- make restultant data-set ---
chemical.info <- merge(product,
                       prod.chem, 'PRODNO')
chemical.info <- merge(chemical.info,
                       prod.type.pesticide, 'PRODNO')
chemical.info <- merge(chemical.info,
                       type.pesticide, 'TYPEPEST_CD')
chemical.info <- merge(chemical.info,
                       chem.com, 'CHEM_CODE')
chemical.info <- merge(chemical.info,
                       prod.env.hazard, 'PRODNO')
chemical.info <- merge(chemical.info,
                       env.hazard, 'ENVHZRD_CD')
rownames(chemical.info) <- NULL

chemical.info <-
  chemical.info[-which(chemical.info$COMNAME=='INERT INGREDIENTS'),]
keep <- c('epa.reg.no', 'PRODCHEM_PCT', 'CHEM_CODE', 'TYPEPEST_CAT',
          'COMNAME', 'ENVHZRD_DSC')
chemical.info <- unique(chemical.info[,keep])
names(chemical.info) <- c('epa.reg.no',
                          'prod.pct',
                          'chem.code',
                          'chem.type',
                          'common.name',
                          'hazard')
chemical.info$chem.code <- paste('chem', chemical.info$chem.code,
                                 sep='')

chemical.info <- as.data.frame(chemical.info)
write.csv(chemical.info, file='data/my_data/spraying/chemical_info.csv',
          row.names=FALSE) 

## ## combine some active ingredients
## chemical.info <- gsub(', OTHER RELATED', '', chemical.info)
## chemical.info[grep('(E)-5-DECENOL', chemical.info)] <-
##   '(E)-5-DECENYL ACETATE'
## chemical.info[grep('2,4-D', chemical.info)] <- '2,4-D'
## chemical.info[grep('AGROBACTERIUM RADIOBACTER', chemical.info)] <- 'AGROBACTERIUM RADIOBACTER'
## chemical.info[grep('BACILLUS PUMILUS', chemical.info)] <- 'BACILLUS PUMILUS'
## chemical.info[grep('BACILLUS THURINGIENSIS', chemical.info)] <- 'BACILLUS THURINGIENSIS'
## chemical.info[grep('BACILLUS SUBTILIS', chemical.info)] <- 'BACILLUS SUBTILIS'
## chemical.info[grep('CLOPYRALID', chemical.info)] <- 'CLOPYRALID'
## chemical.info[grep('COPPER SULFATE', chemical.info)] <- 'COPPER SULFATE'
## chemical.info[grep('CYPERMETHRIN', chemical.info)] <- 'CYPERMETHRIN'
## chemical.info[grep('DICAMBA', chemical.info)] <- 'DICAMBA'
## chemical.info[grep('GLYPHOSATE', chemical.info)] <- 'GLYPHOSATE'
## chemical.info[grep('IMAZETHAPYR', chemical.info)] <- 'IMAZETHAPYR'
## chemical.info[grep('LIME-SULFUR', chemical.info)] <- 'SULFUR'
## chemical.info[grep('MINERAL OIL', chemical.info)] <- 'PETROLEUM PRODUCTS'
## chemical.info[grep('MYROTHECIUM VERRUCARIA', chemical.info)] <- 'MYROTHECIUM VERRUCARIA'
## chemical.info[grep('NEEM OIL', chemical.info)] <- 'NEEM OIL'
## chemical.info[grep('PETROLEUM', chemical.info)] <- 'PETROLEUM PRODUCTS'
## chemical.info[grep('OXYTETRACYCLINE', chemical.info)] <- 'OXYTETRACYCLINE'
## chemical.info[grep('POLYHEDRAL OCCLUSION BODIES', chemical.info)] <- 'POLYHEDRAL OCCLUSION BODIES'
## chemical.info[grep('PSEUDOMONAS FLUORESCENS', chemical.info)] <- 'PSEUDOMONAS FLUORESCENS'
## chemical.info[grep('TRICLOPYR', chemical.info)] <- 'TRICLOPYR'
## chemical.info[grep('Z-8-DODECENOL', chemical.info)] <- 'Z-8-dodecenol'
