% samples = genData(n,p,s,e,eps,numRuns)
% samples: a structure containing the samples (X,y,theta) for sparse linear regression
% n: number of samples
% p: dimensionality
% s: sparsity of parameter vector
% e: label noise level
% eps: correlation level in covariance matrix
% numRuns: number of Runs to generate data for. Each run uses an independent realization of i.i.d. noise

function [samples] = genData(n,p,s,e,eps,numRuns)
    % Save the key values of this data model
    samples.n = n;
    samples.p = p;
    samples.s = s;
    samples.e = e;
    samples.eps = eps;
    
    % Generate and save the sparse parameter vector
    samples.theta = zeros(p,1);
    thetaVal = 2*randi(2,s,1)-3;
    thetaSupp = randperm(p);
    samples.theta(thetaSupp(1:s)) = thetaVal;
    
    % Find the support of the parameter vector and choose a random subset for the correlated set of indices
    so = find(samples.theta);
    rp1 = randperm(length(so));
    corrDim1 = so(rp1(1:ceil(s/2)));
    
    % Find the other half of the coorelated indices from the non support of the parameter vector
    sc = find(samples.theta == 0);
    rp2 = randperm(p - length(so));
    corrDim2 = sc(rp2(1:s-ceil(s/2)));
    
    % Construct the set of correlated indices
    corrDim = [corrDim1;corrDim2];
    Sigma = speye(p);
    
    % Construct the covariance matrix over the correlated indices
    RC = (rand(s,s)-0.5)/sqrt(s)*eps;
    RC = triu(RC) + triu(RC)';
    RC = RC + eye(s) - diag(diag(RC));
    
    % Check if the matrix is PSD
    samples.eigSigma = eig(RC);
    if ~isempty(find(samples.eigSigma <= 0, 1))
        error('Try again - could not construct a PSD matrix\n');
    end
    
    % Embed it into the global covariance matrix
    Sigma(corrDim,corrDim) = RC;
    samples.Sigma = Sigma;
    
    % Generate, normalize and save the data points
    % If normal distribution is desired then go for it straightaway
    if nnz(Sigma-speye(p)) == 0
        X = randn(n,p);
    else
        X = mvnrnd(zeros(p,1),Sigma,n);
    end
    normX = sqrt(sum(X.^2,1));
    samples.X = bsxfun(@rdivide,X,normX);
    
    % Generate and save the labels
    samples.y = bsxfun(@plus,samples.X*samples.theta,e*randn(n,numRuns));
end