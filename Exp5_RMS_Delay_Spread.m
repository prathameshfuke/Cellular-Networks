%% Experiment 5: Compute RMS Delay Spread
% Aim: Compute the RMS delay spread for a given Power profile and plot the graph of Power vs Delay.
% Author: Prathamesh Fuke (TE258)
% Date: May 2026

clear; close all; clc;

%% 1. Input Power Delay Profile (PDP)
% Example delays in ns and powers in dBm
tau = [0, 50, 100, 150, 200, 250];  % Delays in ns
P_dBm = [0, -3, -6, -9, -12, -15];  % Power in dBm

% Convert power to linear scale
P_lin = 10.^(P_dBm / 10);

%% 2. Calculations
% Mean Excess Delay (tau_bar)
tau_bar = sum(P_lin .* tau) / sum(P_lin);

% Mean Square Delay (tau2_bar)
tau2_bar = sum(P_lin .* (tau.^2)) / sum(P_lin);

% RMS Delay Spread (sigma_tau)
sigma_tau = sqrt(tau2_bar - tau_bar^2);

% Coherence Bandwidth (Bc)
Bc_90 = 1 / (50 * sigma_tau * 1e-9); % 90% correlation
Bc_50 = 1 / (5 * sigma_tau * 1e-9);  % 50% correlation

%% 3. Results Display
fprintf('--- Power Delay Profile Results ---\n');
fprintf('Mean Excess Delay : %.2f ns\n', tau_bar);
fprintf('RMS Delay Spread  : %.2f ns\n', sigma_tau);
fprintf('Coherence BW (0.9): %.2f MHz\n', Bc_90 / 1e6);
fprintf('Coherence BW (0.5): %.2f MHz\n', Bc_50 / 1e6);

%% 4. Plotting
figure('Name', 'Exp 5: RMS Delay Spread', 'NumberTitle', 'off', 'Color', 'w');

% Define colors
sky_blue = [0.30, 0.75, 0.93];

stem(tau, P_dBm, 'filled', 'LineWidth', 2.5, 'MarkerSize', 10, 'Color', sky_blue);
hold on;

% Add Mean Delay Line
xl = xline(tau_bar, 'r--', 'LineWidth', 2);
xl.Label = ['Mean Delay: ', num2str(round(tau_bar, 2)), ' ns'];
xl.FontSize = 10;
xl.FontWeight = 'bold';

grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.2);
xlabel('Delay (ns)', 'FontWeight', 'bold'); 
ylabel('Power (dBm)', 'FontWeight', 'bold');
title('Power Delay Profile (PDP)', 'FontSize', 14);
legend('Multipath Components', 'Location', 'northeast');
sgtitle('Cellular Networks Lab - Exp 5', 'FontSize', 16, 'FontWeight', 'bold');
