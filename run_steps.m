clc; clear all; close all;
% This code calls step.m function and generates
% a sequence of step inputs with normaly distributed
% random amplitudes.
 
%% Define inputs
% number of inputs that system has
n_input = 2;

% input time step (adapt based on sample rate used on myRIO)
dt_input = 0.01; % seconds

% total signal duration (adapt and try different combinations to obtain better model)
duration_input = 300; %seconds

% set frequency of steps
freq_input = 1/6;

% set duty cycle (percentage of non-zero value - zero value will be 100-D.C.) in %
duty_cycle = 80;

% Define units: 'b' for bar or 'V' for volts
units = 'b';

%% Call function
[input_rand_step, t] = steps(n_input, dt_input, duration_input, freq_input, duty_cycle, units);

%% Write csv file
csvwrite('input_rand_step.csv',input_rand_step);

%% Visualize
set(0,'defaulttextinterpreter','latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0,'defaultLegendInterpreter','latex');
set(0,'DefaultLineLineWidth',1.5)

figure; hold on; grid on;
for i=1:n_input
    plot(t,input_rand_step(i+1,:))
end;
title('Randomized Step Inputs')
xlabel('Time, s')
ylabel('Input')