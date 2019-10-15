function [U, S, V] = fastSVD(X)

% Use eigenvector decomposition to compute SVD
% X: D x N where D >> N
% Note: S2 != 0, X != 0


[V, S2, Vt] = svd(X.' * X); 
S = sqrt(S2);
U = X * V / S;
