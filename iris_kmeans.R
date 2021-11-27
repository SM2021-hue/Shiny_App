
library(shiny)
library(ggplot2)
library(tidyr)
library(plyr)

ui <- fluidPage(
  headerPanel('K-means clustering of Iris dataset-PCA'),
  sidebarPanel(
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9)
  ),

  mainPanel(
    plotOutput('plot1')
  ),
  tableOutput('table')
)

server <- function(input, output) {
  data(iris)

  ## k-means clustering
  kmeans_iris <- reactive({
    kmeans(iris[-5], centers = input$clusters, nstart = 25)
  })
  ## PCA of samples (promp()): coordinates of point on 1-st ans 2-nd
  ## axes + clusters + species info.
  pca_iris <- reactive({data.frame(cluster = as.factor(kmeans_iris()$cluster),
                                   species = iris$Species, prcomp(iris[-5])$x[,1:2])})

  ## Coordinates of points on convex hulls around clusters
  chulls <- reactive({ddply(pca_iris(),
                            .(cluster),
                            function(data) data[chull(data$PC1, data$PC2), ])})

  output$plot1 <- renderPlot({
    ggplot(data = pca_iris(),
           aes(x = PC1, y = PC2)) +
      geom_point(aes(color = species, shape = species),
                 size = 3) +
      geom_polygon(data = chulls(),
                   aes(x = PC1, y = PC2, fill = cluster),
                   alpha = 0.3) +
      theme_light() +
      theme(legend.position = "bottom")
  })

  output$table <- renderTable({
    mydata <- data.frame(setosa = NA, versicolor = NA, virginica = NA)
    mydata2 <- data.frame("sepal.length" = NA, "sepal.width" = NA,  "petal.length" = NA, "petal.width" = NA)
    for (i in 1 : input$clusters) {
      ## frame with number of samples in each cluster
      mydata[i, ] <- iris[kmeans_iris()$cluster==i,]$Species %>% table %>% as.list %>% data.frame
      ## frame with mean values by clusters
      mydata2[i, ] <- iris[kmeans_iris()$cluster==i,-5] %>% dplyr::summarise_all(~ mean(.) )
    }

    ## resulting table with column of cluster number added
    tibble::rownames_to_column(data.frame("samples" = kmeans_iris()$size, mydata, mydata2),
                               var = "cluster")
  })
}

shinyApp(ui = ui, server = server)
