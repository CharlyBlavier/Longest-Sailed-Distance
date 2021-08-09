library(dplyr)
library(leaflet)

#Icons for leaflet

shipStartIcon <- makeIcon( iconUrl = "ship_start.png", 
                           iconWidth = 75,
                           iconHeight = 75 )

shipEndIcon <- makeIcon( iconUrl = "ship_end.png", 
                         iconWidth = 75, 
                         iconHeight = 75 )

#popups for leaflet

popups_time_and_speed <- function(row_longest_distance) {
   paste("Datetime: ",row_longest_distance$DATETIME,"\n ",
         "Speed: ",row_longest_distance$SPEED,"knots",
         if(row_longest_distance$is_parked)"(Docked)")
   
}

#Inicial map

inicial_map<-leaflet() %>%
              addTiles() %>% 
              registerPlugin( plugin = rotatedMarker ) %>%
              setView(lng = 21.0122, lat = 52.2297, zoom = 12)


#Changes to the map during exec

changes_map <- function(mapID,longest_distance){
  zoom_distance_traveled<- zoom_flyto(longest_distance[[1,"LAT"]],
                                      longest_distance[[2,"LAT"]],
                                      longest_distance[[1,"LON"]],
                                      longest_distance[[2,"LON"]])

  leafletProxy(mapId= mapID,data = longest_distance) %>%
    removeMarker(layerId = "ship") %>%
    removeMarker(layerId = "ship2") %>%
    removeMarker(layerId = "line") %>%
    addPolylines(~LON, ~LAT,
                 layerId = "line",
                 color = "#03F",
                 dashArray = "40 15 20 15") %>%
    addMarkers(~LON[1] ,~LAT[1],
               layerId = "ship",
               popup = popups_time_and_speed(longest_distance[1,]),
               icon = shipEndIcon,
               options = markerOptions( rotationAngle = (~HEADING+90 ))) %>%
    addMarkers(~LON[2] ,~LAT[2],
               layerId = "ship2",
               popup = popups_time_and_speed(longest_distance[2,]),
               icon = shipStartIcon,
               options = markerOptions( rotationAngle = (~HEADING+90))) %>%
    flyTo(lng = zoom_distance_traveled[[3]],
          lat = zoom_distance_traveled[[2]],
          zoom = zoom_distance_traveled[[1]]
    )
}