function cost = fitnessVopt(features)
%FITNESS Summary of this function goes here
% Open a default netlist
h = fopen('C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-loop\NetBuck_Vopt.net','r');
Testo=fread(h,Inf,'*char')';
% Take the txt and replace the special characters on the default netlist (the features to be optimized)
Testo=strrep(Testo,'$Rf',num2str(features)); 
fclose(h);
% Write the text as netlist to be simulated. Default file is not modified.
% Generate random name for the written netlist to avoid conflict wrt parallel workers
pathtmp=tempname('C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-loop');
% Write netlist to be simulated
hdest=fopen([pathtmp '.net'], 'w');
fwrite(hdest,Testo,'char');
fclose(hdest);
% Netlist simulation with system (cmd) launching the command string related to the written netlist
[status,~] = system(['"C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b ','"',pathtmp,'.net"']); 
% Debug status error for the current launched LTSpice simulation.
if status 
    fprintf('ERROR, LTSpice sim failed to run.\n ');
    features
end
% Read efficiency (fitness cost) from log file
fileID = fopen([pathtmp '.log']);
Testo=fread(fileID,Inf,'*char')';
fclose(fileID);
newStr = extractAfter(Testo,'AVG(v(out))=');
% minus the efficiency is the cost to be minimized with PSO optimizer (efficiency is maximized)
Vout = sscanf(newStr,'%f');
cost= abs(Vout-12);
% Clean tmp files
delete([pathtmp '.net'])
delete([pathtmp '.log'])
delete([pathtmp '.raw'])
delete([pathtmp '.op.raw'])
end

