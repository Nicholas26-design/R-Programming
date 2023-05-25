Basics:

# This will identify all  files in the file path
fileloop <- list.files(pattern="xyz", full.names = TRUE)

# This pulls all  files in to create a dataframe 
dataframe_df <- do.call("rbind.fill", lapply(fileloop, function(x) { 
  dat <- read.xlsx(x,sheet = 1,startRow = 1, colNames = TRUE)
  dat$fileName <- tools::file_path_sans_ext(basename(x))
  dat$filedate <- file.info(x)$ctime
  dat
}))

setwd()



# This will identify all  files in the folder
Facilityfileloop <- list.files(pattern="Facility", full.names = TRUE)

# This pulls all  files in to create a dataframe 
Facility_df <- do.call("rbind.fill", lapply(Facilityfileloop, read.csv, check.names = FALSE))





# Join Facility column
dataframe2 <- sqldf("select 
a.*,b.Facility from dataframe_df a
                       left join Facility_df b on a.Fac_Name = b.Fac_Name")




dataframe_df3 <- sqldf("select
                     *
                     from
                     NThrive_df2
                     ")


NThrive_df3$File_Date <- substring(NThrive_df3$fileName, 26, 35)
NThrive_df3$File_Date <- gsub(" ","",NThrive_df3$File_Date)
NThrive_df3$File_Date <- as.Date(NThrive_df3$File_Date, origin = '1899-12-30')
NThrive_df3$Stmt_Thru2 <- as.Date(NThrive_df3$Stmt_Thru, format='%m/%d/%Y')
NThrive_df3$Account_Age <- difftime(NThrive_df3$File_Date, NThrive_df3$Stmt_Thru2)
NThrive_df3$Account_Age <- as.numeric(NThrive_df3$Account_Age)
NThrive_df3$File_Batch <- as.character(ifelse(grepl("AM_",NThrive_df3$fileName), "AM","PM"))
NThrive_df3$File_Time <- substring(NThrive_df3$filedate, 11, 20)






NThrive_df3$AGE_BUCKET <- as.character(ifelse(NThrive_df3$Account_Age < 4, "0-3 Days",
                                              ifelse(NThrive_df3$Account_Age < 9, "4-8 Days",
                                                     ifelse(NThrive_df3$Account_Age < 12, "9-12 Days",
                                                            ifelse(NThrive_df3$Account_Age >= 12, "Over 12 Days", "0-4 Days")))))
NThrive_df3$LABEL <- as.character("NTHRIVE")




#removes spaces
NThrive_df3$TotalCharges <- gsub(" ","", NThrive_df3$Total_Charges)
#removes commas
NThrive_df3$TotalCharges <- gsub("\\,","", NThrive_df3$TotalCharges)
NThrive_df3$TotalCharges <- as.numeric(NThrive_df3$TotalCharges)

#Flag creation
NThrive_df3$LBHflag <- as.character(substring(NThrive_df3$AccountNumber, 1, 2))
#Condition creation
NThrive_df3$LBH <- ifelse( NThrive_df3$LBHflag== "45", "LIFEBRIDGE", NThrive_df3$MARKET)
                          

#######SUBSETS###########


NThrive_df4 <- subset(NThrive_df4, NThrive_df4$LBH != "LIFEBRIDGE")


# Apply last transform steps via sqldf


Final_df <- sqldf("select
                     *
                     from
                     NThrive_df4
                     ")

setwd()

xlsxFileName1 <- paste("Test File",".xlsx",sep="")
library(writexl)
write_xlsx(Final_df, xlsxFileName1)



