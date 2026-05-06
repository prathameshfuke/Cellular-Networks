%% Experiment 3: BER performance over a Rayleigh fading wireless channel with BPSK
% Aim: Simulate BER performance over a Rayleigh fading wireless channel with BPSK transmission for SNR: 0 to 50 dB.
% Author: Prathamesh Fuke (TE258)
% Date: May 2026

clear; close all; clc;

%% 1. Parameters
SNR_dB = 0:2:50;
SNR_lin = 10.^(SNR_dB / 10);
N_bits = 1e6;

%% 2. Theoretical Formulas
% Standard Rayleigh BPSK: Pb = 0.5 * (1 - sqrt(SNR/(1+SNR)))
BER_theo_standard = 0.5 * (1 - sqrt(SNR_lin ./ (1 + SNR_lin)));

% Formula provided in Lab Manual text: 0.5 * (1 - (SNR/(2+SNR))^0.5)
BER_lab_manual = 0.5 * (1 - (SNR_lin ./ (2 + SNR_lin)).^0.5);

%% 3. Simulation
BER_sim = zeros(1, length(SNR_dB));
fprintf('Simulating BPSK over Rayleigh Fading...\n');

for i = 1:length(SNR_dB)
    data = randi([0 1], 1, N_bits);
    tx = 2*data - 1;
    
    % Rayleigh Channel Coefficient (complex Gaussian)
    h = (randn(1, N_bits) + 1i*randn(1, N_bits)) / sqrt(2);
    
    % AWGN Noise
    n = (randn(1, N_bits) + 1i*randn(1, N_bits)) * sqrt(1 / (2 * SNR_lin(i)));
    
    % Received Signal
    rx = h .* tx + n;
    
    % Equalization (Zero Forcing / Phase Compensation)
    rx_eq = rx ./ h;
    
    decoded = real(rx_eq) > 0;
    BER_sim(i) = sum(data ~= decoded) / N_bits;
end

%% 4. Plotting
figure('Name', 'Exp 3: Rayleigh Fading', 'NumberTitle', 'off', 'Color', 'w');

% Plot Theoreticals
semilogy(SNR_dB, BER_theo_standard, 'Color', [0, 0.45, 0.74], 'LineWidth', 2, 'LineStyle', '-'); hold on;
semilogy(SNR_dB, BER_lab_manual, 'Color', [0.47, 0.67, 0.19], 'LineWidth', 2, 'LineStyle', '--');

% Plot Simulated
semilogy(SNR_dB, BER_sim, 's', 'MarkerSize', 6, ...
    'MarkerEdgeColor', [0.85, 0.33, 0.1], ...
    'MarkerFaceColor', 'none', 'LineWidth', 1.2);

grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.2);
xlabel('SNR (dB)', 'FontWeight', 'bold'); 
ylabel('Bit Error Rate (BER)', 'FontWeight', 'bold');
title('BPSK BER over Rayleigh Fading Channel', 'FontSize', 14);
legend('Standard Theoretical', 'Lab Manual Formula', 'Simulated Rayleigh', 'Location', 'southwest');
axis([0 50 1e-6 1]);
sgtitle('Cellular Networks Lab - Exp 3', 'FontSize', 16, 'FontWeight', 'bold');
