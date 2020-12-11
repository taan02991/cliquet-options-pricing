function VarNonVarPlot(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, Type, Cap, Floor, ResetPeriod)

sigmaP1s = [];
sigmaP2s = [];
M = [];

for m = 100:100:1000
    [P1,sigmaP1,CI1] = CliquetOptionPricing(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, Type, m, Cap, Floor, ResetPeriod);
    [P2,sigmaP2,CI2] = CliquetOptionPricingNoVarianceReduction(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, Type, m, Cap, Floor, ResetPeriod);
    M = cat(2, M, m);
    sigmaP1s = cat(2, sigmaP1s, sigmaP1);
    sigmaP2s = cat(2, sigmaP2s, sigmaP2);
end
figure;
plot(M, sigmaP1s, '--ob');
hold on;
plot(M, sigmaP2s, '--or');
hold off;
xlabel('Number of simulations'); ylabel('sigma');
legend('Control Variate', 'Non-control variate');
end