## Week 10 Practical - Version Control
## Hospital beds needed in Sydney (COVID-19 simulation), July - December 2020

## ---- Loading Data ----
covid <- read.csv("epiSEIHCRD_combAge.csv")

## t is days since 1 March 2020 - convert to calendar dates
covid$date <- as.Date("2020-03-01") + covid$t

## keep only July to December 2020
covid2020 <- subset(covid, date >= as.Date("2020-07-01") &
                           date <= as.Date("2020-12-31"))

## ---- Plotting ----
## H = number of people hospitalised = number of hospital beds needed
plot(covid2020$date, covid2020$H, type = "l", xaxt = "n",
     col = "red", lwd = 2,
     xlab = "Month (2020)", ylab = "Hospital beds needed",
     main = "COVID-19 Simulation: Hospital Beds Needed in Sydney, Jul-Dec 2020")

## show every month on the x axis
months <- seq(as.Date("2020-07-01"), as.Date("2020-12-01"), by = "month")
axis.Date(1, at = months, format = "%b")
