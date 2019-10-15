function L = matrix_completion_admm(data_cols, tau, lambda) 

full_data = generate_full_data_set('data/ratings.txt');
column_indices = get_array_of_column_indices('data/u.item',data_cols);
data_matrix = subset_columns(full_data, column_indices);

W = data_matrix~=0;
[L,E] = admm(data_matrix, W, tau, lambda);
    
end

