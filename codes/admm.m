function [L,E] = admm(data, W, tau, lambda)

% principle component persuit (PCP) convex program for incomplete matrix
% X has missing values determined by W (W=0 means the entry is missing)
% Find P(X) = P(L + E) where L is low-rank, and E is sparse in some way
% use the Alternating Direction Method of Multipliers (ADMM) to solve
% algorithm 3.8, 3.9

% X:   D x N data matrix.
% tau: Parameter of the augmented Lagrangian.
% W:   D x N binary matrix denoting known (1) or missing (0) entries


% Set the parameters

episoron = 100;
ite = 0;


% First fill in the zero entries for the data, 
% to avoid singularity

% rng(100);
data(data==0) = randi(5,sum(data(:)==0),1);


% Initialize

E = zeros(size(data));
Lambda = zeros(size(data));
[U, S, V] = fastSVD(data - E + Lambda/tau);
Ssigma = wthresh(S, 's', 1/tau);
L = U * Ssigma * V.';
        

% Update

while episoron > 0.01
    
    [U, S, V] = fastSVD(data - E + (Lambda/tau) .* W);
    Ssigma = wthresh(S, 's', 1/tau);
    Lnew = U * Ssigma * V.';
        
    Z = data - Lnew + (Lambda / tau) .* W;
    diagZ = sqrt(Z.' * Z) .* eye(size(Z,2));
    SsigmadiagZ = wthresh(diagZ, 's', lambda / tau);
    Enew = Z * SsigmadiagZ / diagZ;
    Enew(isinf(Enew)) = 0;
        
    Lambdanew = Lambda + tau * ((data - Lnew -Enew) .* W);
        
        
    % use absolute value to compute the convergence
    episoron = sum(sum(abs(Lambdanew - Lambda)));
    Lambda = Lambdanew;
    L = Lnew;
    E = Enew;

    ite = ite + 1;
end

fprintf('Converge after %d iterations\n', ite);



