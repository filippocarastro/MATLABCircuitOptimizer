function eff = fitness(features,sim)
%FITNESS Summary of this function goes here
% Open a default netlist
h = fopen(sim.netlist_filename,'r');
Testo=fread(h,Inf,'*char')';
% Take the txt and replace the special characters on the default netlist (the features to be optimized)
Testo=strrep(Testo,'$w1',num2str(features(1))); 
Testo=strrep(Testo,'$w2',num2str(features(2)));
Testo=strrep(Testo,'$Rd_HS',num2str(.04*features(1))); 
Testo=strrep(Testo,'$Rd_LS',num2str(.04*features(2))); 
fclose(h);
% Write the text as netlist to be simulated. Default file is not modified.
% Generate random name for the written netlist to avoid conflict wrt parallel workers
pathtmp=tempname(sim.filePath);
% Write netlist to be simulated
hdest=fopen([pathtmp '.net'], 'w');
fwrite(hdest,Testo,'char');
fclose(hdest);
% Netlist simulation with system (cmd) launching the command string related to the written netlist
[status,~] = system([sim.spicePath,' -b ',pathtmp,'.net']); 
disp(status);
% Debug status error for the current launched LTSpice simulation.
if status 
    fprintf('ERROR, LTSpice sim failed to run.\n ');
    disp(features);
end
% Read efficiency (fitness cost) from log file
fileID = fopen([pathtmp '.log']);
Testo=fread(fileID,Inf,'*char')';
fclose(fileID);
newStr = extractAfter(Testo,'eff: pout/pin=');
% minus the efficiency is the cost to be minimized with PSO optimizer (efficiency is maximized)
eff = -sscanf(newStr,'%f');
disp(-eff);
% Clean tmp files
delete([pathtmp '.net'])
delete([pathtmp '.log'])
delete([pathtmp '.raw'])
delete([pathtmp '.op.raw'])
end

