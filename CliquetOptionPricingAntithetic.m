function [P,sigmaP,CI,X]=CliquetOptionPricingAntithetic(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod)
% This function computes the Cliquet call/put option prices
% of a stock whose price process follows the Heston model and
% interest rate using CIR model and
% using the antithetic technique.

X = nan(M,1);

for i=1:M
    % simulate r by CIR model
    r = CIRModel(r0,r_b,rbar,omega,T,N);
    % simulate stock price by Heston model
    [S, ~, Shat, ~] = HestonmodelAnti(S0, r, sigma0, kappa, theta, delta, rho, T, N);
    % compute cliquet option price with antithetic technique
    X(i,1) = computeCliquetPrice(S, Shat, N, Type, Cap, Floor, ResetPeriod, r, T);
[P,sigmaP,CI]=normfit(X);
end