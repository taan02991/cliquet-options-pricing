function [corrA,corrE,X,A,E,q,qhat] = FindBestC(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod)
	X = nan(M, 1);
	A = nan(M, 1);
    E = nan(M, 1);
    q = nan(M,1);
    qhat = nan(M,1);
	for i=1:M
		[S, ~, Shat, ~] = HestonmodelAnti(S0, r, sigma0, kappa, theta, delta, rho, T, N);
  		[X(i, 1),q(i,1),qhat(i,1)] = computeCliquetPrice(S, Shat, N, Type, Cap, Floor, ResetPeriod, r, T);
		A(i,1) = computeAsianPrice(S,Shat,N,Type,K, r, T);
        E(i, 1) = computeEuroPrice(S,Shat,N,Type,K, r, T);
end
    corrA = corrcoef(X,A);
    corrE = corrcoef(X,E);
end
