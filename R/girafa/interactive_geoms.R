# Loads libraries
library(ggpath)
library(shadowtext)
library(import)
library(ggplot2)

# Imports grid::is.grob
import::here(grid, is.grob)

# Imports some support functions
source("R/girafa/ipar.R")
source("R/girafa/layer_interactive.R")
source("R/girafa/utils_ggplot2.R")
source("R/girafa/utils.R")

# Creates interactive images
geom_from_path_interactive <- function(...)
{layer_interactive(ggpath::geom_from_path, ...)}

GeomInteractiveFromPath <- ggplot2::ggproto(
  "GeomInteractiveFromPath",
  GeomFromPath,
  default_aes = add_default_interactive_aes(GeomFromPath),
  parameters = interactive_geom_parameters,
  draw_key = interactive_geom_draw_key,
  draw_panel = function(data, panel_params, coord, ..., .ipar = IPAR_NAMES) {
    zz <- GeomFromPath$draw_panel(data, panel_params, coord, ...)
    coords <- coord$transform(data, panel_params)
    add_interactive_attrs(zz, coords, ipar = .ipar)
  }
)

# Creates interactive text with border
geom_shadowtext_interactive <- function(...)
{layer_interactive(shadowtext::geom_shadowtext, ...)}

GeomInteractiveShadowText <- ggplot2::ggproto(
  "GeomInteractiveShadowText",
  GeomShadowText,
  default_aes = add_default_interactive_aes(GeomShadowText),
  parameters = interactive_geom_parameters,
  draw_key = interactive_geom_draw_key,
  draw_panel = function(data, panel_params, coord, ..., .ipar = IPAR_NAMES) {
    zz <- GeomShadowText$draw_panel(data, panel_params, coord, ...)
    coords <- coord$transform(data, panel_params)
    add_interactive_attrs(zz, coords, ipar = .ipar)
  }
)
