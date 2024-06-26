manyhealth <img src="man/figures/manyhealthLogo.png" align="right" width="220"/>
================================================================================

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
![GitHub release (latest by
date)](https://img.shields.io/github/v/release/globalgov/manyhealth)
![GitHub Release
Date](https://img.shields.io/github/release-date/globalgov/manyhealth)
<!-- badges: end -->

manyhealth is a data package in the [many
packages](https://github.com/globalgov/) universe. It currently includes
an ensemble of datasets on international health instruments and actors
in global health governance (states, IGOs, NGOs, and other private
actors).

Please also check out
[`{manydata}`](https://github.com/globalgov/manydata) for more about the
other packages in the ‘many packages’ universe.

How to install:
---------------

We’ve made it easier than ever to install and start analysing global
governance data in R. Simply install the core package,
[manydata](https://github.com/globalgov/manydata), as follows, and then
you can discover, install and update various “many” packages from the
console.

    # install.packages(remotes)
    remotes::install_github("globalgov/manydata") # this installs our core package, the only one you need to do independently
    manydata::call_packages() # this prints a list of the publicly available data packages currently available
    manydata::call_packages("manyhealth") # this downloads and installs the named package

Data included
-------------

Once you have installed the package, you can see the different datasets
included in the specific datacube in the package using the following
function.

    manydata::call_sources("manyhealth", "agreements")

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

    citation("manyhealth")

    ## To cite manyhealth in publications use:
    ## 
    ##   J. Hollway. Health agreements for manydata. 2022.
    ## 
    ## A BibTeX entry for LaTeX users is
    ## 
    ##   @Manual{,
    ##     title = {manyhealth: Health Agreements for the many Universe},
    ##     author = {James Hollway},
    ##     year = {2022},
    ##     url = {https://github.com/globalgov/manyhealth},
    ##   }

Contributing
------------

[`{manypkgs}`](https://github.com/globalgov/manypkgs) also makes it easy
to contribute in lots of different ways.

If you have already developed a dataset salient to this package, please
reach out by flagging this as an
[issue](https://github.com/globalgov/manyhealth/issues) for us, or by
forking, further developing the package yourself, and opening a [pull
request](https://github.com/globalgov/manyhealth/pulls) so that your
data can be used easily.

If you have collected or developed other data that may not be best for
this package, but could be useful within the wider ecosystem,
[manypkgs](https://github.com/globalgov/manypkgs) includes a number of
functions that make it easy to create a new package from the many
universe and populate with clean, consistent global governance data.

If you have any other ideas about how this package or the manydata
ecosystem more broadly might better facilitate your empirical analysis,
we’d be very happy to hear from you.
