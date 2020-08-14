% This function contains all the possible nonlinear constraints that are
% being to help optimization.

function [c, ceq] = nlcon_gen(x, measurements, selection, ...
    num_of_states, qudits)

error = 0;
c = [];

for j = 1:elements
    ceq_all(j) = norm(x(j) - measurements(j+1));
end

ceq = ceq_all(selection);
end