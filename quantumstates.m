num_of_states = 3;
qudits = 2
ranknum = 2
%real-valued = 1, complex-valued = 0
real = 0;
states = cell(1, num_of_states);
% psi = zeros(1,num_of_states)';

if ranknum == 1
    for k = 1:num_of_states
        ket = zeros(1,num_of_states)';
        ket(k) = 1;
        states{k} = ket;
    end
    clear n
    for j = 1:qudits
        if real == 0
            coefs = (-1 + 2*rand(1,num_of_states)) + ...
                (1i * (-1 * 2*rand(1,num_of_states)));
        else
            coefs = -1 + 2*rand(1,num_of_states);
        end
        normalization = sqrt(sum(coefs.^2));
        coefs = coefs / normalization

        psi = zeros(1,num_of_states)';
        for k = 1:num_of_states
            psi = psi + states{k} * coefs(k);
        end
        psi_cell{j} = psi;
    end

    final_state = 1;
    for k = 1:qudits
        final_state = kron(final_state, psi_cell{k})
    end

    original_rho = final_state * final_state';
    trace_norm = trace(original_rho);
    original_rho = original_rho / trace_norm
else
    partial = -1 + 2*rand(num_of_states^qudits,ranknum) + ... 
        1i * (-1 + 2*rand(num_of_states^qudits,ranknum));
    partial = partial*partial';
    trace_norm = trace(partial);
    original_rho = partial / trace_norm
    rank(original_rho)
    trace(original_rho)
    eig(original_rho)
    original_rho==original_rho'
end