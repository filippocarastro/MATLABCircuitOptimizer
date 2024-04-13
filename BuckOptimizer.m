clc;clear all;close all;
%Imposto i nomi dei path dei vari file
sim.spicePath = 'C:\Users\Filippo\AppData\Local\Programs\ADI\LTspice\LTspice.exe'; % This is the path to your LT Spice installation
% sim.spicePath = 'C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe'; % This is the path to your LT Spice installation
sim.filePath = 'C:\Users\Filippo\Documents\LTspice\'; %This is the path to the working LTSPICE folder (schems, netlists, simulation output files)
% sim.filePath = 'C:\Users\franz\Desktop\MATLABCircuitOptimizer-main\'; %This is the path to the working LTSPICE folder (schems, netlists, simulation output files)
sim.fileName = 'Buck_opt'; %netlist to be optimized
sim.RunLTstring = sprintf('"%s" -b "%s%s.net"',sim.spicePath, sim.filePath, sim.fileName); %Comando per lanciare la simulazione della netlist
sim.netlist_filename = [sim.filePath 'Buck.net']; %original netlist with param
% looks like buck.net autodelete.
%Mos parameter to be opt
W1 = 5e-3; %default
W2 = 5e-3; %default
val=[W1,W2];
%fitness custom handle function
fit= @(x) fitness(x,sim);
fit(val)
%%
options = optimoptions('particleswarm','Display','Iter','SwarmSize',10);
% PSO optimizer 
[x_sol,f_sol,~,~] = particleswarm(fit,2,[5e-3; 5e-3],[15e-3; 15e-3],options);
