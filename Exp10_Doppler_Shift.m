%% Experiment 10: Compute Doppler Shift
% Aim: Compute doppler shift of the received signal for different carrier frequency of mobile generations.
% Author: Prathamesh Fuke (TE258)
% Date: May 2026

clear; close all; clc;

%% 1. Parameters
v_mph = 60;                      % Velocity in miles per hour
v_ms = v_mph * 1.609 * (1000/3600); % Velocity in m/s
c = 3e8;                         % Speed of light (m/s)
theta_deg = 30;                  % Angle with arrival (degrees)
theta_rad = deg2rad(theta_deg);

% Carrier Frequencies for different generations
fc_list = [900e6, 1850e6, 2100e6, 3500e6]; % Hz
generations = {'2G (900MHz)', 'PCS (1850MHz)', '3G/4G (2100MHz)', '5G (3.5GHz)'};

%% 2. Calculations
fd = (v_ms / c) * fc_list * cos(theta_rad);

%% 3. Results Display
fprintf('Vehicle Speed: %.2f mph (%.2f m/s)\n', v_mph, v_ms);
fprintf('Angle (theta): %d degrees\n', theta_deg);
fprintf('--------------------------------------------------\n');
fprintf('%-20s | %-15s\n', 'Generation', 'Doppler Shift (Hz)');
fprintf('--------------------------------------------------\n');
for i = 1:length(fc_list)
    fprintf('%-20s | %-15.4f\n', generations{i}, fd(i));
end

%% 4. Visualization: Doppler Shift Comparison
figure('Name', 'Exp 10: Doppler Shift Comparison', 'NumberTitle', 'off', 'Color', 'w');

% Use a custom color bar
b = bar(categorical(generations), fd);
b.FaceColor = 'flat';
b.CData(1,:) = [0, 0.45, 0.74]; % Blue
b.CData(2,:) = [0.85, 0.33, 0.1]; % Red
b.CData(3,:) = [0.93, 0.69, 0.13]; % Yellow
b.CData(4,:) = [0.49, 0.18, 0.56]; % Purple

grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.2);
ylabel('Doppler Shift (Hz)', 'FontWeight', 'bold');
title(['Doppler Shift Comparison at ', num2str(v_mph), ' mph (\theta = ', num2str(theta_deg), '^\circ)'], 'FontSize', 14);
sgtitle('Cellular Networks Lab - Exp 10', 'FontSize', 16, 'FontWeight', 'bold');
