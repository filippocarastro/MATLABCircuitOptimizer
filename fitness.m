function eff = fitness(features)
%FITNESS Summary of this function goes here
% Open a default netlist
h = fopen('C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-main\Buck.net','r');
Testo=fread(h,Inf,'*char')';
% Take the txt and replace the special characters on the default netlist (the features to be optimized)
Testo=strrep(Testo,'$w1',num2str(features(1,1))); 
Testo=strrep(Testo,'$w2',num2str(features(1,2))); 
fclose(h);
% Write the text as netlist to be simulated. Default file is not modified.
% Generate random name for the written netlist to avoid conflict wrt parallel workers
pathtmp=tempname('C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-main');
hdest=fopen([pathtmp '.net'], 'w');
fwrite(hdest,Testo,'char');
fclose(hdest);
% Netlist simulation with system (cmd) launching the command string related to the written netlist
[status,~] = system(['"C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b ','"',pathtmp,'.net"']);
% [status,~] = system(['"C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b "C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-main\',namew,'.net"']);

% Debug status error for the current launched LTSpice simulation.
if(status) 
    fprintf('ERROR, LTSpice sim failed to run.\n ');
    return;
end
% Read efficiency (fitness cost) from log file
fileID = fopen([pathtmp '.log']);
Testo=fread(fileID,Inf,'*char')';
fclose(fileID);
newStr = extractAfter(Testo,'eff: pout/pin=');
% minus the efficiency is the cost to be minimized with PSO optimizer (efficiency is maximized)
eff = -sscanf(newStr,'%f');
% Clean tmp files
delete([pathtmp '.net'])
delete([pathtmp '.log'])
delete([pathtmp '.raw'])
delete([pathtmp '.op.raw'])

end

