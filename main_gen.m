num_of_states = 3;
qudits = 1;
ranknum = 1;
real = 0;

original_rho = quantumstates(num_of_states, qudits, ranknum, real)
GGB = GellMann(num_of_states)
measurements = measurements_gen(original_rho, GGB, num_of_states)
x = measurements;
optimized_rho = optimized_rho_gen(x, GGB, num_of_states, qudits)
original_rho