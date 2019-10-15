# Recommender_system

The problem is to predict a user’s rating for a movie based on the ratings the user previously gives to other movies, as well as ratings provided by other users. This is essentially a matrix completion problem.
<br>
The data is a matrix of users by movies, with each entry being a rating score from 1 to 5. The characteristic of the data is that since not every user rates every movie, actually most users would usually rate a small number of movies, which makes the matrix very sparse. 
<br>
We compared three method: 
> Matrix factorization. The objective function is the num of squared residuals in the scope of available data, and l2 penalty on the two decomposed matrices. 
> Robust PCA ( to deal with outliers and errors). With prior information we know that the true matrix should have a low rank, the augmented Lagrangian function was created. 
> Low rank matrix completion. The matrix is optimized to have small nuclear norm and constrained to have the same values as the observed matrix in scope of available data. 
<br>
We compared the performance using manually masked data from MovieLens, and RMSE was used to evaluate the performance. Matrix factorization performs the best. 


<br>

We also did clustering in the high-dimensional space using spectral clustering and locally linear manifold clustering, and found meaningful clusters of movies.

