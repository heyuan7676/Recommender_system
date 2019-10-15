function run(column_indices, sd)

% generate the movie genras
full_data = generate_full_data_set('data/ratings.txt');
movie_genras = zeros(1,size(full_data,2));

for group = 1:19
    col_ind = get_array_of_column_indices('data/u.item',[data_cols(k)]);
    movie_genras(col_ind) = group;
end


% generate the dataset 
small_matrix = subset_columns(full_data, column_indices);

% induce sparsity
sparse_small_matrix = induce_sparsity(small_matrix, sparsity(k), sd);

% run matrix completion
L = admm(sparse_small_matrix);

% measure the error


% run clustering
predicted_segmentation = llmc(L, knn, subspacen);

% evaluate the clustering error
true_segmentation = movie_genras(:,column_indices);
correctness = clustering_error(predicted_segmentation, true_segmentation);