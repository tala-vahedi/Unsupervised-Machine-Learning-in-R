# K-means with R

# load data
s1 <- read.table('s1.txt')

# renaming the columns to make data processing more intuitive
colnames(s1) <- c('X', 'Y')

# getting the data in a plot
plot(s1)

# creating a ggplot object with the data
plot.s1 <- ggplot(s1, aes(x=X, y=Y))

# adding points in ggplot to create a scatter plot
plot.s1 + geom_point(alpha=.25) # and an alpha with semi-transparent points

# fit k means
k <- kmeans(s1, centers = 15) #there are 15 clusters in the data set

# using k-means:
    # we want to know where the clusters are centered
centers <- data.frame(k$centers) #converts the 2d list into a data frame
centers

    # we want to know the size or how many points are in each cluster
counts <- k$size #gets a list of cluster sizes
counts

# using aggregate function
    # find the center of each cluster by finding the mean of X/Y for all data pts
centers.agg <- aggregate(s1, by=list(k$cluster), FUN=mean) 
centers.agg

    # find the number of points or size of each cluster
counts.agg <- aggregate(s1, by=list(k$cluster), FUN=length)
counts.agg

# create a new column with cluster info
s1$cluster <- k$cluster

# look at four examples from the data frame
s1[c(100,1000,2000,3000),]

# create ggplot object, and add color by cluster
plot.s1 <- ggplot(s1, aes(x=X, y=Y, color=cluster))

#scatter plot points
plot.s1 + geom_point(alpha=.25) + 
  geom_point(data=centers,aes(x=X, y=Y), size = 3, color = 'black')+
  scale_color_gradientn(colours=rainbow(15)) + ggtitle("K-Means Clusters")