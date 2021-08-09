#Plugin to rotate Markers in leaflet

rotatedMarker <- htmltools::htmlDependency(
  "Leaflet.rotatedMarker",
  "0.1.2",
  src = normalizePath("./inst/app/www/"),
  script = "leaflet.rotatedMarker.js"
)

registerPlugin <- function(map, plugin) {
  map$dependencies <- c(map$dependencies, list(plugin))
  map
}

