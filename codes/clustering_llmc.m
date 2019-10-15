function segmentation = clustering_llmc(data, knn, n, true_segmentation, fn)

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
        
        length_N = length(nnsIdx);
        
        % compute G_j: K x K
        Gj = (X(nnsIdx,:) - repmat(X(row,:),length_N, 1)) * (X(nnsIdx,:) - repmat(X(row,:), length_N, 1))';
        
        % compute c_j for point j: K x 1
        cj = pinv(Gj) * ones(length_N,1) / (ones(1,length_N) * pinv(Gj) * ones(length_N,1));
        
        if sum(isnan(cj)) > 0
            fprintf('There are NA in cj\n');
            break
        end
        
        % compute the coefficient matrix: 
        C(nnsIdx,row) = cj;
end
    
    
fprintf('l2 norm for the data matrix is %2.3f\n', norm(data - data*C,2));
    
    
    
%%% Compute an affinity matrix W
W = abs(C) + abs(C');
    
    
%%% Cluster the data into n groups by normalized spectral clustering (Algorithm 4.7)
    
D = diag(W * ones(size(W,1),1));
L = W-D;

[U,V]=eig(diag(power(diag(D),-0.5))*L*diag(power(diag(D),-0.5)));
V=diag(V);
[a,b]=sort(V);
U_norm = sqrt(sum(U.^2, 1)); %#ok<*NODEF>
U = bsxfun(@rdivide, U, U_norm);
U=U(:,b(1:n));
Y=U';



h=figure;
scatter(Y(1,find(true_segmentation(:,1)==1)),Y(2,find(true_segmentation(:,1)==1)),'g', 'filled');
hold on;
scatter(Y(1,find(true_segmentation(:,2)==1)),Y(2,find(true_segmentation(:,2)==1)),'r', 'filled');
legend('Genre1','Genre2') ;

set(h,'color','w');
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(h, '-dpng', fn);

    
segmentation = kmeans(Y', n);
    
    
    
    
    
    
    
    
 