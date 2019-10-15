function run(data_cols, fn)

% run matrix completion
full_data = generate_full_data_set('data/ratings.txt');

[ movie_genre, column_indices ] = get_array_of_column_indices('data/u.item',data_cols);
small_matrix = subset_columns(full_data, column_indices);
   

W = small_matrix~=0;
% [completed, E] = admm(small_matrix, W, 1, 1);
[U,V,d] = matrix_factor(small_matrix,'als',5,5);
completed = U'*V;


% generate true movie genras
[ movie_genre, column_indices ] = get_array_of_column_indices('data/u.item', data_cols );
true_segmentation = movie_genre(column_indices,:);
% true_segmentation = true_segmentation(:,data_cols);
sum(true_segmentation)



% run clustering
knn = 100;
save_fn = sprintf('llmc_%s.png', fn);
predicted_segmentation = clustering_llmc(completed, knn, length(data_cols),true_segmentation, save_fn);
[overlap, contigency_table] = clustering_error(predicted_segmentation, true_segmentation);

save_fn = sprintf('ssc_%s.png', fn);
predicted_segmentation2 = SSC_noise_clustering( completed, length(data_cols),true_segmentation, save_fn);
[overlap, contigency_table2] = clustering_error(predicted_segmentation2, true_segmentation);


save_fn = sprintf('spectral_%s.png', fn);
predicted_segmentation3 = clustering_spectral(completed,length(data_cols),10,true_segmentation, save_fn);
[overlap, contigency_table3] = clustering_error(predicted_segmentation3, true_segmentation);

save_fn = sprintf('%s.mat', fn);
save(save_fn, 'contigency_table', 'contigency_table2', 'contigency_table3');

