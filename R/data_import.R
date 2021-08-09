library(dplyr)

#Import the ship_movements. and make some smaller dataframes 

shipMovements <- readRDS("./data/ship_movements.RDS")

ship_types <- shipMovements %>% distinct(ship_type,SHIPTYPE)

ships <- shipMovements %>% distinct (SHIPNAME, SHIP_ID, SHIPTYPE)
