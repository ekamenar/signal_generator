function [input_rand_step, t] = steps(n_input, dt_input, duration_input, freq_input, duty_cycle, units)
% steps.m creates a sequence of steps with normaly distributed random amplitudes

% Inputs: 
%   n_inputs        : number of inputs (1 ... n)
%   dt_input        : time step (sec)
%   duration_input  : total signal duration (sec)
%   freq_input      : frequency of input signal(s)
%   duty_cycle      : duty cycle of input signal(s), i.e. % of nonzero values
%   units           : generated output (0...6 bar or -10 ... 10V)

% Outputs:
%   input_rand_step : time series vector (first row is time, other rows are amplitudes [t; input1; input2; inputn]);

%% Check for units
if units == 'b'
    input_max = 6; %bar - maximum allowable input pressure
elseif units == 'V'
    input_max = 10; %volts - maximum allowable input voltage
else
    disp('Wrong unit!');
    return
end;

%% Generator
%time vector
t = 0:dt_input:duration_input; t(end) = [];

% number of full steps
n_steps = floor(duration_input*freq_input);

%total number of data points
dp = size(t,2);

% Choose a random collection of inputs (these are essentilly the aplitudes of each step in series)
input_rand = rand(n_input,n_steps);

% if unit is set to volts, scale to -1 to +1 range 
if units == 'V'
    input_rand = (input_rand-0.5)*2;
end;

% calculate non-zero values duration based on duty cycle 
non_zero_val_count = floor((dp*(duty_cycle/100))/n_steps);

% create vector/matrix of inputs
input = [];
for i=1:n_steps 
    for j=1:n_input    
        input_temp(j,:) = [repelem(0,(dp/n_steps-non_zero_val_count)) repelem(input_rand(j,i),non_zero_val_count)]; %input_temp = [nonzero_data_points     zero_data_points]
    end;
    input = [input input_temp];
end;
%% Results
input_rand_step = [t; input];