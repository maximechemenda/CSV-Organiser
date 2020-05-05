DATA = read.csv("~/Desktop/WW_patent_2010_2019.csv", header = TRUE, sep =",", nrows=20)

#only keeps the columns 5,6,8,9
withCorrectColumns = DATA[c(5,6,8,9)]
head(withCorrectColumns)