%% Experiment 1: Bit Error Rate in presence of Hata propagation model
% Aim: Write a program to measure bit error rate in presence of Hata propagation model
% Author: Prathamesh Fuke (TE258)
% Date: May 2026

clear; close all; clc;

%% 1. Parameters Definition
f = 900;            % Carrier frequency in MHz
Hbts = 30;          % Height of BTS tower (m)
Tbts = 10;          % Terrain elevation at BTS (m)
Htav = 10;          % Average terrain height (m)
Hb = Hbts + Tbts - Htav; % Effective BTS antenna height (m)
Hm = 1.5;           % Mobile antenna height (m)
Pt_W = 20;          % Transmit power in Watts
Gt_dBi = 10;        % BTS antenna gain (dBi)
d = 1:0.1:20;       % Distance range in km

% Noise Parameters
N0_dBm_Hz = -174;   % Thermal noise floor
BW_Hz = 200e3;      % GSM-like bandwidth (200 kHz)
N_dBm = N0_dBm_Hz + 10*log10(BW_Hz) + 5; % Noise floor with 5dB noise figure

%% 2. Hata Model Calculation
% Selecting Environment: 1=Big City, 2=Small City, 3=Suburban, 4=Rural
env = 1; 

switch env
    case 1 % Big City (Urban)
        aHm = 3.2 * (log10(11.75 * Hm))^2 - 4.97;
        C = 0;
        env_name = 'Big City (Urban)';
    case 2 % Small & Medium City
        aHm = (1.1 * log10(f) - 0.7) * Hm - (1.56 * log10(f) - 0.8);
        C = 0;
        env_name = 'Small & Medium City';
    case 3 % Suburban
        aHm = (1.1 * log10(f) - 0.7) * Hm - (1.56 * log10(f) - 0.8);
        C = -2 * (log10(f/28))^2 - 5.4;
        env_name = 'Suburban';
    case 4 % Open Rural
        aHm = (1.1 * log10(f) - 0.7) * Hm - (1.56 * log10(f) - 0.8);
        C = -4.78 * (log10(f))^2 + 18.33 * log10(f) - 40.98;
        env_name = 'Open Rural';
end

A = 69.55 + 26.16*log10(f) - 13.82*log10(Hb) - aHm;
B = 44.9 - 6.55*log10(Hb);

PL = A + B*log10(d) + C; % Path Loss in dB
Pr_dBm = 10*log10(Pt_W * 1000) + Gt_dBi - PL; % Received power in dBm

%% 3. SNR and BER Calculation
SNR_dB = Pr_dBm - N_dBm;
SNR_lin = 10.^(SNR_dB / 10);
BER = 0.5 * erfc(sqrt(SNR_lin));
BER(BER < 1e-10) = 1e-10; % Clipping for log scale

%% 4. Plotting
fig = figure('Name', 'Exp 1: Hata Model Analysis', 'NumberTitle', 'off', 'Color', 'w');

% Define custom colors
red_color = [0.85, 0.33, 0.10];
blue_color = [0, 0.45, 0.74];

subplot(2,1,1);
plot(d, Pr_dBm, 'Color', red_color, 'LineWidth', 2.5);
grid on;
set(gca, 'FontSize', 11, 'LineWidth', 1.2);
xlabel('Distance (km)', 'FontWeight', 'bold'); 
ylabel('Received Power (dBm)', 'FontWeight', 'bold');
title(['Received Signal Level vs Distance - ', env_name], 'FontSize', 13);

subplot(2,1,2);
semilogy(d, BER, 'Color', blue_color, 'LineWidth', 2.5);
grid on;
set(gca, 'FontSize', 11, 'LineWidth', 1.2);
xlabel('Distance (km)', 'FontWeight', 'bold'); 
ylabel('Bit Error Rate (BER)', 'FontWeight', 'bold');
title('BER vs Distance (BPSK Modulation)', 'FontSize', 13);

% Main Title
sgtitle(['Cellular Networks Lab - Exp 1: Hata Model (', num2str(f), ' MHz)'], ...
    'FontSize', 15, 'FontWeight', 'bold', 'Color', [0.2, 0.2, 0.2]);
