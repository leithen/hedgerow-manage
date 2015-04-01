cat('manage/spraying/spray_clean.R\n')

## spraying records
f <- function(year) {
  s <- sprintf('records/%d PUR CALAG.csv', year)
  d.chemical <- read.csv(file.path('data/original/spraying', s),
                         as.is=TRUE)
  names(d.chemical)[names(d.chemical)=='Appl..Method'] <-
    'Application.Method'
  names(d.chemical)[names(d.chemical)=='EPA.Reg.No'] <-
    'epa.reg.no'

  if(year==2007)
    d.chemical$epa.reg.no <- paste(d.chemical$MFG,
                                   d.chemical$SEQ,
                                   d.chemical$ALPHA, sep='-')

  cols.keep <- c('PermitNum',
                 'Permitee',
                 'Site.ID',
                 'epa.reg.no',
                 'Commodity',
                 'Application.Method',
                 'Application.Date',
                 'Application.Time', 
                 'Quantity.Used',
                 'Quantity.Units',
                 'Planted.Amount',
                 'Planted.Units', 
                 'Treated.Amount',
                 'Treated.Units',
                 'key')
  d.chemical <- d.chemical[,colnames(d.chemical) %in% cols.keep]

  cols.keep[!cols.keep %in% colnames(d.chemical)]
  
  ## ------------------------------
  ## date & Julian date
  if('Application.Date' %in% colnames(d.chemical)) {
    d.chemical$Application.Date <-
      as.Date(d.chemical$Application.Date, format='%m/%d/%Y')
    d.chemical$JulianDate <-
      strptime(d.chemical$Application.Date, '%Y-%m-%d')$yday + 1
  }
  ## ------------------------------

  ## ------------------------------
  ## Quantity.Used & Quantity.Units
  if('Quantity.Used' %in% colnames(d.chemical)) {
    d.chemical$Quantity.Used <-
      as.numeric(gsub(',', '', d.chemical$Quantity.Used))
  }

  ## ------------------------------
  if('Quantity.Units' %in% colnames(d.chemical)) {
    units <- d.chemical$Quantity.Units
    d.chemical$Quantity.Used[units=='Pounds'] <-
      d.chemical$Quantity.Used[units=='Pounds'] * 453.592
    units[units=='Pounds'] <- 'Grams'
    ## note that some of the below 'ounce' measurements may actually be
    ## fluid oz - I have no way of knowing which is correct
    d.chemical$Quantity.Used[units=='Ounce'] <-
      d.chemical$Quantity.Used[units=='Ounce'] * 29.5735
    units[units=='Ounce'] <- 'Milliliters'
    d.chemical$Quantity.Used[units=='Pint'] <-
      d.chemical$Quantity.Used[units=='Pint'] * 473.176
    units[units=='Pint'] <- 'Milliliters'
    d.chemical$Quantity.Used[units=='Quart'] <-
      d.chemical$Quantity.Used[units=='Quart'] * 946.353
    units[units=='Quart'] <- 'Milliliters'
    d.chemical$Quantity.Used[units=='Gallon'] <-
      d.chemical$Quantity.Used[units=='Gallon'] * 3785.41
    units[units=='Gallon'] <- 'Milliliters'
    d.chemical$Quantity.Units <- units
  }
  
  ## ------------------------------
  ## Planted.Amount & Planted.Units
  if('Planted.Amount' %in% colnames(d.chemical)) {
    tmp <- d.chemical$Planted.Amount
    d.chemical$Planted.Amount <- as.numeric(gsub(',', '', tmp))
    ## ------------------------------
    drop <- c('', 'MISCELLANEOUS UNITS')
    if(any(d.chemical$Planted.Units %in% drop))
      d.chemical <-
        d.chemical[-which(d.chemical$Planted.Units %in% drop),]
    units <- d.chemical$Planted.Units
    d.chemical$Planted.Amount[units=='ACRES'] <-
      d.chemical$Planted.Amount[units=='ACRES'] * 4046.86
    units[units=='ACRES'] <- 'SquareMeters'
    d.chemical$Planted.Amount[units=='SQUARE FEET'] <-
      d.chemical$Planted.Amount[units=='SQUARE FEET'] * 0.092903
    units[units=='SQUARE FEET'] <- 'SquareMeters'
    d.chemical$Planted.Units <- units
  }
  
  ## ------------------------------
  ## Treated.Amount & Treated.Units
  if('Treated.Amount' %in% colnames(d.chemical)) {
    d.chemical$Treated.Amount <-
      as.numeric(gsub(',', '', d.chemical$Treated.Amount))
    ## ------------------------------
    units <- d.chemical$Treated.Units
    if(year==2007) {
      units[units=='A'] <- 'ACRES'
      units[units=='S'] <- 'SQUARE FEET'
    }
    if(year==2009)
      units[units==''] <- 'ACRES'
    d.chemical$Treated.Amount[units=='ACRES'] <-
      d.chemical$Treated.Amount[units=='ACRES'] * 4046.86
    units[units=='ACRES'] <- 'SquareMeters'
    d.chemical$Treated.Amount[units=='SQUARE FEET'] <-
      d.chemical$Treated.Amount[units=='SQUARE FEET'] * 0.092903
    units[units=='SQUARE FEET'] <- 'SquareMeters'
    d.chemical$Treated.Units <- units
  }
  
  ## ------------------------------
  d.chemical$key <- paste(year,
                          tolower(d.chemical$PermitNum),
                          tolower(d.chemical$Site.ID),
                          sep=";")

  ## ------------------------------
  ## drop last term from epa number (not needed)
  epa.split <- strsplit(d.chemical$epa.reg.no, split='-')
  epa.reg.nos <- paste(sapply(epa.split, function(x) x[[1]]),
                       sapply(epa.split, function(x) x[[2]]),
                       sapply(epa.split, function(x) x[[3]]),
                       sep='-')
  d.chemical$epa.reg.no <- epa.reg.nos

  cat("---", year, "---", "\n")
  cat(dim(d.chemical), "\n")
  cat(dim(unique(d.chemical)), "\n")

  missing.cols <- cols.keep[!cols.keep %in% colnames(d.chemical)]
  for(col in missing.cols) {
    d.chemical <- cbind(d.chemical, rep(NA, nrow(d.chemical)))
    colnames(d.chemical)[ncol(d.chemical)] <- col
  }
  d.chemical <- d.chemical[,cols.keep]
  unique(d.chemical)
}

years <- c(2006:2014)
loaded <- lapply(years, f)
if(any(sapply(loaded, function(x) any(names(x)!=names(loaded[[1]])))))
  cat("ERROR in chemical_info.R\n")
spraying.info <- do.call(rbind, loaded)
spraying.info$Year <- rep(years, sapply(loaded, nrow))
file.name <- 'data/my_data/spraying/records.csv'
write.csv(spraying.info, file=file.name, row.names=FALSE)
