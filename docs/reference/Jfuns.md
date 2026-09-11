# General Classes of Influence Measures

These functions implement the general classes of influence measures for
multivariate regression models defined in Barrett and Ling (1992), Eqn
2.3, 2.4, as shown in their Table 1.

## Usage

``` r
Jtr(H, Q, a, b, f)

Jdet(H, Q, a, b, f)

COOKD(H, Q, n, p, r, m)

DFFITS(H, Q, n, p, r, m)

COVRATIO(H, Q, n, p, r, m)
```

## Arguments

- H:

  a scalar or \\m \times m\\ matrix giving the hat values for subset
  \\I\\

- Q:

  a scalar or \\m \times m\\ matrix giving the residual values for
  subset \\I\\

- a:

  the \\a\\ parameter for the \\J^{det}\\ and \\J^{tr}\\ classes

- b:

  the \\b\\ parameter for the \\J^{det}\\ and \\J^{tr}\\ classes

- f:

  scaling factor for the \\J^{det}\\ and \\J^{tr}\\ classes

- n:

  sample size

- p:

  number of predictor variables

- r:

  number of response variables

- m:

  deletion subset size

## Value

The scalar result of the computation.

## Details

There are two classes of functions, denoted \\J_I^{det}\\ and
\\J_I^{tr}\\, with parameters \\n, p, q\\ of the data, \\m\\ of the
subset size and \\a\\ and \\b\\ which define powers of terms in the
formulas, typically in the set `-2, -1, 0`.

They are defined in terms of the submatrices for a deleted index subset
\\I\\, \$\$H_I = X_I (X^T X)^{-1} X_I\$\$ \$\$Q_I = E_I (E^T E)^{-1}
E_I\$\$ corresponding to the hat and residual matrices in univariate
models.

For subset size \\m = 1\\ these evaluate to scalar equivalents of hat
values and studentized residuals.

For subset size \\m \> 1\\ these are \\m \times m\\ matrices and
functions in the \\J^{det}\\ class use \\\|H_I\|\\ and \\\|Q_I\|\\,
while those in the \\J^{tr}\\ class use \\tr(H_I)\\ and \\tr(Q_I)\\.

The functions `COOKD`, `COVRATIO`, and `DFFITS` implement some of the
standard influence measures in these terms for the general cases of
multivariate linear models and deletion of subsets of size `m>1`, but
they have not yet been incorporated into our main functions
[`mlm.influence`](http://friendly.github.io/mvinfluence/reference/mlm.influence.md)
and
[`influence.mlm`](http://friendly.github.io/mvinfluence/reference/influence.mlm.md).

## References

Barrett, B. E. and Ling, R. F. (1992). General Classes of Influence
Measures for Multivariate Regression. *Journal of the American
Statistical Association*, **87**(417), 184-191.

## Author

Michael Friendly
