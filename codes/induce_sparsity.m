function sparse_matrix = induce_sparsity( input_matrix, sparsity, seed )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    rng(seed);
    [d,N] = size(input_matrix);
    rando = rand(d,N);
    rando(rando < sparsity) = 0;
    rando(rando >= sparsity) = 1;
    sparse_matrix = input_matrix.*rando;
end

