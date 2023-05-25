## Connect DB & pull base dataset if using SQL Server


dbohandle <- odbcDriverConnect("driver={SQL Server};server=servername;database=databasename;trusted_connection=true")




Dataframe_df <- sqlQuery(dbohandle, "
SELECT
*
FROM
TABLE A
LEFT OUTER JOIN TABLE#2 B ON A.column=B.column 
")

OR

## Connect DB & pull base dataset from something like Azure. 

server <- "Servername"
database = "databasename"
con <- DBI::dbConnect(odbc::odbc(),
                      UID = rstudioapi::askForPassword("email address"),
                      Driver="ODBC Driver 17 for SQL Server",
                      Server = server, Database = database,
                      Authentication = "ActiveDirectoryInteractive")
