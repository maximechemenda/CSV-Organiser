DATA = read.csv("~/Desktop/WW_patent_2010_2019.csv", header = TRUE, sep =",", nrows=20)

#only keeps the columns REG_CODE, CTRY_CODE, APP_YEAR, IPC
withoutUselessColumns = DATA[c(5,6,8,9)]


longIPC = DATA[,c(9)]
IPC = substring(longIPC,0,4) #keeps the first 4 elements of initial IPC

combinedData = cbind(withoutUselessColumns, IPC)
dataWithNewIPC = combinedData[,c(1,2,3,5)]
head(dataWithNewIPC)