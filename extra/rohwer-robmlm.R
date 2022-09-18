# robust regression

data(Rohwer, package="heplots")
Rohwer2 <- subset(Rohwer, subset=group==2)
rownames(Rohwer2)<- 1:nrow(Rohwer2)

Rohwer.mod  <- lm(cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss, data=Rohwer2)
Rohwer.rmod <- heplots::robmlm(cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss, data=Rohwer2)

which(Rohwer.rmod$weights < .9)

# plot the case weights

wts <- Rohwer.rmod$weights
idx <- c(5, which(wts < .9))
plot(wts, type="h",
     xlab = "Case index", 
     ylab = "Robust mlm weight",
     cex.lab = 1.25)
rect(0, .9, 33, 1.1, col=scales::alpha("gray", .25), border=NA)
points(wts, pch = 16, 
       cex = ifelse(wts < .9, 1.5, 1),
       col = ifelse(wts < .9, "red", "black"))
text(idx, wts[idx], label=idx, pos=3, cex=1.2, xpd=NA )

options(digits = 4)

cbind(coef(Rohwer.mod), coef(Rohwer.rmod))

# how much do coefficients change
abs(coef(Rohwer.mod) - coef(Rohwer.rmod))

100 * abs(coef(Rohwer.mod) - coef(Rohwer.rmod)) / abs(coef(Rohwer.mod))

