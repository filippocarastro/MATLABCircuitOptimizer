clc;clear all;close all;
%Imposto i nomi dei path dei vari file
sim.filePath = 'C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-loop'; %This is the path to the working LTSPICE folder (schems, netlists, simulation output files)
sim.fileName='NetBuck.net'; % 'NetBuck_Vopt.net'
sim.netlist_filename = [sim.filePath '\' sim.fileName]; %original netlist with param to be optimized
sim.Vtarget=12;
%Mos parameter to be opt
W1 = 1e-2; %default
W2 = 1e-2; %default
%fitness custom handle function
fit= @(x) fitness(x,sim);
fit([W1 W2])
% another version to change the Vout, not tested
% Rf=8.03e3;
% fitVpopt= @(x) fitnessVopt(x);
% fit(Rf)
%%
options = optimoptions('particleswarm','Display','Iter','SwarmSize',40,'MaxStallIterations',5,'UseParallel',false);
% PSO optimizer 
[x_sol,f_sol,~,~] = particleswarm(fit,2,[1e-3; 1e-3],[25e-3; 25e-3],options);
% [x_sol,f_sol,~,~] = particleswarm(fitVpopt,2,1e3,113e3,options);
