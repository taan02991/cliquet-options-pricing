function CliquetCapFloorPlot(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, M, Cap1,Cap2,nCap, Floor1,Floor2,nFloor, ResetPeriod)

Cap=Cap1:(Cap2-Cap1)/(nCap-1):Cap2;
Floor=Floor1:(Floor2-Floor1)/(nFloor-1):Floor2;
C=nan(nCap,nFloor);
P=nan(nCap,nFloor);
for i=1:nCap
    for j=1:nFloor
        [C(i,j),~] = CliquetOptionPricing(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, 'C', M, Cap(i), Floor(j), ResetPeriod);
        [P(i,j),~] = CliquetOptionPricing(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, 'P', M, Cap(i), Floor(j), ResetPeriod);
    end
end

figure; plot3(Cap,Floor,C,'b'); hold on; plot3(Cap,Floor,P,'r');
xlabel('Cap')
ylabel('Floor')
zlabel('Option Price')
legend('Call Option', 'Put Option')

end

