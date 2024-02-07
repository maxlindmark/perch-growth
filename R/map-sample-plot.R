## Make map plot
# Map plot
library(rnaturalearth)
library(rnaturalearthdata)
#library(rgdal)
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

## Big map
# Specify ranges for big map
ymin = 53; ymax = 69; xmin = 5; xmax = 36

map_data <- rnaturalearth::ne_countries(
  scale = "large",
  returnclass = "sf", continent = "europe")

# Crop the polygon for plotting and efficiency:
# st_bbox(map_data) # find the rough coordinates
swe_coast <- suppressWarnings(suppressMessages(
  st_crop(map_data,
          c(xmin = xmin, ymin = ymin, xmax = xmax, ymax = ymax))))

# Transform our map into UTM 33 coordinates, which is the equal-area projection we are (mainly) in
utm_zone33 <- 32634
swe_coast_proj <- sf::st_transform(swe_coast, crs = utm_zone33)

# Add points and use same color palette as in VBGE and temp plot
# Order for plotting colors (but not facet order) (see vbge fitting script!)
order <- read_csv(paste0(home, "/output/ranked_temps.csv"))

# Read for sample size per area
vbg <- read_csv(paste0(home, "/output/vbg.csv"))

df <- data.frame(area = c("BS", "BT", "FB", "FM", "HO", "JM", "MU", "RA",
                          "SI_EK", "SI_HA"),
                 area_name = c("Brunskär", "Biotest*", "Finbo", "Forsmark",
                               "Holmön", "Kvädofjärden", "Muskö", "Rånea",
                               "Simpevarp Ek", "Simpevarp Ha*"),
                 lon = c(21.5, 18.1, 19.5, 18, 20.9, 16.8, 18.1, 22.3, 16.6, 16.7),
                 lat = c(60, 60.4, 60.3, 60.5, 63.7, 58, 59, 65.9, 57.3, 57.4))

df <- add_utm_columns(df, ll_names = c("lon", "lat"), units = "m")

# Join in the full area names from df
order <- left_join(order, df |> select(area, area_name))

nareas <- length(unique(order$area)) + 2 # to skip the brightest colors that are hard to read
colors <- colorRampPalette(brewer.pal(name = "RdYlBu", n = 10))(nareas)[-c(6,7)]

# Set plot ranges (crop map)
xmin <- 0
xmax <- 700000
xrange <- xmax - xmin
ymin <- 6000000
ymax <- 7500000
yrange <- ymax - ymin

p1 <-
  ggplot(swe_coast_proj) +
  geom_sf(color = "gray80") +
  labs(x = "Longitude", y = "Latitude") +
  xlim(xmin, xmax) +
  ylim(ymin, ymax) +
  annotate("text", label = "Sweden", x = xmin + 0.23*xrange, y = ymin + 0.6*yrange,
           color = "gray50", size = 4) +
  geom_point(data = df, aes(X, Y, fill = factor(area_name, order$area_name)), size = 3, inherit.aes = FALSE,
             shape = 21, color = "white") +
  guides(color = "none", fill = "none") +
  geom_label_repel(data = df, 
                   aes(X, Y, label = factor(area_name, order$area_name), color = factor(area_name, order$area_name)),
                   size = 2.8, min.segment.length = 0, seed = 1, box.padding = 0.55) +
  scale_color_manual(values = colors, name = "Area") +
  scale_fill_manual(values = colors, name = "Area") +
  NULL

p1

vbg <- left_join(vbg, order, by = "area")

vbg <- vbg |> mutate(area_full = paste(area_name, paste0("(", area, ")")))
order <- order |> mutate(area_full = paste(area_name, paste0("(", area, ")")))
df <- df |> mutate(area_full = paste(area_name, paste0("(", area, ")")))

order_facet <- df |> arrange(desc(lat))

p2 <- ggplot(vbg, aes(cohort, k_median, size = n, color = factor(area_full, levels = order$area_full),
                      fill = factor(area, levels = order$area))) + 
  geom_point(shape = 21) +
  theme_sleek() + 
  guides(fill = "none", color = "none", 
         size = guide_legend(override.aes = list(linetype = NA))) +
  labs(x = "Cohort", y = "Median von Bertalanffy growth coefficient (*k*)", size = "#individuals") +
  scale_size(range = c(0.01, 2.5)) +
  facet_wrap(~factor(area_full, levels = order_facet$area_full), ncol = 2) + 
  scale_color_manual(values = alpha(colors, alpha = 1), name = "Area") +
  scale_fill_manual(values = alpha(colors, alpha = 0.6), name = "Area") +
  theme(legend.position = c(0.11, 0.96),
        legend.key.height = unit(0.01, 'cm'), 
        legend.text = element_text(size = 6),
        legend.title = element_text(size = 7),
        strip.text = element_text(size = 8),
        axis.title.y = ggtext::element_markdown())

p2

p1 + p2
ggsave(paste0(home, "/figures/map_sample_size.pdf"), width = 17, height = 17, units = "cm")

# p1 + (p2 & theme(strip.text = element_text(size = 7)))
# ggsave(paste0(home, "/figures/for-talks/map_sample_size.pdf"), width = 15, height = 15, units = "cm")
