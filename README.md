# Non-linear growth-temperature relationship leads to opposite response to warming in cold versus warm populations

This repo contains data and R code (Jan, Max) for collating and analyzing time series of back calculated length-at-age data on perch along a latitudinal and thermal gradient in the Baltic Sea (from database KUL: https://www.slu.se/institutioner/akvatiska-resurser/databaser/kul/ and SLU)

With [Anna Gårdmark](https://internt.slu.se/en/cv-originals/anna-gardmark/) and [Jan Ohlberger](http://janohlberger.com/Homepage/)

## How to replicate our analyses and navigate this repo

`data/for-analysis/` Contains merged and cleaned data size-at-age data. Temperature data will be made available.

`R/prepare-data` Scripts for cleaning and exploring size-at-age data and temperature data

`R/analyze-data` Scripts for fitting GLMMs with smooths (temperature) and von Bertalanffy models + Sharpe Schoolfield models to size-at-age data

`figures` Contains all main and supporting figures (`figures/supp`)

You can also download this repo and view knitted html files of all .qmd
scripts

## Main packages and version used:
"other attached packages" (from `sessionInfo()`)

[1] here_1.0.1         
[2] sdmTMBextra_0.0.1  
[3] sdmTMB_0.3.0.9001  
[4] ggsidekick_0.0.2   
[5] patchwork_1.1.2    
[6] minpack.lm_1.2-3   
[7] viridis_0.6.2      
[8] viridisLite_0.4.1  
[9] RColorBrewer_1.1-3 
[10] broom_1.0.4        
[11] nls.multstart_1.2.0
[12] rTPC_1.0.2         
[13] tidylog_1.0.2      
[14] lubridate_1.9.2    
[15] forcats_1.0.0      
[16] stringr_1.5.0      
[17] dplyr_1.1.2        
[18] purrr_1.0.1        
[19] readr_2.1.4        
[20] tidyr_1.3.0        
[21] tibble_3.2.1       
[22] ggplot2_3.4.2      
[23] tidyverse_2.0.0  
