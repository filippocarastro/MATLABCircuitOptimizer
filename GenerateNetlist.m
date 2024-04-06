function GenerateNetlist(dir)
system(sprintf('"%s" -b "%s%s%s.net"','C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe', 'C:\Users\Kreidos\Desktop\MATLABCircuitOptimizer-main\', dir, 'Buck_opt'))
end