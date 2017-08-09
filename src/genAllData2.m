pBase = 20000;
sBase = 100;
oBase = 2;
eBase = 0.1;
numRuns = 5;

n = ceil(oBase*sBase*log(pBase));

for eps = [0.05]%[0.25 0.5 0.75 1 1.25 1.5 1.75]
    samples = genData(n,pBase,sBase,eBase,eps,numRuns);
    filename = sprintf('Samples_p%d_s%d_e%g_o%g_Ceps%g.mat',pBase,sBase,eBase,oBase,eps);
    save(filename,'samples');
end