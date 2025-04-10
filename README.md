# Materials for "Stronger effect of temperature on body growth in cool than in warm populations suggests lack of local adaptation"

[![DOI](https://zenodo.org/badge/639325312.svg)](https://doi.org/10.5281/zenodo.15166959)

This repo contains data and R code for collating and analyzing time series of back calculated length-at-age data on perch along a latitudinal and thermal gradient in the Baltic Sea (from database KUL: https://www.slu.se/institutioner/akvatiska-resurser/databaser/kul/ and SLU). With [Anna Gårdmark](https://internt.slu.se/en/cv-originals/anna-gardmark/) and [Jan Ohlberger](http://janohlberger.com/Homepage/).


## Setup

To simply view the analyses, download the .qmd or .html files. To reproduce the results, download a zip of the repository and work locally within the RStudio project or just with R setting the project folder as your working directory. Alternatively, you can:

1. Fork the repository on GitHub

2. Create a new RStudio project and clone your fork

<!--R-package dependencies and versions are handled with [`renv`](https://rstudio.github.io/renv/articles/renv.html). Simply run `renv::restore()` to install the correct versions of all the packages needed to replicate our results. Packages are installed in a stand-alone project library for this paper, and will not affect your installed R packages anywhere else.

Once you've successfully run `renv::restore()` you can reproduce our results by running R/main-analysis/01-fit-temp-models-predict.qmd and R/main-analysis/02-fit-vbge.qmd-->

Scripts for data preparation are found in prepare-data. This repository contains all raw files needed. You can also jump straight to the analysis-scripts using data in data/for-analysis, where output from data preparation scripts are stored.
