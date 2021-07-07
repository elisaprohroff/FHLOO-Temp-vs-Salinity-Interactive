################ set working directory ###############################

rm(list = ls())

setwd('C:/Users/e/Desktop/Kirk REU FHLOO Data')

install.packages("cran")
install.packages("zoo")
install.packages('rlang')
install.packages(
  "ggplot2",
  repos = c("http://rstudio.org/_packages",
            "http://cran.rstudio.com")
)

###############load libraries #############################
library(ggplot2)
library(scales)
library(grid)
library(dplyr)
library(lubridate)
library(readxl)
library(tidyr)
library(plotly)
library(dygraphs)
library(xts)          # To make the conversion data-frame / xts format
library(tidyverse)
library(zoo)
#library(cran)

################ Open FHLOO as CSV ######################

FHLOO <- read.csv('FHLOO TXT - Copy.CSV', na.strings=c("-9999","NaN"))


colnames(FHLOO)

#parse date into months?? (group dates into months)


# Read the data, turn nonexistent data to "NaN"
FHLOO <- read.table("FHLOO TXT - Copy.CSV", na.strings=c("-9999","NaN"), header=T, sep=",") %>% head(2154)

colnames(FHLOO)

# Change character string to date&time in POSIXct
FHLOO$Date <- ymd_hms(FHLOO$PDT) 

#Universal Time Zone
#Date <- as.POSIXct(FHLOO$Date, tz = "UTC")

#Change POSIXct string to Date string
#FHLOO$Date_Time <- as.Date(as.POSIXct(FHLOO$Date_Time), format='%m-%d-%Y', tz = "UTC") %>% head(2154) 

class(FHLOO$Date)

# Initialize empty variable first
FHLOO$Salinity <- NA

#Fill in values
FHLOO$New <- ifelse(FHLOO$SBE37Sal_PSU >= 30, "HighSal", "LowSal")

Sal <- FHLOO$SBE37Sal_PSU

?if_else

?mutate

mutate(FHLOO$Salinity == if_else(FHLOO$SBE37Sal_PSU %>% 30:35, "HighSal", 
                                if_else(FHLOO$SBE37Sal_PSU %>%  27:29.99, "MedSal",
                                "LowSal")))

view(FHLOO$Salinity)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Scatter and Bubble Plots ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

TempSal <- ggplot(data = FHLOO, aes(x = SBE37Sal_PSU, y = SBE37Temp_C, size = pH, color = Fresh)) +
  geom_point(alpha = 0.3) +
  theme_bw()

ggplotly(TempSal)




