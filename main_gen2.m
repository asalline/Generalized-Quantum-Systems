% Author: Antti Sällinen
% Last update: 27.8.2020

% There is seven variables. First four are related to the random density 
% matrix and the generalized Gell-Mann basis (GGB). The others are used
% to determine how and how many times the optimization happens again.
%   num_of_states: Determines how many states the qudits have. I.e. for
%                  qubits, num_of_states = 2. (Default: 2)
%   qudits:        Amount of qudits the random density matrix will have
%                  when constucted. (Default: 2)
%   ranknum:       Rank of the random density matrix. (Default: 1)
%   real:          Determines if the random density matrix has a real (1)
%                  or a complex (0) values. (Default: 0)
%   repeats:       Amount of times this script generates a new random
%                  density matrix and tries to optimize it. (Default: 1)
%   rounds:        Number of the different measurement sets generated.
%                  These sets are used to optimize the density matrix.
%   wanted_meas:   Amount of the measurements one wants to use when
%                  optimizing the density matrix. (Default: 15)


clear
clc
num_of_states = 2;
qudits = 2;
ranknum = 1;
real = 0;
repeats = 1;
rounds = 1;
wanted_meas = 15;

n = 1;
possible_measurements = [1:1:(num_of_states^2)^qudits-1];
measurement_ratio = wanted_meas / (num_of_states^2)^qudits

for k = 1:wanted_meas
    selection_txt(k) = ...
        possible_measurements(randi([1,length(possible_measurements)]));
    possible_measurements(possible_measurements == selection_txt(k)) = [];
end
selection_txt = sort(selection_txt, 'ascend');
selection = selection_txt;

infidelities = cell(1, repeats);

for round_num = 1:rounds
    possible_measurements = [1:1:(num_of_states^2)^qudits-1];
    
    for k = 1:wanted_meas
    selection_txt(k) = ...
        possible_measurements(randi([1,length(possible_measurements)]));
    possible_measurements(possible_measurements == selection_txt(k)) = [];
    end
    selection_txt = sort(selection_txt, 'ascend');
    selection = selection_txt;
    
%     infidelities = cell(1, repeats);
    
    for repeat_num = 1:repeats
        original_rho = quantumstates(num_of_states, qudits, ranknum, real);
        GGB = GellMann(num_of_states);
        [GGB_new, GGB_coefs] = GGB_qudits(GGB, qudits);
        [measurements, traces] = measurements_gen2(original_rho, GGB_new,...
            num_of_states, qudits);
        tic;
        [x, fval, optimized_rhos] = fmincon_gen2(GGB_new, measurements, ...
            selection, num_of_states, qudits, traces);
        optiTimes(n) = toc
        optimized_rho = optimized_rho_gen2(x, GGB_new, num_of_states, ...
            qudits, traces);
        infidelity = zeros(1, length(optimized_rhos));
        if length(optimized_rhos) <= 10000
            for k = 1:length(optimized_rhos)
                infidelity(k) = ...
                    1 - (trace(sqrtm(sqrtm(optimized_rhos{k}) * original_rho * ...
                    sqrtm(optimized_rhos{k}))))^2;
            end
        else
            fidelity = [];
        end
%         last_infidelities(repeat_num) = infidelity(end)
        infidelities_repeats{repeat_num} = infidelity;
        last_infidelities(n) = infidelity(end);
        n = n + 1;
        clear infidelity
    end
%     
%     sum_last_infidelities = 0;
%     for k = 1:repeats
%         sum_last_infidelities = ...
%             sum_last_infidelities + last_infidelities(k);
%     end
%     sum_last_infidelities;
%     mean_last_infidelities(round_num) = sum_last_infidelities / repeats;
%     infidelities{round_num} = {infidelities, infidelities_repeats};
%     mean_infidelity = 0;
%     for k = 1:rounds*repeats
%         mean_infidelity = mean_infidelity + last_infidelities(k);
%     end
%     last_infidelity
%     mean_infidelity = mean_infidelity / (rounds*repeats)
    
%     clear last_infidelities
end
mean_infidelity = 0;
for k = 1:rounds*repeats
    mean_infidelity = mean_infidelity + last_infidelities(k);
end
last_infidelities;
mean_infidelity = mean_infidelity / (rounds*repeats)
Maximum_time = max(optiTimes)
Minimum_time = min(optiTimes)
Mean_time = mean(optiTimes)