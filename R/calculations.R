library(dplyr)

#Calculations

#longest sailed distance for selected shipID

longestSailedDistance <- function(shipID){
  shipMovements %>% 
    filter(SHIP_ID == shipID) %>% 
    arrange(DATETIME) %>%
    distinct() %>%
    mutate (Distance = geosphere::distHaversine( cbind(LON, LAT),
                                      cbind(lag(LON),lag(LAT)))) %>%
    arrange(desc(DATETIME)) %>%
    slice(which.max(Distance):(which.max(Distance)+1))
}
#Geometrical calculations to determine a "good" zoom level for leaflet

zoom_level <- function(lat1,lat2,lon1,lon2) {

  lat_difference <- abs(lat1-lat2)
  lon_difference <- abs(lon1-lon2)
  
  height_zoom_rectangle <- ((lat_difference+lon_difference/2)+abs(lat_difference-lon_difference/2))/2
  
  diagonal_zoom_rectangle <- sqrt(height_zoom_rectangle^2+(2*height_zoom_rectangle)^2)
  
  zoom_level <- ceiling(-(log10(2*diagonal_zoom_rectangle/805)/log10(2)))
  
  zoom_level <- if_else(zoom_level <= 18 ,zoom_level,18)
  
  zoom_level
}

#Geometrical calculations to determine the center of 2 coordinates

zoom_lat <- function(lat1,lat2) (lat1+lat2)/2

zoom_lon <- function(lon1,lon2) (lon1+lon2)/2

zoom_flyto <- function(lat1,lat2,lon1,lon2) {
  
  return(list(zoom_level(lat1,lat2,lon1,lon2),zoom_lat(lat1,lat2),zoom_lon(lon1,lon2)))
  
}