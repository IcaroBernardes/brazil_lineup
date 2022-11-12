################################################################################
# 0. Libraries loading
library(geobr)
library(dplyr)
library(ggplot2)
library(glue)
library(magick)
library(purrr)
library(rmapshaper)
library(rnaturalearth)
library(stringr)

################################################################################
# 1. Teams crests resizing
## Gets the path to the images
teams_img <- list.files("www/teams", full.names = TRUE)

## Creates a white background on the images,
## scales them to a max of 100px on their biggest dimension,
## resizes them to have 130px on both dimensions and saves them
teams_img %>% 
  purrr::walk(function (img) {
    
    magick::image_read(img) %>% 
      magick::image_background(color = "white") %>% 
      magick::image_scale(geometry = "100x100") %>% 
      magick::image_extent(color = "white", geometry = "130x130") %>% 
      magick::image_write(img)
    
  })

################################################################################
# 2. Regions shapes production
## Loads shapes of a couple of countries and keeps only names and coordinates
countries <- rnaturalearth::ne_countries(
  scale = "large",
  country = c("United Kingdom","Spain","Italy",
              "Germany","France","Portugal",
              "Ukraine","China","Turkey",
              "Japan","Uruguay","Greece",
              "United States of America","Mexico","Netherlands"), 
  returnclass = "sf"
) %>% 
  dplyr::select(name, geometry)

## Loads shapes of a couple of Brazilian states and keeps only names and coordinates
states <- geobr::read_state() %>% 
  dplyr::filter(abbrev_state %in% c("SP","RJ","MG","RS","PR")) %>% 
  dplyr::select(name = name_state, geometry = geom)

## Unites all shapes in one sf object
lands <- dplyr::bind_rows(countries, states) %>% 
  dplyr::arrange(name)

## Replaces white spaces with underlines and lowers the case of names
lands <- lands %>% 
  dplyr::mutate(name = tolower(name),
                name = stringr::str_replace_all(name, "[:space:]", "_"))

## Simplifies the shapes in a way that small islands disappear
lands <- rmapshaper::ms_simplify(lands, keep = 0.05)

## Add coordinates to limit the canvas so only the mainland
## of each region composes the shapes
lands <- lands %>% 
  dplyr::mutate(xlim_1 = c(75,-5,5,20,7,
                           128,-118,-51,3,-55,
                           -9.5,-45,-58,-53,-10,
                           25.2,22,-8.5,-125,-59),
                xlim_2 = c(135,10,15,28.5,19,
                           147,-85,-40,7.5,-48,
                           -6.0,-41,-49.5,-44,5,
                           45,41,2,-68,-53),
                ylim_1 = c(17,41.5,47,34.5,36,
                           30,15,-23,50,-27,
                           37,-23.5,-34,-26,35.9,
                           35.5,45,50,25,-35),
                ylim_2 = c(55,51,55,42,48,
                           46,35,-14,54,-22,
                           42.2,-20.5,-27,-19,44,
                           42,53,59,50,-30))

## Places the shapes in ggplots and saves them as images
lands %>% 
  purrr::pwalk(function(name, geometry, xlim_1, xlim_2, ylim_1, ylim_2) {
    
    p = geometry %>% 
      ggplot() +
      geom_sf(fill = "#195f0c", color = NA) +
      coord_sf(xlim = c(xlim_1, xlim_2),
               ylim = c(ylim_1, ylim_2)) +
      theme_void()
    
    ggsave(glue::glue("www/shapes/{name}.png"), plot = p,
           width = 500, height = 500, units = "px")
    
  })
