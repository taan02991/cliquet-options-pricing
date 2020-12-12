function [P,sigmaP,CI,C,X]=CliquetOptionPricingControlVariate(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod)
% This function computes the Cliquet call/put option prices
% of a stock whose price process follows the Heston model and
% interest rate using CIR model and
% using the Control variate technique.

% Control Variate Technique: 
% Y = X - b(C-E[C])

% find b and C option type
[b,CType] = FindBestCAndComputeB(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod);

X = nan(M,1);
C = nan(M,1);

for i=1:M
    % simulate r by CIR model
    r = CIRModel(r0,r_b,rbar,omega,T,N);
    % simulate stock price by Heston model
    [S, ~] = HestonmodelAnti(S0, r, sigma0, kappa, theta, delta, rho, T, N);
    % compute cliquet option price (X in an equation stated above)
    X(i,1) = computeCliquetPrice(S, S, N, Type, Cap, Floor, ResetPeriod, r, T);
    % compute C price
    if strcmp(CType,'A')
        C(i,1) = computeAsianPrice(S,S,N,Type,K,r,T);
    elseif strcmp(CType,'E')
        C(i,1) = computeEuroPrice(S,S,N,Type,K,r,T);
    else
        error('"type" must be either ''A'' or ''E''')
    end
% Option price after using control variate technique.
[P,sigmaP,CI]=normfit(X - b*(C-mean(C)));
end