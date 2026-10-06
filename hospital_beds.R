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
## extra left margin so the y axis title does not overlap the tick labels
par(mar = c(5, 6, 4, 2))

## y axis uses a square root scale: plot sqrt(values), then label the
## axis with the original (unsquared) numbers
plot(covid2020$date, sqrt(covid2020$H), type = "l", xaxt = "n", yaxt = "n",
     col = "red", lwd = 2,
     ylim = sqrt(c(0, max(covid2020[, c("H", "C", "D")]))),
     xlab = "Month (2020)", ylab = "",
     main = "COVID-19 Simulation: Hospitalised, Critical and Dead in Sydney, Jul-Dec 2020")

## show every month on the x axis
months <- seq(as.Date("2020-07-01"), as.Date("2020-12-01"), by = "month")
axis.Date(1, at = months, format = "%b")

## y axis ticks placed at sqrt positions but labelled with real counts
yticks <- c(0, 1000, 5000, 10000, 20000, 40000, 60000)
axis(2, at = sqrt(yticks), labels = format(yticks, big.mark = ",", trim = TRUE),
     las = 1, cex.axis = 0.8)
abline(h = sqrt(yticks), col = "grey90")
title(ylab = "Number of people (square root scale)", line = 4)

## C = number in critical care, D = cumulative number of deaths
lines(covid2020$date, sqrt(covid2020$C), col = "purple", lwd = 2)
lines(covid2020$date, sqrt(covid2020$D), col = "black", lwd = 2)

## mark the day hospital bed demand peaks
peak <- covid2020[which.max(covid2020$H), ]
abline(v = peak$date, col = "red", lty = 2)
text(peak$date, sqrt(peak$H) * 1.04, pos = 4, cex = 0.8, col = "red",
     labels = paste0("Peak: ", format(round(peak$H), big.mark = ","),
                     " beds (", format(peak$date, "%d %b"), ")"))

legend("topleft", legend = c("Hospitalised (beds needed)", "Critical", "Dead"),
       col = c("red", "purple", "black"), lwd = 2, bty = "n")
