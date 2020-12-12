function VarNonVarPlot(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, Type, Cap, Floor, ResetPeriod)

sigmaP1s = [];
sigmaP2s = [];
sigmaP3s = [];
M = [];

for m = 1000:1000:10000
    [P1,sigmaP1,CI1] = CliquetOptionPricingControlVariate(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, Type, m, Cap, Floor, ResetPeriod);
    [P2,sigmaP2,CI2] = CliquetOptionPricingNoVarianceReduction(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, Type, m, Cap, Floor, ResetPeriod);
    [P3,sigmaP3,CI3] = CliquetOptionPricingAntithetic(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, Type, m, Cap, Floor, ResetPeriod);
    M = cat(2, M, m);
    sigmaP1s = cat(2, sigmaP1s, sigmaP1);
    sigmaP2s = cat(2, sigmaP2s, sigmaP2);
    sigmaP3s = cat(2, sigmaP3s, sigmaP3);
end
figure;
plot(M, sigmaP1s, '--ob');
hold on;
plot(M, sigmaP2s, '--or');
plot(M, sigmaP3s, '--og');
hold off;
xlabel('Number of simulations'); ylabel('sigma');
legend('Control Variate', 'Non-control variate', 'Antithetic');
end