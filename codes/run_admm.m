function run_admm(tau, lambda, save_fn)
    tau = 10^(-str2num(tau));
    lambda = 10^(-str2num(lambda));
    fprintf('Run for tau=%2.2f, lambda=%2.2f\n', tau, lambda);
    
    prediction_error1 = admm_pre_error([6], tau, lambda)
    prediction_error2 = admm_pre_error([9], tau, lambda)
    prediction_error3 = admm_pre_error([6,9], tau, lambda)
    prediction_error4 = admm_pre_error(1:19, tau, lambda)

    save(save_fn);
