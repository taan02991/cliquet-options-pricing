function [P, sigma, CI]=CliquetOptionPricingNoVarianceReduction(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod)
	X = nan(M, 1);
	for i=1:M
		[S, ~, ~, ~] = HestonmodelAnti(S0, r, sigma0, kappa, theta, delta, rho, T, N);
  		X(i, 1) = computeCliquetPrice(S, S, N, Type, Cap, Floor, ResetPeriod, r, T);
    end
    [P, sigma, CI] = normfit(X);
end