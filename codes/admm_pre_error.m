function prediction_error = admm_pre_error(data_cols, tau, lambda) 

full_data = generate_full_data_set('data/ratings.txt');
sparsity = [0.02,0.03,0.04];

[ movie_genre, column_indices ] = get_array_of_column_indices('data/u.item',data_cols);
small_matrix = subset_columns(full_data, column_indices);
    
    

for sd = 1:20
    
    for k = [1,2,3]
        sparse_small_matrix = induce_sparsity(small_matrix, sparsity(k), sd);
        W = sparse_small_matrix~=0;
        [L,E] = admm(sparse_small_matrix, W, tau, lambda);

        non_missing_predicted = L .* (small_matrix~=0);
        induced_missing_predicted = non_missing_predicted .* (sparse_small_matrix == 0);
        induced_missing_true = small_matrix .* (sparse_small_matrix==0);

        prediction_error(k, sd) = RMSE(induced_missing_predicted, induced_missing_true);
    end
    
end

