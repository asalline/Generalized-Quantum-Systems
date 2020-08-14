function optimized_rho = optimized_rho_gen(x, GGB_new, num_of_states, qudits)
    optimized_rho1 = GGB_new{1};
    optimized_rho2 = 0;
    for k = 1:numel(x)-1
        optimized_rho2 = optimized_rho2 + (x(k+1) * GGB_new{k+1});
    end
    optimized_rho2;
    optimized_rho2 = (num_of_states / 2^qudits) * optimized_rho2;
    optimized_rho = (1 / num_of_states^qudits) * (optimized_rho1 + optimized_rho2);
end