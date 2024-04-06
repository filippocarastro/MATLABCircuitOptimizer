clc;clear all;close all;
%Imposto i nomi dei path dei vari file
% sim.spicePath = 'C:\Users\Filippo\AppData\Local\Programs\ADI\LTspice\LTspice.exe'; % This is the path to your LT Spice installation
% sim.spicePath = 'C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe'; % This is the path to your LT Spice installation
% % sim.filePath = 'C:\Users\Filippo\Documents\LTspice\'; %This is the path to the working LTSPICE folder (schems, netlists, simulation output files)
% sim.filePath = 'C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-main\'; %This is the path to the working LTSPICE folder (schems, netlists, simulation output files)
% sim.fileName = 'Buck_opt'; %netlist to be optimized
% sim.RunLTstring = sprintf('"%s" -b "%s%s.net"',sim.spicePath, sim.filePath, sim.fileName); %Comando per lanciare la simulazione della netlist
% sim.netlist_filename = [sim.filePath 'Buck.net']; %original netlist with param
% % looks like buck.net autodelete.
% %Mos parameter to be opt
% W1 = 8e-3; %default
% W2 = 8e-3; %default
% val=[W1,W2];
%fitness custom handle function
fit= @(x) fitness(x);
% fit(val)
options = optimoptions('particleswarm','UseParallel',false,'MaxStallIterations',5,'Display','Iter','SwarmSize',40);
% PSO optimizer 
tic
[x_sol,f_sol,~,~] = particleswarm(fit,2,[1e-5; 1e-5],[1e-2; 1e-2],options);
toc