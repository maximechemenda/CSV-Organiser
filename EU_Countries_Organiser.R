DATA = read.csv("~/Desktop/WW_patent_2010_2019.csv", header = TRUE, sep =",")

#only keep the columns REG_CODE, CTRY_CODE, APP_YEAR, IPC
withoutUselessColumns = DATA[c(5,6,8,9)]

longIPC = DATA[,c(9)]
IPC = substring(longIPC,0,4) #keep the first 4 elements of initial IPC

library(matlab)
YEAR_COUNTMatrix = ones(length(IPC), 1)
YEAR_COUNT = YEAR_COUNTMatrix[,c(1)]

combinedData = cbind(withoutUselessColumns, IPC, YEAR_COUNT)
dataWithNewIPC = combinedData[,c(1,2,3,5,6)]

library(dplyr)
groupedData = dataWithNewIPC %>% group_by(APP_YEAR, REG_CODE, CTRY_CODE, IPC) %>% summarise(YEAR_COUNT = sum(YEAR_COUNT))

#removes the ones that have an empty IPC, and only keeps those that are in the EU 
filteredData= groupedData %>%
  filter(IPC != "", CTRY_CODE == "AT" || CTRY_CODE == "BE" || CTRY_CODE == "BG" || CTRY_CODE == "HR" || CTRY_CODE == "CY" ||
                    CTRY_CODE == "CZ" || CTRY_CODE == "DK" || CTRY_CODE == "EE" || CTRY_CODE == "FI" || CTRY_CODE == "FR" ||
                    CTRY_CODE == "DE" || CTRY_CODE == "GR" || CTRY_CODE == "HU" || CTRY_CODE == "IE" || CTRY_CODE == "IT" ||
                    CTRY_CODE == "LV" || CTRY_CODE == "LT" || CTRY_CODE == "LU" || CTRY_CODE == "MT" || CTRY_CODE == "NL" ||
                    CTRY_CODE == "PO" || CTRY_CODE == "PT" || CTRY_CODE == "RO" || CTRY_CODE == "SK" || CTRY_CODE == "SI" ||
                    CTRY_CODE == "ES" || CTRY_CODE == "SE")

APP_YEAR = filteredData[,c(1)]
REG_CODE = filteredData[,c(2)]
CTRY_CODE = filteredData[,c(3)]
IPC = filteredData[,c(4)]
YEAR_COUNT = filteredData[,c(5)]

finalData = cbind(REG_CODE, CTRY_CODE, APP_YEAR, IPC, YEAR_COUNT)

write.csv(finalData, file ="~/Desktop/EU_Ordered_WW_patent_2010_2019.csv", row.names = FALSE)


