
# manyhealth <img src="man/figures/manyhealthLogo.png" align="right" width="220"/>

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
![GitHub release (latest by
date)](https://img.shields.io/github/v/release/globalgov/manyhealth)
![GitHub Release
Date](https://img.shields.io/github/release-date/globalgov/manyhealth)
<!-- badges: end -->

manyhealth is a data package in the [many
packages](https://github.com/globalgov/) universe. It currently includes
an ensemble of datasets on international health instruments, and
[states](https://github.com/globalgov/manystates)’ membership or other
relationships to those agreements.

Please also check out
[`{manydata}`](https://github.com/globalgov/manydata) for more about the
other packages in the ‘many packages’ universe.

## How to install:

We’ve made it easier than ever to install and start analysing global
governance data in R. Simply install the core package,
[manydata](https://github.com/globalgov/manydata), as follows, and then
you can discover, install and update various “many” packages from the
console.

``` r
# install.packages(remotes)
remotes::install_github("globalgov/manydata") # this installs our core package, the only one you need to do independently
manydata::get_packages() # this prints a list of the publicly available data packages currently available
manydata::get_packages("manyhealth") # this downloads and installs the named package
```

## Data included

Once you have installed the package, you can see the different databases
and datasets included in the package using the following function.

``` r
manydata::data_contrast("manyhealth")
```

    ## Warning: Unknown or uninitialised column: `End`.

    ## Warning: Unknown or uninitialised column: `End`.

    ## actors :
    ##         Unique ID Missing Data Rows Columns        Beg End
    ## CHATHAM       203          0 %  203       5 1975-02-08  NA
    ##                                                                                                                                  URL
    ## CHATHAM https://www.chathamhouse.org/sites/default/files/field/field_document/20150120GlobalHealthArchitectureHoffmanColePearcey.pdf
    ## 
    ## agreements :
    ##       Unique ID Missing Data Rows Columns        Beg End
    ## HEIDI      2280       0.04 % 2280       4 1815-07-03  NA
    ##                                                  URL
    ## HEIDI https://www.chaire-epi.ulaval.ca/en/data/heidi

Working with ensembles of related data has many advantages for robust
analysis. Just take a look at our vignettes
[here](https://globalgov.github.io/manydata/articles/user.html).

While some packages in the many universe can and do include novel data,
much of what they offer involves standing on the shoulders of giants.
Packages from the many universe endeavour to be as transparent as
possible about where data comes from, how it has been coded and/or
relabeled, and who has done the work. As such, we make it easy to cite
both the particular datasets you use by listing the official references
in the function above, as well as the package providers for their work
assembling the data using the function below.

``` r
citation("manyhealth")
```

    ## Warning in citation("manyhealth"): no date field in DESCRIPTION file of package
    ## 'manyhealth'

    ## Warning in citation("manyhealth"): could not determine year for 'manyhealth'
    ## from package DESCRIPTION file

    ## 
    ## To cite package 'manyhealth' in publications use:
    ## 
    ##   James Hollway (NA). manyhealth: Health Agreements for the many
    ##   Universe. R package version 0.0.1.
    ## 
    ## A BibTeX entry for LaTeX users is
    ## 
    ##   @Manual{,
    ##     title = {manyhealth: Health Agreements for the many Universe},
    ##     author = {James Hollway},
    ##     note = {R package version 0.0.1},
    ##   }

## Contributing

[manydata](https://github.com/globalgov/manydata) also makes it easy to
contribute in lots of different ways.

If you have already developed a dataset salient to this package, please
reach out by flagging this as an
[issue](https://github.com/globalgov/manyhealth/issues) for us, or by
forking, further developing the package yourself, and opening a [pull
request](https://github.com/globalgov/manyhealth/pulls) so that your
data can be used easily.

If you have collected or developed other data that may not be best for
this package, but could be useful within the wider ecosystem,
[manydata](https://github.com/globalgov/manydata) includes a number of
functions that make it easy to create a new package from the many
universe and populate with clean, consistent global governance data.

If you have any other ideas about how this package or the manydata
ecosystem more broadly might better facilitate your empirical analysis,
we’d be very happy to hear from you.
