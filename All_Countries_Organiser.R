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

filteredData= groupedData %>%
  filter(IPC != "")

APP_YEAR = filteredData[,c(1)]
REG_CODE = filteredData[,c(2)]
CTRY_CODE = filteredData[,c(3)]
IPC = filteredData[,c(4)]
YEAR_COUNT = filteredData[,c(5)]

finalData = cbind(REG_CODE, CTRY_CODE, APP_YEAR, IPC, YEAR_COUNT)

write.csv(finalData, file ="~/Desktop/Ordered_WW_patent_2010_2019.csv", row.names = FALSE)


