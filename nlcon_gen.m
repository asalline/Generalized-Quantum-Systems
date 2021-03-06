% This function contains all the possible nonlinear constraints that are
% being to help optimization.

function [c, ceq] = nlcon_gen(x, measurements, selection, qudits, ...
                    num_of_states)

elements = (num_of_states^2)^qudits-1;
error = 0;
c = [];
% ceq_all = zeros(1,elements+1);
measurements;
for j = 1:elements
    ceq_all(j) = norm(x(j) - measurements(j+1));
end
ceq_all;
ceq = ceq_all(selection);
end