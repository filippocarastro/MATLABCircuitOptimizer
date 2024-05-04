clc
clear
close all
%Imposto i nomi dei path dei vari file
sim.filePath = 'C:\Users\Filippo\Documents\LTspice'; %This is the path to the working LTSPICE folder (schems, netlists, simulation output files)
sim.spicePath = 'C:\Users\Filippo\AppData\Local\Programs\ADI\LTspice\LTspice.exe'; % This is the path to your LT Spice installation
sim.fileName='Buck.net';
sim.netlist_filename = [sim.filePath '\' sim.fileName]; %original netlist with param to be optimized
%Mos parameter to be opt
W1 = 1545000; %default [mm]
W2 = 1545000; %default [mm]
val=[W1,W2];
%fitness custom handle function
fit= @(x) fitness(x,sim);
fit([W1 W2])

%%
% parpool('local', 2);
% options = optimoptions('particleswarm','Display','Iter','SwarmSize',15,'MaxIterations',10,'MaxStallIterations',3,'UseParallel',true);
options = optimoptions('particleswarm','Display','Iter','SwarmSize',15,'MaxIterations',10,'MaxStallIterations',3,'UseParallel',false);
% PSO optimizer 
[x_sol,f_sol,~,~] = particleswarm(fit,2,[84500; 84500],[1545000; 1545000],options);
