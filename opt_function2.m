function opt_function = opt_function2(x, GGB_new, num_of_states, qudits, traces)
    x = [1,x];
    opt_function2 = 0;
    for k = 1:numel(x)-2
        opt_function2 = opt_function2 + (x(k+1) * traces(k+1) * GGB_new{k+1});
    end
    opt_function = (1 / num_of_states^qudits)*GGB_new{1} + opt_function2;
    opt_function = trace(sqrtm(opt_function' * opt_function));
end