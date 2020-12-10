function [b, Xbar, Cbar] = ComputeB(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod)
	X = nan(M, 1);
	C = nan(M, 1);
	for i=1:M
		[S, ~, Shat, ~] = HestonmodelAnti(S0, r, sigma0, kappa, theta, delta, rho, T, N);
  		X(i, 1) = computeCliquetPrice(S, Shat, N, Type, Cap, Floor, ResetPeriod, r, T);
		C(i, 1) = computeAsianPrice(S,Shat,N,Type,K, r, T);
end
    Xbar = mean(X);
    Cbar = mean(C);
 	b = sum((X - Xbar) .* (C - Cbar)) / sum((C-Cbar).^2);
end
