function [ A ] = soft_thresholding_operator( X,tau )
[rowz,colz] = size(X);


A = sign(X).*max(abs(X-tau),zeros(rowz,colz));

end
