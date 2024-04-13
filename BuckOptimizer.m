clc;clear all;close all;
%Mos parameter to be opt
W1 = 5e-3; %default
W2 = 5e-3; %default
val=[W1,W2];
% val=x_sol
%fitness custom handle function
fit= @(x) fitness(x);
fit(val)
%%
options = optimoptions('particleswarm','UseParallel',true,'Display','Iter','SwarmSize',20,'MaxStallIterations',5);
% PSO optimizer 
[x_sol,f_sol,~,~] = particleswarm(fit,2,[5e-3; 5e-3],[15e-3; 15e-3],options);
