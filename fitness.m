function eff = fitness(features,sim)
%FITNESS Summary of this function goes here
% Open default netlist
h = fopen(sim.netlist_filename,'r');
Testo=fread(h,Inf,'*char')';
% replace features
Testo=strrep(Testo,'$w1',num2str(features(1))); 
Testo=strrep(Testo,'$w2',num2str(features(2)));
Testo=strrep(Testo,'$Rd_HS',num2str(4*features(1))); 
Testo=strrep(Testo,'$Rd_LS',num2str(4*features(2))); 
fprintf('W_HS=%f\tW_LS=%f\n',features(1),features(2));
fclose(h);
% Write netlist to be simulated
hdest=fopen([sim.filePath sim.fileName '.net'], 'w');
fwrite(hdest,Testo,'char');
fclose(hdest);
% Netlist simulation
[status,~] = system(sim.RunLTstring);
if(status) 
    fprintf('ERROR, LTSpice sim failed to run.\n ');
    return;
end
% Read efficiency
fileID = fopen([sim.filePath, sim.fileName,'.log']);
Testo=fread(fileID,Inf,'*char')';
fclose(fileID);
newStr = extractAfter(Testo,'eff: pout/pin=');

% minus the efficiency to minimize (max to min problem)
eff = -sscanf(newStr,'%f');

if isempty(eff)
    eff = 0;
end

end

