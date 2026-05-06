%% Experiment 6: Link-Budget Analysis
% Aim: Perform a Link-Budget analysis for a wireless communication system.
% Author: Prathamesh Fuke (TE258)
% Date: May 2026

clear; close all; clc;

%% 1. Parameters Listing
% Gains (+)
Pt_dBm = 33;      % Transmit power (e.g., 2W)
Gt_dBi = 12;      % Transmit antenna gain
Gr_dBi = 2;       % Receive antenna gain

% Losses (-)
L50_dB = 135;     % Median propagation loss (e.g., at 5km)
M_dB = 10;        % Margin (Shadowing, etc.)
Lc_dB = 3;        % Cabling and connector losses

% Noise/Interference (-)
N_I_dBm = -105;   % Noise + Interference floor

%% 2. Link Budget Calculation
% Received Power Pr
Pr_dBm = Pt_dBm + Gt_dBi - L50_dB - M_dB + Gr_dBi - Lc_dB;

% Achieved SNR
SNR_achieved = Pr_dBm - N_I_dBm;

% Required Transmit Power for a target SNR (e.g., 15dB)
SNR_req = 15;
Pt_req_dBm = SNR_req - Gt_dBi + L50_dB + M_dB - Gr_dBi + Lc_dB + N_I_dBm;

%% 3. Results Table
fprintf('========== Link Budget Analysis ==========\n');
fprintf('%-30s: %6.2f dBm\n', 'Transmit Power (Pt)', Pt_dBm);
fprintf('%-30s: %6.2f dBi\n', 'TX Antenna Gain (Gt)', Gt_dBi);
fprintf('%-30s: %6.2f dBi\n', 'RX Antenna Gain (Gr)', Gr_dBi);
fprintf('%-30s: %6.2f dB\n',  'Median Path Loss (L50)', L50_dB);
fprintf('%-30s: %6.2f dB\n',  'Link Margin (M)', M_dB);
fprintf('%-30s: %6.2f dB\n',  'Cabling Losses (Lc)', Lc_dB);
fprintf('%-30s: %6.2f dBm\n', 'Noise + Interference', N_I_dBm);
fprintf('------------------------------------------\n');
fprintf('%-30s: %6.2f dBm\n', 'Received Power (Pr)', Pr_dBm);
fprintf('%-30s: %6.2f dB\n',  'Achieved SNR', SNR_achieved);
fprintf('%-30s: %6.2f dBm\n', 'Required Pt for 15dB SNR', Pt_req_dBm);
fprintf('==========================================\n');

%% 4. Visualization: SNR vs Distance
d = 1:0.1:20;
PL = 120 + 35*log10(d); % Simple Path Loss Model
SNR_dist = Pt_dBm + Gt_dBi - PL - M_dB + Gr_dBi - Lc_dB - N_I_dBm;

figure('Name', 'Exp 6: Link Budget Analysis', 'NumberTitle', 'off', 'Color', 'w');
plot(d, SNR_dist, 'Color', [0, 0.5, 0], 'LineWidth', 2.5); % Dark Green
hold on;

% Add Required SNR Line
target = yline(SNR_req, 'r--', 'LineWidth', 2);
target.Label = ['Target SNR: ', num2str(SNR_req), ' dB'];
target.FontWeight = 'bold';

grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.2);
xlabel('Distance (km)', 'FontWeight', 'bold'); 
ylabel('Achieved SNR (dB)', 'FontWeight', 'bold');
title('System SNR Performance vs Distance', 'FontSize', 14);
legend('Achieved SNR', 'Threshold', 'Location', 'northeast');
sgtitle('Cellular Networks Lab - Exp 6', 'FontSize', 16, 'FontWeight', 'bold');
