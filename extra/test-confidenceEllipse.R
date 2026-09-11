# Verify confidenceEllipse.mlm() / confidenceEllipses.mlm() for mlm objects
#
# Context: TASKS-all.md TODO -- "car already has confidenceEllipse() for this,
# but there are no examples for an mlm; also unsure whether the pairwise
# confidenceEllipses.mlm() actually works."
#
# Dataset: heplots::schooldata, already used elsewhere in the package's own
# influencePlot.mlm() examples (R/influencePlot.mlm.R).

library(car)
library(heplots)

data(schooldata, package = "heplots")
school.mod <- lm(cbind(reading, mathematics, selfesteem) ~ .,
                  data = schooldata)


# ---- 1. confidenceEllipse.mlm(): single pair of coefficients ---------------
#
# FINDING: car already ships confidenceEllipse.mlm() -- car:::confidenceEllipse.mlm
# is byte-identical to the draft in extra/confidenceEllipse.mlm.R. Nothing to add
# to mvinfluence's R/ here; it just needs a worked example in the docs/vignette.

confidenceEllipse(school.mod, which.coef = c(2, 3))
confidenceEllipse(school.mod, which.coef = c(2, 4))
confidenceEllipse(school.mod, which.coef = c(2, 5))
# xlab/ylab correctly pulled from rownames(vcov(school.mod)), i.e.
# "reading:education" / "reading:occupation"

# compare this with heplots::coefplot()
coefplot(school.mod, fill=TRUE)

# ---- 2. confidenceEllipses.mlm(): pairwise grid -----------------------------
#
# This one is mvinfluence's own addition (extra/confidenceEllipses.R), not in car.
# Not in R/ yet, so source it directly to test.

source(here::here("extra", "confidenceEllipses.R"))

# Runs without error...
confidenceEllipses(school.mod)

# ...but produces an 18x18 grid, not the intended 6x6. Root cause:
# confidenceEllipses.default() does `p <- length(coef(model))`. For an ordinary
# lm that's the number of predictor coefficients (fine). For an mlm, coef()
# returns a *matrix* (predictors x responses):
b <- coef(school.mod)
dim(b)            # 6 x 3  (6 coefficients, 3 responses)
length(b)          # 18 -- silently flattened, so p = 18 not 6

# The resulting grid mixes coefficients *across* response equations, e.g. panel
# (1, 8) compares "reading:(Intercept)" against "mathematics:education" -- not a
# comparison anyone plotting "pairwise confidence ellipses of coefficients" wants,
# and the grid grows as (predictors x responses)^2, so it gets unusable fast for
# any model bigger than this toy example (324 panels here already).
rownames(vcov(school.mod))

# ---- 3. Decision: is confidenceEllipses.mlm() worth fixing? ----------------
#
# A `response=`-selecting fix (facet by response, one p x p grid of predictor
# pairs per response) would just re-run car's ordinary univariate
# confidenceEllipses() on that response's submodel -- once you've picked a
# single response there's no multivariate content left to show. Compare:

coefplot(school.mod, variables = c(1, 2), parm = 2:6, fill = TRUE,
         main = "Bivariate coefficient plot: reading vs mathematics")

# heplots::coefplot.mlm() already covers the case that's genuinely mlm-specific:
# fix a *pair of responses* and overlay one ellipse per predictor, showing how
# each predictor's effect compares across the two response equations. It
# already ships with good examples of its own (see R/coefplot.mlm.R in heplots).
#
# CONCLUSION (2026-09-11): confidenceEllipse.mlm() is fine as-is (already
# upstream in car; just needs an mvinfluence-side doc example -- see below).
# confidenceEllipses.mlm() is NOT worth developing further -- superseded by
# heplots::coefplot(). extra/confidenceEllipse.mlm.R and
# extra/confidenceEllipses.R can be deleted once the doc example ships.
#
# REMAINING WORK: add a short "comparing coefficients" example to
# vignettes/uni-vs-multi.Rmd -- car::confidenceEllipse() for a single pair of
# mlm coefficients (as in section 1 above), cross-referencing
# heplots::coefplot() for the cross-response case.
