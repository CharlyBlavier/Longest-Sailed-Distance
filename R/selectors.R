library(dplyr)

#Dropdown for the ship type

dropdown_ship_type <- shiny.semantic::dropdown_input("selected_type",
                  choices = ship_types$ship_type,
                  choices_value = ship_types$SHIPTYPE,
                  value = 7)

#Return ships of the same type

ships_of_type <- function(selected_type) {
  
  ships %>% 
  filter(SHIPTYPE == selected_type) %>%
  distinct(SHIPNAME, SHIP_ID) %>% 
  arrange(SHIPNAME, SHIP_ID)
  
}

#Dropdown for the ships

dropdown_selected_ship <- function(ships_of_type){
  shiny.semantic::dropdown_input("selected_ship",
               choices = paste0(ships_of_type$SHIPNAME," (ID:",ships_of_type$SHIP_ID,")"),
               choices_value = ships_of_type$SHIP_ID
              )
}
