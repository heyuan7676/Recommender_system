function segmentation = clustering_llmc(data, knn, subspacen)

% Perform locally linear manifold clustering
% Algorithm 7.3 in the book
% 1) Find K-NN for every points
% 2) Compute the affine coefficients C
% 3) Compute the affinity matrix W
% 4) Apply normalized spectral clustering to W (Algorithm 4.7)
%    4.1) Compute the Laplacian map L
%    4.2) Compute the eigenvectors and normalize
%    4.3) Cluster the columns by K-means


% input: data (D x N)
% output: segmentation of the data points

N = size(data, 2);
    
    
%%% Compute the affine coefficients for data = dataC
    
C = zeros(N,N);
X = data';   % a row is an observation, for matlab function IdxKDT.
MdlKDT = KDTreeSearcher(X);
IdxKDT = knnsearch(MdlKDT,X,'K', knn+1);
    
for row = 1:size(X,1)
        % find the nearest neighbors
        nnsIdx = IdxKDT(row,:);
        nnsIdx = nnsIdx(nnsIdx~=row);
        
        % compute G_j: K x K
        Gj = (X(nnsIdx,:) - repmat(X(row,:), knn, 1)) * (X(nnsIdx,:)' - repmat(X(row,:), knn, 1)');
        
        % compute c_j for point j: K x 1
        cj = inv(Gj) * ones(knn,1) / (ones(1,knn) * inv(Gj) * ones(knn,1));
        
        % compute the coefficient matrix: 
        C(nnsIdx,row) = cj;
end
    
    
fprintf('l2 norm for the data matrix is %2.3f\n', norm(data - data*C,2));
    
    
    
%%% Compute an affinity matrix W
W = abs(C) + abs(C');
    
    
%%% Cluster the data into n groups by normalized spectral clustering (Algorithm 4.7)
    
D = diag(W * ones(size(W,1),1));
L = W-D;
L_normalized = L;
[U, S, V] = fastSVD(L_normalized);
Y = U(:,N-subspacen+1:N)';
    
segmentation = kmeans(Y', subspacen);
    
    
    
    
    
    
    
    
 