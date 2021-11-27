## R Shiny app

Objective: 
This purpose of this task is for the applicant to develop an interactive shiny app to present the results of clustering a dataset by using the method K-means.

Input: 
The user should be able to interactively select the number of clusters K.

Data:
Use the dataset iris from the dataset library. This data has these columns: Sepal.Length,   Sepal.Width,    Petal.Length ,   Petal.Width and Species.


Process:
Cluster the samples by the attributes Sepal.Length,   Sepal.Width,    Petal.Length ,   Petal.Width using K-means for the number of clusters K provided by the user.
 
Output: 
The applet should provide this information.
1)	A graphical representation of the clusters, in which each sample is colored by its Species. As the dataset has many columns, we suggest using any technique to reduce the dimension of the data. For example, you can use principal component analysis, but any other choice is valid too.
2)	Provide additional information of the samples included in each cluster. A good option could be a table with number of samples, number of samples for each species, attributes average. Any other representation is also valid.



Please provide the documented R code and instructions how to deploy it.

1.	The app has information of clusters anywhere between 1 and 9 clusters. 
2.	For dimensionality reduction, I used principal component analysis (two principal axes of PCA with k-means clusters). 
3.	The user can choose to click on the side bar to get the number of clusters on the right and the table also gives information accordingly. 
4.	The table has information on Clusters, samples, and their attributes. 

References:

https://github.com/hadley/mastering-shiny

https://shiny.rstudio.com/gallery/kmeans-example.html





```R

```
