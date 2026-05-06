%% Experiment 7: BER performance of multi-antenna Rayleigh channel
% Aim: Simulate BER performance of multi-antenna Rayleigh channel for SNR varying from 0 to 60 dB.
% Author: Prathamesh Fuke (TE258)
% Date: May 2026

clear; close all; clc;

%% 1. Parameters
SNR_dB = 0:5:60;
SNR_lin = 10.^(SNR_dB / 10);
N_bits = 1e5;

BER_siso = zeros(1, length(SNR_dB));
BER_mrc_1x2 = zeros(1, length(SNR_dB));

fprintf('Simulating MIMO Diversity (MRC)...\n');

%% 2. Simulation
for i = 1:length(SNR_dB)
    data = randi([0 1], 1, N_bits);
    tx = 2*data - 1;
    
    % SISO Simulation
    h_siso = (randn(1, N_bits) + 1i*randn(1, N_bits)) / sqrt(2);
    n_siso = (randn(1, N_bits) + 1i*randn(1, N_bits)) * sqrt(1 / (2 * SNR_lin(i)));
    rx_siso = h_siso .* tx + n_siso;
    rx_eq_siso = rx_siso ./ h_siso;
    decoded_siso = real(rx_eq_siso) > 0;
    BER_siso(i) = sum(data ~= decoded_siso) / N_bits;
    
    % SIMO (1x2) with MRC (Maximal Ratio Combining)
    h1 = (randn(1, N_bits) + 1i*randn(1, N_bits)) / sqrt(2);
    h2 = (randn(1, N_bits) + 1i*randn(1, N_bits)) / sqrt(2);
    n1 = (randn(1, N_bits) + 1i*randn(1, N_bits)) * sqrt(1 / (2 * SNR_lin(i)));
    n2 = (randn(1, N_bits) + 1i*randn(1, N_bits)) * sqrt(1 / (2 * SNR_lin(i)));
    
    y1 = h1 .* tx + n1;
    y2 = h2 .* tx + n2;
    
    % MRC: combine using conjugate of channel gains
    y_mrc = conj(h1).*y1 + conj(h2).*y2;
    decoded_mrc = real(y_mrc) > 0;
    BER_mrc_1x2(i) = sum(data ~= decoded_mrc) / N_bits;
end

%% 3. Plotting
figure('Name', 'Exp 7: MIMO Diversity', 'NumberTitle', 'off', 'Color', 'w');

% Plot SISO
semilogy(SNR_dB, BER_siso, '-o', 'Color', [0, 0.45, 0.74], 'LineWidth', 2, ...
    'MarkerSize', 6, 'MarkerFaceColor', [0.8, 0.9, 1]); 
hold on;

% Plot MRC
semilogy(SNR_dB, BER_mrc_1x2, '-s', 'Color', [0.85, 0.33, 0.1], 'LineWidth', 2.5, ...
    'MarkerSize', 7, 'MarkerFaceColor', [1, 0.8, 0.7]);

grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.2, 'YMinorGrid', 'on');
xlabel('SNR (dB)', 'FontWeight', 'bold'); 
ylabel('Bit Error Rate (BER)', 'FontWeight', 'bold');
title('MIMO (MRC 1x2) vs SISO Performance Comparison', 'FontSize', 14);
legend('SISO (1x1) Fading', 'MRC (1x2) Diversity', 'Location', 'southwest');
axis([0 60 1e-6 1]);
sgtitle('Cellular Networks Lab - Exp 7', 'FontSize', 16, 'FontWeight', 'bold');
