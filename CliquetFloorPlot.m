function CliquetFloorPlot(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, M, Cap, Floor1, Floor2, nFloor, ResetPeriod)

Floor=Floor1:(Floor2-Floor1)/(nFloor-1):Floor2;
C=nan(nFloor,1);
P=nan(nFloor,1);
for i=1:nFloor
    [C(i),~] = CliquetOptionPricingAntithetic(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, 'C', M, Cap, Floor(i), ResetPeriod);
    [P(i),~] = CliquetOptionPricingAntithetic(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, 'P', M, Cap, Floor(i), ResetPeriod);
end

figure; plot(Floor,C,'b'); hold on; plot(Floor,P,'r');
xlabel('Floor')
ylabel('Option Price')
legend('Call Option', 'Put Option')

end

