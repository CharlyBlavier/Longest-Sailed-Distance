
ui <- semanticPage(

    # Application title
    title=("Longest Sailed Distance"),
    
    grid(
        grid_template = grid_template(
            default = list(
                areas = rbind(
                    c("title", "info"),
                    c("selector", "map"),
                    c("legend", "map")
                ),
                cols_width = c("400px", "1fr"),
                rows_height = c("12%", "60%","28%")
            ),
            mobile = list(
                areas = rbind(
                    "title",
                    "selector",
                    "map",
                    "info",
                    "legend"
                ),
                rows_height = c("100px", "210px", "400px", "400px", "auto"),
                cols_width = c("100%")
            )
        ),
        container_style = " margin: 0;",
        area_styles = list(title = "margin: 20px;", info = "margin: 20px;", selector = "margin: 20px;",map ="margin: 20px;",legend = "margin:20px"),
        title = h2(class = "ui header", icon("ship huge"), div(class = "content", "Longest Sailed Distance",style = "text-align:center")),
        info = uiOutput("ship_stats"),
        selector = uiOutput("ship_select"),
        map = leafletOutput("map",height = "100%"),
        legend = card(
            style = "border-radius: 0; width: 100%; background: #efefef",
            div(class = "content",
                div(class = "header", style = "margin-bottom: 10px", "Map Leyend"),
                div(class = "description", "Inicial Position:",tags$img(src = "ship_start.png",class = "ui image tiny")),
                div(class = "description","End Position:",tags$img(src = "ship_end.png",class = "ui image tiny")),
            )
        )
    )
)
