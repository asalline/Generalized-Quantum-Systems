clear all, clc
num_of_states = 4;
qudits = 2;
ranknum = 1;
real = 0;
possibilities = [1:1:(num_of_states^2)^qudits-1];
amount_of_randoms = 250;

for k = 1:amount_of_randoms
    selection_txt(k) = possibilities(randi([1,length(possibilities)]));
    possibilities(possibilities == selection_txt(k)) = [];
end
selection_txt = sort(selection_txt, 'ascend');
selection = selection_txt;

% selection = [2:1:10];
original_rho = quantumstates(num_of_states, qudits, ranknum, real);
GGB = GellMann(num_of_states);
[GGB_new, GGB_coefs] = GGB_qudits(GGB, qudits);
[measurements, traces] = measurements_gen2(original_rho, GGB_new, num_of_states, qudits);
[x, fval, optimized_rhos] = fmincon_gen2(GGB_new, measurements, selection, ...
                                         num_of_states, qudits, traces);
optimized_rho = optimized_rho_gen2(x, GGB_new, num_of_states, qudits, traces)
original_rho
fidelity = (trace(sqrtm(sqrtm(optimized_rho)*original_rho*sqrtm(optimized_rho))))^2;
infidelity = 1 - fidelity
% DIAGONAALI EI OPTIMOIDU KUNNOLLA!!!!!!