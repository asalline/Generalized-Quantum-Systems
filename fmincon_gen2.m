% This function optimizes the density matrix from the measurements it is
% given.
% Function used is called "fmincon" and it requires Optimization Toolbox.

function [x, fval, optimized_rhos] = fmincon_gen2(GGB_new, measurements, ...
    selection, num_of_states, qudits, traces)
    optimized_rhos = {};
    % The function that is being optimized is in the different MATLAB file.
    % Below there is some parameters that are needed to define so that the
    % optimization function can work.

    x0 = zeros(1,((num_of_states)^2)^qudits);
    A = []; b = []; Aeq = []; beq = []; lb = []; ub = [];

    % The main parameter here is the one that hold the constraints. In this
    % case the constraints are the measurements that are done before in another
    % MATLAB file. That paratemer is being called inside the fmincon, because
    % it is it's own MATLAB file.
    
    % Defining options to this particular optimization function.
    
    options = optimset('OutputFcn', @outputfun, 'MaxFunEvals', 100000, ...
        'Display', 'off');
    
    [x, fval, ~, ~] = ...
        fmincon(@(x) opt_function2(x, GGB_new, num_of_states, qudits, traces), ...
                x0, A, b, Aeq, beq, lb, ub, ...
                @(x) nlcon_gen(x, measurements, selection, qudits, ...
                num_of_states), options);
            
%     Making the output function local.
    function stop = outputfun(x, ~, state)
        stop = false;
        if isequal(state,'iter')
            optimized_rhos = [optimized_rhos, ... 
                optimized_rho_gen2(x, GGB_new, num_of_states, qudits, traces)];
        end
    end
end