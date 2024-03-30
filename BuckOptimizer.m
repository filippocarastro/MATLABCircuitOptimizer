clc
clear;
close

%Imposto i nomi dei path dei vari file
spicePath = 'C:\Users\Filippo\AppData\Local\Programs\ADI\LTspice\LTspice.exe'; % This is the path to your LT Spice installation
filePath = 'C:\Users\Filippo\Documents\LTspice\'; %This is the path to the working LTSPICE folder (schems, netlists, simulation output files)
fileName = 'Buck_opt'; %netlist to be optimized
RunLTstring = sprintf('"%s" -b "%s%s.net"',spicePath, filePath, fileName); %Comando per lanciare la simulazione della netlist

%Mos parameter to be opt
W1 = 8e-3; %default
W2 = 8e-3; %default

%Prova di letturadella netlist (e sostituzione parametri W mos1 e W mos2)
netlist_filename = strcat(filePath,"Buck.net"); %original netlist with param
h = fopen(netlist_filename,'r');
Testo=fread(h,Inf,'*char')';
Testo=strrep(Testo,'$W1',num2str(W1)); %Prova W = 10mm
Testo=strrep(Testo,'$W2',num2str(W2)); %Prova W = 10mm
fclose(h);
netlist_filename = strcat(filePath,fileName,".net");
hdest=fopen(netlist_filename, 'w');
fwrite(hdest,Testo,'char');
fclose(hdest);

%Prova di simulazione della netlist
[status,cmdout] = system(RunLTstring);
if(status) 
    fprintf('ERROR, LTSpice sim failed to run.\n ');
    return;
end


%%Read results (in this case only efficiency, but later must be optimized
%%Area)
output_filename = strcat(filePath, fileName,".log");
fileID = fopen(output_filename);

Testo=fread(fileID,Inf,'*char')';
fclose(fileID);
wordString = 'eff: pout/pin=';
newStr = extractAfter(Testo,wordString);
Eff = sscanf(newStr,'%f')
W1,W2

%Prova di ottimizzazione

%Calcolo della fitness function
% x = particleswarm(fun,nvars) %Fun dovrà essere una fitness function
