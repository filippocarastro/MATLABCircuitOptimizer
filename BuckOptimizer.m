clc
clear;
close

spicePath = 'C:\Users\Filippo\AppData\Local\Programs\ADI\LTspice\LTspice.exe'; % This is the path to your LT Spice installation
filePath = 'C:\Users\Filippo\Documents\LTspice\'; %This is the path to the working LTSPICE folder (schems, netlists, simulation output files)
fileName = 'Buck';
RunLTstring = sprintf('"%s" -b "%s%s.net"',spicePath, filePath, fileName);

[status,cmdout] = system(RunLTstring);
if(status) 
    fprintf('ERROR, LTSpice sim failed to run.\n ');
    return;
end


%%Read results
output_file_name = strcat(filePath,"Buck.log");
fileID = fopen(output_file_name);

testo=char(fread(fileID,Inf,'char'))';

wordString = 'eff: pout/pin=';
newStr = extractAfter(testo,wordString);
Eff = sscanf(newStr,'%f');
