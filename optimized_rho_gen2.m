function optimized_rho = optimized_rho_gen2(x, GGB_new, num_of_states, qudits, traces)
    optimized_rho2 = 0;
    for k = 1:numel(x)-1
        optimized_rho2 = optimized_rho2 + (x(k) * traces(k+1) * GGB_new{k+1});
    end
    optimized_rho = (1/num_of_states^qudits)*GGB_new{1} + optimized_rho2;
end