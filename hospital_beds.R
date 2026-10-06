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
     ylim = range(covid2020[, c("H", "C", "D")]),
     xlab = "Month (2020)", ylab = "Number of people",
     main = "COVID-19 Simulation: Hospitalised, Critical and Dead in Sydney, Jul-Dec 2020")

## C = number in critical care, D = cumulative number of deaths
lines(covid2020$date, covid2020$C, col = "purple", lwd = 2)
lines(covid2020$date, covid2020$D, col = "black", lwd = 2)
legend("topleft", legend = c("Hospitalised (beds needed)", "Critical", "Dead"),
       col = c("red", "purple", "black"), lwd = 2, bty = "n")

## show every month on the x axis
months <- seq(as.Date("2020-07-01"), as.Date("2020-12-01"), by = "month")
axis.Date(1, at = months, format = "%b")
