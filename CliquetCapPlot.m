function CliquetCapPlot(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, M, Cap1,Cap2,nCap, Floor, ResetPeriod)

Cap=Cap1:(Cap2-Cap1)/(nCap-1):Cap2;
C=nan(nCap,1);
P=nan(nCap,1);
for i=1:nCap
    [C(i),~] = CliquetOptionPricing(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, 'C', M, Cap(i), Floor, ResetPeriod);
    [P(i),~] = CliquetOptionPricing(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, 'P', M, Cap(i), Floor, ResetPeriod);
end

figure; plot(Cap,C,'b'); hold on; plot(Cap,P,'r');
xlabel('Cap')
ylabel('Option Price')
legend('Call Option', 'Put Option')

end

