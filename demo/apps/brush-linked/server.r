library(ggvis)

data(diamonds, package = "ggplot2")
diamonds <- diamonds[sample(1:nrow(diamonds), 1000), ]

shinyServer(function(input, output, session) {

  lb <- linked_brush(keys = 1:nrow(diamonds))

  gv1 <- reactive({
    ggvis(diamonds, props(x = ~carat, y = ~price)) +
      layer_point(props(fill := lb$fill_prop(), fillOpacity := 0.8,
        fill.brush := "red")) +
      lb$brush_handler() +
      opts(width = 300, height = 300)
  })

  gv2 <- reactive({
    ggvis(diamonds, props(x = ~table, y = ~depth)) +
      layer_point(props(fill := lb$fill_prop(), fillOpacity := 0.8)) +
      opts(width = 300, height = 300)
  })

  # Set up observers for the spec and the data
  observe_ggvis(gv1, "plot1", session)
  observe_ggvis(gv2, "plot2", session)

})
