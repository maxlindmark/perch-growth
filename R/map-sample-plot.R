## Make map plot
# Map plot
library(rnaturalearth)
library(rnaturalearthdata)
library(rgdal)
library(tidyverse)
library(sf); sf::sf_use_s2(FALSE) # throws error otherwise
library(sdmTMB)
library(viridis)
library(here)
library(ggrepel)
library(RColorBrewer)
library(patchwork)
library(ggsidekick);theme_set(theme_sleek())

home <- here::here()

## BIG map
# Specify ranges for big map
ymin = 53; ymax = 69; xmin = 5; xmax = 36

map_data <- rnaturalearth::ne_countries(
  scale = "medium",
  returnclass = "sf", continent = "europe")

# Crop the polygon for plotting and efficiency:
# st_bbox(map_data) # find the rough coordinates
swe_coast <- suppressWarnings(suppressMessages(
  st_crop(map_data,
          c(xmin = xmin, ymin = ymin, xmax = xmax, ymax = ymax))))

# Transform our map into UTM 33 coordinates, which is the equal-area projection we fit in:
utm_zone33 <- 32634
swe_coast_proj <- sf::st_transform(swe_coast, crs = utm_zone33)

# Add points and use same color palette as in VBGE
# Order for plotting
order <- c("SI_HA", "BT", "TH", "SI_EK", "FM", "VN", "JM", "MU", "FB", "BS", "HO", "RA") 

nareas <- length(order)
colors <- colorRampPalette(brewer.pal(name = "RdYlBu", n = 10))(nareas)

# Read for sample size per area
vbg <- read_csv(paste0(home, "/output/vbg.csv"))

df <- data.frame(area = c("Brunskar (BS)", "Biotest (BT)", "Finbo (FB)", "Forsmark (FM)",
                          "Holmon (HO)", "Kvadofjarden (JM)", "Musko (MU)", "Ranea (RA)",
                          "Simpevarp 1 (SI_EK", "Simpevarp 2 (SI_HA", "Torhamn (TH)", "Vino (VN)"),
                 lon = c(21.5, 18.1, 19.5, 18, 20.9, 16.8, 18.1, 22.3, 16.6, 16.7, 15.9, 16.9),
                 lat = c(60, 60.4, 60.3, 60.5, 63.7, 58, 59, 65.9, 57.3, 57.4, 56.1, 57.5))

df <- add_utm_columns(df, ll_names = c("lon", "lat"), units = "m")

# Set plot ranges (crop map)
xmin <- 0
xmax <- 700000
xrange <- xmax - xmin
ymin <- 6000000
ymax <- 7500000
yrange <- ymax - ymin

# df$area <- as.factor(df$area)
# df$area2 <- factor(df$area, levels = order)

p1 <-
  ggplot(swe_coast_proj) +
  geom_sf() +
  labs(x = "Longitude", y = "Latitude") +
  xlim(xmin, xmax) +
  ylim(ymin, ymax) +
  annotate("text", label = "Sweden", x = xmin + 0.23*xrange, y = ymin + 0.6*yrange,
           color = "black", size = 4) +
  # geom_point(data = df, aes(X, Y, fill = factor(area, order)), size = 3, inherit.aes = FALSE,
  #            shape = 21, color = "white") +
  geom_point(data = df, aes(X, Y, fill = area), size = 3, inherit.aes = FALSE,
             shape = 21, color = "white") +
  geom_point(data = df, aes(X, Y, fill = area), size = 3,
             shape = 21, color = "white") +
  guides(color = "none", fill = "none") +
  geom_label_repel(data = df, aes(X, Y, label = area, color = area), size = 2.5,
                   min.segment.length = 0, seed = 1, box.padding = 0.4) +
  scale_fill_viridis(option = "viridis", discrete = TRUE) +
  scale_color_viridis(option = "viridis", discrete = TRUE) +
  NULL

p1

# here color = factor(area, order) works! but not in the plot above...
p2 <- ggplot(vbg, aes(cohort, k_median, size = n,
                      color = area, fill = area)) + 
  geom_point(shape = 21, fill = NA, stroke = 0.8) + 
  theme_sleek() + 
  #geom_smooth(se = FALSE, method = "gam", formula = y~s(x, k=4), linewidth = 0.3) +
  guides(fill = "none", color = "none", 
         size = guide_legend(override.aes = list(linetype = NA))) +
  labs(x = "Cohort", y = "Median von Bertalanffy growth coefficient, k", size = "#individuals") +
  scale_size(range = c(0.01, 2)) +
  facet_wrap(~factor(area, levels = order), ncol = 2) + 
  # scale_color_manual(values = colors, name = "Area") +
  # scale_fill_manual(values = colors, name = "Area") +
  scale_fill_viridis(option = "viridis", discrete = TRUE) +
  scale_color_viridis(option = "viridis", discrete = TRUE) +
  theme(legend.position = c(0.12, 0.07),
        legend.key.height = unit(0.01, 'cm'), 
        legend.text = element_text(size = 6),
        legend.title = element_text(size = 7),
        )

p1 + p2
  
ggsave(paste0(home, "/figures/map_sample_size.pdf"), width = 17, height = 17, units = "cm")

## TODO: I'm having trouble setting the order of the colors based on the order vector!
# It works in p2 (in the # section), i.e., then it assigns hot colors to hot areas etc, 
# but it doesn't work in the map-plot for some reason...