## load ERSST  data from downloaded .nc file
load_ersst_data <- function(years, data.dir, ncfilename, latrange, lonrange) {
  dat <- nc_open(paste(data.dir, "/", ncfilename, sep = ""))
  sst <- ncdf4::ncvar_get(dat, "sst")
  lon <- data.frame(lon = ncdf4::ncvar_get(dat, "lon")) %>%
    rownames_to_column() %>%
    rename(lon_index = rowname) %>%
    mutate(lon_index = as.numeric(lon_index))
  lat <- data.frame(lat = ncdf4::ncvar_get(dat, "lat")) %>%
    rownames_to_column() %>%
    rename(lat_index = rowname) %>%
    mutate(lat_index = as.numeric(lat_index))
  time <- data.frame(time = ncdf4::ncvar_get(dat, "time")) %>%
    rownames_to_column() %>%
    rename(time_index = rowname) %>%
    mutate(time_index = as.numeric(time_index))
  dat <- data.frame(melt(sst)) %>%
    rename(lon_index = Var1, lat_index = Var2, time_index = Var3, sst = value) %>%
    left_join(lon) %>%
    left_join(lat) %>%
    left_join(time) %>%
    dplyr::select(-c(lon_index, lat_index, time_index)) %>%
    mutate(lon = ifelse(lon > 180, -360 + lon, lon)) %>%
    filter(lat >= min(latrange) & lat <= max(latrange) & lon >= min(lonrange) & lon <= max(lonrange)) %>%
    mutate(date = as.Date(time, origin = "1800-01-01")) %>%
    mutate(year = format(date, "%Y"), month = format(date, "%m")) %>%
    filter(year >= min(years) & year <= max(years))
  write.csv(dat, paste(data.dir, "/ersst.csv", sep = ""), row.names = F)
  dat <- read_csv(paste(data.dir, "/ersst.csv", sep = "")) %>%
    group_by(year, month) %>%
    summarize(meanSST = mean(sst, na.rm = T))
  return(dat)
}
