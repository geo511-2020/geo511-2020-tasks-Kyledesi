library(tidyverse)

dataurl = "https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.csv"

temp=read_csv("https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.csv",
              skip=1, #skip the first line which has column names
              na="999.90", # tell R that 999.90 means missing in this dataset
              col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                            "APR","MAY","JUN","JUL",  
                            "AUG","SEP","OCT","NOV",  
                            "DEC","DJF","MAM","JJA",  
                            "SON","metANN"))

summary(temp)
glimpse(temp)

temp$mean <- apply(temp[,7:9],1,mean,na.rm=T)
temp$mean

png(file = "CS2final.png", bg = "transparent")

cs2 <- ggplot(temp,aes(x = YEAR, y = mean)) + 
  geom_line(colour = "black", size = 1) +
  geom_smooth(colour = "red") +
  xlab("Year") +
  ylab("Mean Summer temperatures (C)") +
  ggtitle("Mean Summer Temperature in Buffalo, NY", "Months included are: June, July, August \n Data from Global Historical Network \n Red Line is LOESS smooth")
cs2
#ggsave("cs2.png")