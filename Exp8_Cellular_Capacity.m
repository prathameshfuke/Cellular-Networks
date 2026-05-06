%% Experiment 8: Number of Users Calculations
% Aim: Title: Simulate a cellular system with 48 channels per cell and a blocking probability of 2%.
% Author: Prathamesh Fuke (TE258)
% Date: May 2026

clear; close all; clc;

%% 1. Parameters
channels_per_cell = 48;
blocking_prob = 0.02;
traffic_per_user = 0.04; % Erlangs
city_area_km2 = 603;

% Offered load A for N=48, PB=0.02 is 38.4 Erlangs (from Erlang B table)
A_offered = 38.4;

%% 2. Calculations
users_per_cell = A_offered / traffic_per_user;

% Radii range as per manual
R_m = [500, 700, 900, 1000, 1200, 1500];
R_km = R_m / 1000;

cell_area_km2 = (3 * sqrt(3) / 2) * (R_km.^2);
num_cells = ceil(city_area_km2 ./ cell_area_km2);
total_users = num_cells * users_per_cell;

%% 3. Display Results Table
fprintf('Radius(m)\tCell Area(km2)\tNo. of Cells\tTotal Users\n');
fprintf('------------------------------------------------------------\n');
for i = 1:length(R_m)
    fprintf('%-10d\t%-15.4f\t%-15d\t%-15d\n', R_m(i), cell_area_km2(i), num_cells(i), total_users(i));
end

%% 4. Plotting
figure('Name', 'Exp 8: Cellular Capacity Analysis', 'NumberTitle', 'off', 'Color', 'w');
plot(R_m, total_users, '-d', 'LineWidth', 2.5, ...
    'Color', [0.6350, 0.0780, 0.1840], ... % Dark Red
    'MarkerSize', 10, ...
    'MarkerFaceColor', [1, 0.8, 0.8]);

grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.2);
xlabel('Cell Radius (meters)', 'FontWeight', 'bold'); 
ylabel('Total Users Supported', 'FontWeight', 'bold');
title('Effect of Cell Radius on System Capacity', 'FontSize', 14);
sgtitle('Cellular Networks Lab - Exp 8', 'FontSize', 16, 'FontWeight', 'bold');
