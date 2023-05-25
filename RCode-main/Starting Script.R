

# Check to see if needed packages are installed
list.of.packages <- c("devtools", "stringr", "data.table", "tidyverse", "bit64", "lubridate","sqldf", "plyr","foreach","RODBC", "zoo", "XLConnect", "readxl", "openxlsx", "gdata",
                      "mailR", "RDCOMClient", "xlsx", "XML", "rJava", "RJDBC", "methods", "timeDate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# require Packages
require("stringr")
require(data.table)
require(bit64)
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
require(openxlsx)
require(gdata)
require(timeDate)


# sql package
require(sqldf)
require(plyr)
require(devtools)

library(foreign)
library(readxl)

#For the export stage
library(writexl)


######### EMAIL ###########

install.packages('RDCOMClient', repos = 'http://www.omegahat.net/R/')
require(RDCOMClient)

OutApp <- COMCreate("Outlook.Application")
outMail = OutApp$CreateItem(0)
outMail[["SentOnBehalfOfName"]] = "insert here"
outMail[["To"]] = "inser here"
outMail[["subject"]] = "insert here"
outMail[["body"]] = "

 " 

outMail$Send()   
