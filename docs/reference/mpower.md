# General Matrix Power

Calculates the `n`-th power of a square matrix, where `n` can be a
positive or negative integer or a fractional power.

## Usage

``` r
mpower(A, n)

A %^% n
```

## Arguments

- A:

  A square matrix. Must also be symmetric for non-integer powers.

- n:

  matrix power

## Value

Returns the matrix \\A^n\\

## Details

If `n<0`, the method is applied to \\A^{-1}\\. When `n` is an integer,
the function uses the Russian peasant method, or repeated squaring for
efficiency. Otherwise, it uses the spectral decomposition of `A`,
\\\mathbf{A}^n = \mathbf{V} \mathbf{D}^n \mathbf{V}^{T}\\ requiring a
symmetric matrix.

## References

<https://en.wikipedia.org/wiki/Exponentiation_by_squaring>

## See also

Packages corpcor and expm define similar functions.

## Author

Michael Friendly

## Examples

``` r

M <- matrix(sample(1:9), 3,3)
mpower(M,2)
#>      [,1] [,2] [,3]
#> [1,]   78   77   28
#> [2,]   87   90   46
#> [3,]  125   73   51
mpower(M,4)
#>       [,1]  [,2] [,3]
#> [1,] 16283 14980 7154
#> [2,] 20366 18157 8922
#> [3,] 22476 19918 9459

# make a symmetric matrix
MM <- crossprod(M)
mpower(MM, -1)
#>         [,1]     [,2]     [,3]
#> [1,]  0.0433 -0.01528 -0.05504
#> [2,] -0.0153  0.02311  0.00365
#> [3,] -0.0550  0.00365  0.10584
Mhalf <- mpower(MM, 1/2)
all.equal(MM, Mhalf %*% Mhalf)
#> [1] TRUE

```
