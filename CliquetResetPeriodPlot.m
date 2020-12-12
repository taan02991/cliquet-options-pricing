function [PriceC, PriceP, ResetPeriod]=CliquetResetPeriodPlot(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, M, Cap, Floor, ResetPeriod1, ResetPeriod2)
ResetPeriod = [];
PriceC = [];
PriceP = [];

for i = ResetPeriod1:ResetPeriod2
    if mod(N, i) == 0
        ResetPeriod = cat(2, ResetPeriod, i);
        PriceC = cat(2, PriceC, CliquetOptionPricingAntithetic(S0, r0, r_b, rbar, omega, sigma0,, kappa, theta, delta, rho, T, N, K, 'C', M, Cap, Floor, i));
        PriceP = cat(2, PriceP, CliquetOptionPricingAntithetic(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, 'P', M, Cap, Floor, i));
    end

end

figure;
plot(ResetPeriod, PriceC, 'b');
hold on;
plot(ResetPeriod, PriceP, 'r');
hold off;
xlabel('Reset Period'); ylabel('Option Price');
legend('Cliquet Call', 'Cliquet Put');
end