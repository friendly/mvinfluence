library(car)

data(Duncan, package="carData")
influencePlot(lm(prestige ~ income + education, data=Duncan))

# influencePlot(lm(prestige ~ income + education, data=Duncan), cex=2)
# Error in plot.xy(xy.coords(x, y), type = type, ...) : 
#   formal argument "cex" matched by multiple actual arguments

# this works
influencePlot(lm(prestige ~ income + education, data=Duncan), id=list(cex=1.2))

# test my modification to use fill ~ CookD
# applyDefaults <- car:::applyDefaults
#source("C:/R/Rprojects/mvinfluence/extra/influencePlot.R")
source(here::here("extra", "influencePlot.R"))
influencePlot(lm(prestige ~ income + education, data=Duncan), id=list(cex=1.2))

influencePlot(lm(prestige ~ income + education, data=Duncan), id=list(cex=1.2), fill.col = "red")
