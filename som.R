# SOM with R

# load the data
high_dimensional <- read.table('dim032.txt')

# take the first six columns
high_dimensional <- high_dimensional[,1:6]

#scale the data
high_dimensional_scaled <- scale(high_dimensional)

#convert to matrix
input_hd <- as.matrix(high_dimensional_scaled)

# initialize the SOM with x and y dimensions
som.grid <- somgrid(xdim=20, ydim=20, topo = 'hexagonal')

# scale the function to normalize the data and then train using 1000 iterations
som.model <- som(input_hd, grid = som.grid, rlen = 1000)

# visualizes the SOM
# plot the first dimension
plot(som.model, type = "property", 
     property  = getCodes(som.model, 1)[,1], main = 'V1 Values')

# plot the weights for the second dimension
plot(som.model, type = "property", property = getCodes(som.model, 1)[,2], main = 'V2 Values')

# plot to show the weights for the third dimension
plot(som.model, type = "property", property = getCodes(som.model, 1)[,3], main = 'V3 Values')

# clustering
plot(som.model, type = 'codes')

# cluster based on distance between neighbors
plot(som.model, type = 'dist.neighbours')

# visualize the node vectors for the clusters
plot(som.model, type = 'codes')
som.hc <- cutree(hclust(dist(getCodes(som.model, 1))), 16)
add.cluster.boundaries(som.model, som.hc)

# overlay the cluster boundaries using neighbr distances
plot.new() #clear our previous plot
plot(som.model, type = 'dist.neighbours')
som.hc <- cutree(hclust(dist(getCodes(som.model, 1))), 16)
add.cluster.boundaries(som.model, som.hc)

# link the grid back to our data
som.prediction <- predict(som.model, input_hd)
# each input can be mapped into one of the 400 units in the SOM grid
head(som.prediction$unit.classif, 20)

# plot the original data in 2d by mapping them to their coordinate grid
# get the coordinate of each unit or grid in the SOM
head(som.grid$pts, 30)





