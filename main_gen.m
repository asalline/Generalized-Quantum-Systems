clear all, clc
num_of_states = 2;
qudits = 2;
ranknum = 1;
real = 0;
selection = [1:1:14];
original_rho = quantumstates(num_of_states, qudits, ranknum, real);
GGB = GellMann(num_of_states);
GGB_new = GGB_qudits(GGB, qudits);
measurements = measurements_gen(original_rho, GGB_new, num_of_states, qudits)
% x = measurements;
[x, fval, optimized_rhos] = fmincon_gen(GGB_new, measurements, ...
    selection, num_of_states, qudits);
optimized_rho = optimized_rho_gen(x, GGB_new, num_of_states, qudits)
original_rho

% DIAGONAALI EI OPTIMOIDU KUNNOLLA!!!!!!