%% Experiment 2: BER performance over wireline AWGN channel with BPSK
% Aim: Simulate BER performance over a wireline AWGN channel with BPSK transmission for SNR: 0 to 50 dB.
% Author: Prathamesh Fuke (TE258)
% Date: May 2026

clear; close all; clc;

%% 1. Parameters
SNR_dB = 0:2:50;
SNR_lin = 10.^(SNR_dB / 10);
N_bits = 1e6; % Number of bits for simulation

%% 2. Theoretical BER
BER_theo = 0.5 * erfc(sqrt(SNR_lin));

%% 3. Simulation
BER_sim = zeros(1, length(SNR_dB));
fprintf('Simulating BPSK over AWGN...\n');

for i = 1:length(SNR_dB)
    % Transmitter
    data = randi([0 1], 1, N_bits);
    tx = 2*data - 1; % BPSK Modulation
    
    % Channel (AWGN)
    noise_sigma = sqrt(1 / (2 * SNR_lin(i)));
    rx = tx + noise_sigma * randn(1, N_bits);
    
    % Receiver (Hard Decision)
    decoded = rx > 0;
    
    % BER Calculation
    BER_sim(i) = sum(data ~= decoded) / N_bits;
    
    if mod(SNR_dB(i), 10) == 0
        fprintf('SNR: %d dB | BER: %.4e\n', SNR_dB(i), BER_sim(i));
    end
end

%% 4. Plotting
figure('Name', 'Exp 2: BPSK over AWGN', 'NumberTitle', 'off', 'Color', 'w');

% Plot Theoretical
semilogy(SNR_dB, BER_theo, 'Color', [0.2, 0.2, 0.2], 'LineWidth', 2.5, 'LineStyle', '-'); hold on;

% Plot Simulated with nice markers
semilogy(SNR_dB, BER_sim, 'o', 'MarkerSize', 7, ...
    'MarkerEdgeColor', [0.85, 0.33, 0.1], ...
    'MarkerFaceColor', [1, 0.9, 0.8], ...
    'LineWidth', 1.5);

grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.2, 'GridAlpha', 0.4);
xlabel('SNR (dB)', 'FontWeight', 'bold'); 
ylabel('Bit Error Rate (BER)', 'FontWeight', 'bold');
title('BPSK BER Performance over AWGN Channel', 'FontSize', 14);
legend('Theoretical AWGN', 'Simulated BPSK', 'Location', 'southwest');
axis([0 50 1e-6 1]);
sgtitle('Cellular Networks Lab - Exp 2', 'FontSize', 16, 'FontWeight', 'bold');
