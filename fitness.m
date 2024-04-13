function eff = fitness(features)
%FITNESS Summary of this function goes here
% Open default netlist
h = fopen('C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-loop\NetBuck.net','r');
Testo=fread(h,Inf,'*char')';
% replace features
Testo=strrep(Testo,'$w1',num2str(features(1))); 
Testo=strrep(Testo,'$w2',num2str(features(2)));
Testo=strrep(Testo,'$Rd_HS',num2str(0.25*features(1))); 
Testo=strrep(Testo,'$Rd_LS',num2str(0.25*features(2))); 
% fprintf('W_HS=%f\tW_LS=%f\n',features(1),features(2));
fclose(h);
pathtmp=tempname('C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-loop');
% Write netlist to be simulated
hdest=fopen([pathtmp '.net'], 'w');
fwrite(hdest,Testo,'char');
fclose(hdest);
% Netlist simulation
[status,~] = system(['"C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b ','"',pathtmp,'.net"']);
if(status) 
    fprintf('ERROR, LTSpice sim failed to run.\n ');
    features
end
% Read efficiency
fileID = fopen([pathtmp '.log']);
Testo=fread(fileID,Inf,'*char')';
fclose(fileID);
newStr = extractAfter(Testo,'eff: pout/pin=');

% minus the efficiency to minimize (max to min problem)
eff = -sscanf(newStr,'%f');
delete([pathtmp '.net'])
delete([pathtmp '.log'])
delete([pathtmp '.raw'])
delete([pathtmp '.op.raw'])
end

