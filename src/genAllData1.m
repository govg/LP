pBase = 20000;
sBase = 100;
oBase = 2;
eBase = 0.1;
numRuns = 5;

% Generate the base case
Sigma = speye(pBase);
n = ceil(oBase*sBase*log(pBase));
samples = genData(n,pBase,sBase,eBase,Sigma,numRuns);
filename = sprintf('Samples_p%d_s%d_e%g_o%g_Ceye.mat',pBase,sBase,eBase,oBase);
save(filename,'samples');

% Vary p and generate data
for p = [5000 10000 15000 25000]
    Sigma = speye(p);
    n = ceil(oBase*sBase*log(p));
    samples = genData(n,p,sBase,eBase,Sigma,numRuns);
    filename = sprintf('Samples_p%d_s%d_e%g_o%g_Ceye.mat',p,sBase,eBase,oBase);
    save(filename,'samples');
end

Sigma = speye(pBase);

% Vary s and generate data
for s = [50 200 300 500]
    n = ceil(oBase*s*log(pBase));
    samples = genData(n,pBase,s,eBase,Sigma,numRuns);
    filename = sprintf('Samples_p%d_s%d_e%g_o%g_Ceye.mat',pBase,s,eBase,oBase);
    save(filename,'samples');
end

% Vary e and generate data
for e = [0.01 0.05 0.2 0.3 0.4]
    n = ceil(oBase*sBase*log(pBase));
    samples = genData(n,pBase,sBase,e,Sigma,numRuns);
    filename = sprintf('Samples_p%d_s%d_e%g_o%g_Ceye.mat',pBase,sBase,e,oBase);
    save(filename,'samples');
end

% Vary o and generate data
for o = [0.5 1 3 4]
    n = ceil(o*sBase*log(pBase));
    samples = genData(n,pBase,sBase,eBase,Sigma,numRuns);
    filename = sprintf('Samples_p%d_s%d_e%g_o%g_Ceye.mat',pBase,sBase,eBase,o);
    save(filename,'samples');
end