function [ segmentation ] = SSC_noise_clustering( X, n ,true_segmentation,fn)
    C = SSC_noise(X, .01, 0.01);
    [N,N] = size(C);
    W = abs(C) + abs(C.');
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

end

