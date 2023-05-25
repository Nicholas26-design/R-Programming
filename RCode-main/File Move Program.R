
### Basic packages to install before beginning ###


# Check to see if needed packages are installed
list.of.packages <- c("devtools", "stringr", "data.table", "tidyverse", "bit64", "lubridate","sqldf", "plyr","foreach","RODBC", "zoo", "XLConnect", "readxl", "openxlsx", "gdata",
                      "mailR", "RDCOMClient", "xlsx", "XML", "rJava", "RJDBC", "methods", "timeDate", "readxl", "writexl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
install_github('omegahat/RDCOMClient')
if(length(new.packages)) install.packages(new.packages)

# require Packages
require("stringr")
require(data.table)
require(lubridate)
require(foreach)
require(RODBC)
require(mailR)
require(rJava)
require(RJDBC)
require(zoo)
require(XML)
require(methods)
require(XLConnect)
require(tidyverse)
require(readxl)
require(writexl)
require(openxlsx)
require(gdata)
require(timeDate)


# sql package
require(sqldf)
require(plyr)
require(devtools)


setwd()

# This will identify all ATB files in the folder
fileloop <- list.files(pattern="BSHSI - WEEKLY", full.names = TRUE)

# This pulls all ATB files in to create a dataframe 
BSHSIATB_df <- do.call("rbind.fill", lapply(fileloop, function(x) { 
  dat <- read.xlsx(x,sheet = 1,startRow = 1, colNames = TRUE)
  dat$fileName <- tools::file_path_sans_ext(basename(x))
  dat$filedate <- file.info(x)$ctime
  dat
}))




# This will identify all ATB files in the folder
RGHfileloop <- list.files(pattern="RGH - WEEKLY", full.names = TRUE)

# This pulls all ATB files in to create a dataframe 
RGHATB_df <- do.call("rbind.fill", lapply(RGHfileloop, function(x) { 
  dat <- read.xlsx(x,sheet = 1,startRow = 1, colNames = TRUE)
  dat$fileName <- tools::file_path_sans_ext(basename(x))
  dat$filedate <- file.info(x)$ctime
  dat
}))


BSHSIATB_df$REPORT_DATE <- as.Date(BSHSIATB_df$REPORT_DATE, origin = '1899-12-30')
BSHSIATB_df$ADM_DATE <- as.Date(BSHSIATB_df$ADM_DATE, origin = '1899-12-30')
BSHSIATB_df$DISCH_DATE <- as.Date(BSHSIATB_df$DISCH_DATE, origin = '1899-12-30')
BSHSIATB_df$BILLED_DATE <- as.Date(BSHSIATB_df$BILLED_DATE, origin = '1899-12-30')


RGHATB_df$REPORT_DATE <- as.Date(RGHATB_df$REPORT_DATE, origin = '1899-12-30')
RGHATB_df$ADM_DATE <- as.Date(RGHATB_df$ADM_DATE, origin = '1899-12-30')
RGHATB_df$DISCH_DATE <- as.Date(RGHATB_df$DISCH_DATE, origin = '1899-12-30')
RGHATB_df$BILLED_DATE <- as.Date(RGHATB_df$BILLED_DATE, origin = '1899-12-30')

BSHSIList <- split(BSHSIATB_df,BSHSIATB_df$fileName)

RGHList <- split(RGHATB_df,RGHATB_df$fileName)

xlsxFileName1 <- paste("BSHSI_ATB_Week1",".xlsx",sep="") 
xlsxFileName2 <- paste("BSHSI_ATB_Week2",".xlsx",sep="") 
xlsxFileName3 <- paste("BSHSI_ATB_Week3",".xlsx",sep="")
xlsxFileName4 <- paste("BSHSI_ATB_Week4",".xlsx",sep="")
xlsxFileName5 <- paste("RGH_ATB_Week1",".xlsx",sep="") 
xlsxFileName6 <- paste("RGH_ATB_Week2",".xlsx",sep="") 
xlsxFileName7 <- paste("RGH_ATB_Week3",".xlsx",sep="")
xlsxFileName8 <- paste("RGH_ATB_Week4",".xlsx",sep="")
#currentDate <- Sys.Date()



#Destination

setwd()

library(writexl)
write_xlsx(BSHSIList[[1]], xlsxFileName1)
write_xlsx(BSHSIList[[2]], xlsxFileName2)
write_xlsx(BSHSIList[[3]], xlsxFileName3)
write_xlsx(BSHSIList[[4]], xlsxFileName4)
write_xlsx(RGHList[[1]], xlsxFileName5)
write_xlsx(RGHList[[2]], xlsxFileName6)
write_xlsx(RGHList[[3]], xlsxFileName7)
write_xlsx(RGHList[[4]], xlsxFileName8)
