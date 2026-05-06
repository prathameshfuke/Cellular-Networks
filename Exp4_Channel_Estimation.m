%% Experiment 4: Channel Estimation in Rayleigh Fading
% Aim: Estimate fading channel coefficient in AWGN for given transmitted pilot symbols and received outputs across the standard Rayleigh fading wireless channel.
% Author: Prathamesh Fuke (TE258)
% Date: May 2026

clear; close all; clc;

%% 1. Parameters
SNR_dB = 0:5:30;
SNR_lin = 10.^(SNR_dB / 10);
N_pilots = 1000; % Number of pilot symbols per SNR point

%% 2. Estimation Simulation
MSE = zeros(1, length(SNR_dB));

for i = 1:length(SNR_dB)
    % Transmit known pilot symbols (BPSK +1)
    X = ones(1, N_pilots);
    
    % Actual Rayleigh Channel
    H = (randn(1, N_pilots) + 1i*randn(1, N_pilots)) / sqrt(2);
    
    % AWGN Noise
    N = (randn(1, N_pilots) + 1i*randn(1, N_pilots)) * sqrt(1 / (2 * SNR_lin(i)));
    
    % Received Signal
    Y = H .* X + N;
    
    % Least Squares (LS) Channel Estimation
    H_est = Y ./ X;
    
    % Calculate Mean Square Error (MSE)
    MSE(i) = mean(abs(H - H_est).^2);
end

%% 3. Plotting
figure('Name', 'Exp 4: Channel Estimation', 'NumberTitle', 'off', 'Color', 'w');

semilogy(SNR_dB, MSE, '-p', 'LineWidth', 2.5, ...
    'Color', [0.49, 0.18, 0.56], ...
    'MarkerSize', 10, ...
    'MarkerEdgeColor', [0.3, 0.1, 0.4], ...
    'MarkerFaceColor', [0.9, 0.7, 1]);

grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.2, 'YMinorGrid', 'on');
xlabel('SNR (dB)', 'FontWeight', 'bold'); 
ylabel('Mean Square Error (MSE)', 'FontWeight', 'bold');
title('Channel Estimation Error (LS) vs SNR', 'FontSize', 14);
sgtitle('Cellular Networks Lab - Exp 4: Channel Estimation', 'FontSize', 16, 'FontWeight', 'bold');

% Example comparison
fprintf('SNR(dB)\tActual H(1)\t\tEstimated H(1)\t\tError\n');
fprintf('------------------------------------------------------------\n');
fprintf('%d\t%.4f + %.4fi\t%.4f + %.4fi\t%.4e\n', ...
    SNR_dB(end), real(H(1)), imag(H(1)), real(H_est(1)), imag(H_est(1)), abs(H(1)-H_est(1))^2);
