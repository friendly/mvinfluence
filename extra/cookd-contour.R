#' contours of cookd
#' 
library(ggplot2)
library(ggfortify)
library(dplyr)
library(car)


# calculate Cook D on a grid of values
cookd.values <- function(stres, leverage, rank, as.matrix = FALSE) {
  DF <- expand.grid(stres = stres, leverage = leverage)
  DF$cookd <- DF$stres^2 * ((1-DF$leverage)/DF$leverage) / rank
  result <- DF
  if (!as.matrix) {
    return(result)
  }
  else{
    result <- matrix(result$cookd, nrow = length(stres), ncol = length(leverage))
    rownames(result) <- round(stres, 3)
    colnames(result) <- round(leverage,3)
    names(dimnames(result)) <- list("stres", "leverage")
    return(result)
  }
}

s <- runif(4, 0.5, 1) |> sort()
l <- seq(0.1, 0.5, .1)
CD <- cookd.values(s, l, 3)
cd <- cookd.values(s, l, 3, as.matrix=TRUE)
cd

filled.contour(s, l, cd)

dunc.mod <- lm(prestige ~income + education, data = Duncan)

plot(dunc.mod, which = 5, cook.levels = seq(0.1, 0.5, .1))

influencePlot(dunc.mod)
hat   <- hatvalues(dunc.mod)
stres <- rstudent(dunc.mod)
cookd <- cooks.distance(dunc.mod)

summary(data.frame(hat,stres,cookd))

s <- seq(min(stres), max(stres), length.out = 10)
l <- seq(min(hat), max(hat), length.out = 10)
cd <- cookd.values(s, l, dunc.mod$rank, as.matrix=TRUE)

filled.contour(l, s, cd, add = TRUE)







# from: https://stackoverflow.com/questions/48962406/add-cooks-distance-levels-to-ggplot2
cd_cont_pos <- function(leverage, level, model) {sqrt(level*length(coef(model))*(1-leverage)/leverage)}
cd_cont_neg <- function(leverage, level, model) {-cd_cont_pos(leverage, level, model)}

autoplot(model, which = 5) +
  stat_function(fun = cd_cont_pos, args = list(level = 0.5, model = model), xlim = c(0, 0.25), lty = 2, colour = "red") +
  stat_function(fun = cd_cont_neg, args = list(level = 0.5, model = model), xlim = c(0, 0.25), lty = 2, colour = "red") +
  scale_y_continuous(limits = c(-2, 2.5))
