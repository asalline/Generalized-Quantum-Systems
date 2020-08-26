function [measurements, traces] = measurements_gen2(original_rho, ...
                                 GGB_new, num_of_states, qudits)
    clear measurements traces
    coef = sqrt((num_of_states^qudits)/(2^qudits)*((num_of_states^qudits)-1));
    for k = 1:length(GGB_new)
        measurements(k) = trace(GGB_new{k} * original_rho);
        traces(k) = 1 / trace(GGB_new{k}*GGB_new{k});
    end
%     measurements = coef * measurements;
end
% sqrt(num_of_states/2*(num_of_states-1))