
server <- function(input, output, session) {
    
    output$ship_types <- renderUI(
        dropdown_ship_type
    )
    
    output$ship <- renderUI({
        validate(
            need(input$selected_type != "", "Please select a type of ship") 
        )
        dropdown_selected_ship(ships_of_type(input$selected_type))
    })
    
    output$ship_select <- renderUI({
        card(
            style = "margin-top: 2px; border-radius: 0; width: 100%; height: auto; background: #efefef",
            div(class = "content",
                div(class = "header", style = "margin-bottom: 10px", "Select Ship Type:"),
                div(class = "description", uiOutput("ship_types")),
                div(class = "header", style = "margin-bottom: 10px; margin-top: 10px", "Select Ship:"),
                div(class = "description", uiOutput("ship")),
            )
        )
    })
    
    longest_distance <- reactive({
        validate(
            need(input$selected_ship != "", "Please select a ship") 
        )
        longestSailedDistance(input$selected_ship)
    })

    output$map <- renderLeaflet(inicial_map)
    
    observeEvent(longest_distance(),{
        
        changes_map("map",longest_distance())
           
    })
    
    output$ship_stats <- renderUI({
        grid(
            grid_template = grid_template(default = list(
                areas = rbind(
                    c("ship", "dimensions","destination", "sailed")
                ),
                cols_width = c("20%", "30%", "20%", "30%"),
                rows_height = c("120px")
            ),
            mobile = list(
                areas = rbind(
                    "ship",
                    "dimensions",
                    "destination",
                    "sailed"
                ),
                cols_width = c("100%"),
                rows_height = c("90px","90px","90px","90px")
            )),
            area_styles = list(destination = "padding-left: 5%",
                               sailed = "padding-left: 5%",
                               ship = "padding-left: 5%",
                               dimensions = "padding-left: 5%"),
            ship = card(
                style = "width: 90%",
                div(class = "ui raised segment",style ="background: #e4d1e5",
                    div(class = "header",
                        strong(icon(class = "ship large"),longest_distance()[1,]$SHIPNAME,
                               p(longest_distance()[1,]$ship_type," Ship",style = "text-align:right")))
                )
            ),
            destination = card(
                style = "width: 90%;",
                div(class = "ui raised segment",style ="background: #e4d1e5",
                    div(class = "header", 
                        strong(icon(class = "anchor large"),longest_distance()[1,]$DESTINATION,
                        p(if_else((longest_distance()[1,]$is_parked),"Docked","Destination"),style = "text-align:right")))
                    )
                ),
            sailed = card(
                style = "width: 90%;",
                div(class = "ui raised segment",style ="background: #e4d1e5",
                    div(class = "header", 
                        strong(icon(class = "angle double right large"),"Sailed Distance: ",round(longest_distance()[1,]$Distance,2),"m",
                        p(icon(class = "calendar alternate outline large"),longest_distance()[1,]$date, style = "text-align:right")))
                )
            ),
            dimensions = card(
                style = "width: 90%;",
                div(class = "ui raised segment",style ="background: #e4d1e5",
                    div(class = "header", 
                        strong(icon(class = "ruler large"),"Length",longest_distance()[1,]$LENGTH,"m","x Width",longest_distance()[1,]$WIDTH,"m",
                        p(icon(class = "weight large"),"Deadweigth: ",longest_distance()[1,]$DWT,"tn",style = "text-align:right")))
                )
            )
        )
    })
}
