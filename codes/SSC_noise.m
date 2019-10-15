function [ C ] = SSC_noise( X,u2,tau )
    [D,N] = size(X);
    %Initialization
    C = zeros(N,N);
    convergence = 1;
    
    
    while convergence == 1
    old_C = C;
    delta = zeros(N,N);
    
    
    Z_term_a = tau*X.'*X + u2*eye(N);
    Z_term_b = tau*X.'*X + u2*(C - (delta/u2));
    Z = inv(Z_term_a)*Z_term_b;
    
    C = soft_thresholding_operator(Z + (delta/u2), 1/u2);
    C = C - diag(diag(C));
    
    delta = delta + u2*(Z - C);
    
    %convergence check
    diff_C = abs(C - old_C);
    diff = trace(diff_C.'*diff_C)
    if diff < 2e9
        convergence = 0;
    end
    
    end

end

