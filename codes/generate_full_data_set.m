function [ mat ] = generate_full_data_set( ratings_file )
    raw = load(ratings_file);
    [rows, cols] = size(raw);
    d = max(raw(:,1)); %number of users
    N = max(raw(:,2)); %number of movies
    mat = zeros(d,N);
    for index = 1:rows
        row_num = raw(index,1);
        col_num = raw(index,2);
        mat(row_num, col_num) = raw(index,3);
    end
    
    
end

