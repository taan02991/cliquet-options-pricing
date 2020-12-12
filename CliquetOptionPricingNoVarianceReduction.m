function [P, sigma, CI]=CliquetOptionPricingNoVarianceReduction(S0, r0, r_b, rbar, omega, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod)

% This function compute Cliquet option price by running simulation M times
% This version doesn't use any technique to reduce the variance

    X = nan(M, 1);
    % Simulate stock price and calculate cliquet price
	for i=1:M
        % simulate r by CIR model
        r = CIRModel(r0,r_b,rbar,omega,T,N);
		[S, ~, ~, ~] = HestonmodelAnti(S0, r, sigma0, kappa, theta, delta, rho, T, N);
  		X(i, 1) = computeCliquetPrice(S, S, N, Type, Cap, Floor, ResetPeriod, r, T);
    end
    [P, sigma, CI] = normfit(X);
end