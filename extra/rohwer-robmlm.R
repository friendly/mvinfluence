# robust regression

data(Rohwer, package="heplots")
Rohwer2 <- subset(Rohwer, subset=group==2)
rownames(Rohwer2)<- 1:nrow(Rohwer2)

Rohwer.mod  <- lm(cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss, data=Rohwer2)
Rohwer.rmod <- heplots::robmlm(cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss, data=Rohwer2)

# plot the case weights

plot(Rohwer.rmod$weights, type="h",
     xlab = "Case index", ylab = "Robust mlm weight", col="gray")
points(Rohwer.rmod$weights, pch = 16, 
       cex = ifelse(Rohwer.rmod$weights < .85, 1.5, 1),
       col = ifelse(Rohwer.rmod$weights < .85, "red", "black"))

# how much do coefficients change
