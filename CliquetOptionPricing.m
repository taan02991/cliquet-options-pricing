function [P,sigmaP,CI,C,X]=CliquetOptionPricing(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod)

[b,CType] = FindBestCAndComputeB(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod);

X = nan(M,1);
C = nan(M,1);

for i=1:M
    [S, ~] = HestonmodelAnti(S0, r, sigma0, kappa, theta, delta, rho, T, N);
    X(i,1) = computeCliquetPrice(S, S, N, Type, Cap, Floor, ResetPeriod, r, T);
    if strcmp(CType,'A')
        C(i,1) = computeAsianPrice(S,S,N,Type,K,r,T);
    elseif strcmp(CType,'E')
        C(i,1) = computeEuroPrice(S,S,N,Type,K,r,T);
    else
        error('"type" must be either ''A'' or ''E''')
    end
[P,sigmaP,CI]=normfit(X - b*(C-mean(C)));
end