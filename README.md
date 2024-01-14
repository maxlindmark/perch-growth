# Materials for "Non-linear growth-temperature relationship leads to opposite response to warming in cold versus warm populations"

This repo contains data and R code for collating and analyzing time series of back calculated length-at-age data on perch along a latitudinal and thermal gradient in the Baltic Sea (from database KUL: https://www.slu.se/institutioner/akvatiska-resurser/databaser/kul/ and SLU). With [Anna Gårdmark](https://internt.slu.se/en/cv-originals/anna-gardmark/) and [Jan Ohlberger](http://janohlberger.com/Homepage/).


## Setup

To simply view the analyses, download the .qmd or .html files. In order to reproduce the results:

1. Fork the repository and clone to your machine (or download a local version)

2. Open R and set your working directory of the cloned repository (or just use RStudio projects)

3. This project is set up with [`renv`](https://rstudio.github.io/renv/articles/renv.html) to manage package dependencies. Inside R (and with your working directory set correctly) run `renv::restore()`. This will install the correct versions of all the packages needed to replicate our results. Packages are installed in a stand-alone project library for this paper, and will not affect your installed R packages anywhere else. 

Once you've successfully run `renv::restore()` you can reproduce our results by running R/main-analysis/food_competition.qmd and R/main-analysis/diet_overlap.qmd.

Scripts for data preparation are found in prepare-data. Some files (e.g., environmental data) are too big for github, so currently only the cleaned and processed data are included here, which are formatted for this specific analysis. You can either view the .html files to see how raw data were handled or reach out to me to get the data needed for the scripts to run.

