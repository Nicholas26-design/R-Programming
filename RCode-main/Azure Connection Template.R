## This framework was used to deliver enterprise reporting that involved information from different databases and servers that need to be presented as one. 

### Basic packages to install before beginning ### 


# Check to see if needed packages are installed
list.of.packages <- c("devtools", "stringr", "data.table", "tidyverse", "bit64", "lubridate","sqldf", "plyr","foreach","RODBC", "zoo", "XLConnect", "readxl", "openxlsx", "gdata",
                      "mailR", "RDCOMClient", "xlsx", "XML", "rJava", "RJDBC", "methods", "timeDate", "readxl", "writexl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
install.packages("RDCOMClient", repos = "http://www.omegahat.net/R")


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


################## Client ##################  



server <- "server"
database = "database"
con <- DBI::dbConnect(odbc::odbc(),
                      UID = rstudioapi::askForPassword(username),
                      Driver="ODBC Driver 17 for SQL Server",
                      Server = server, Database = database,
                      Authentication = "ActiveDirectoryInteractive")


df <- dbGetQuery(con, "SELECT 
*
FROM
TABLE
                    ")
