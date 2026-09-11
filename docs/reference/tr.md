# Matrix trace

Calculates the trace of a matrix

## Usage

``` r
tr(M)
```

## Arguments

- M:

  a matrix

## Value

returns the sum of the diagonal elements of the matrix

## Details

For square, symmetric matrices, such as covariance matrices, the trace
is sometimes used as a measure of size, e.g., in Pillai's trace
criterion for a MLM.

## Author

Michael Friendly

## Examples

``` r
M <- matrix(sample(1:9), 3,3)
tr(M)
#> [1] 15
```
