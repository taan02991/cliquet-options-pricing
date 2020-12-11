function [b, CType] = FindBestCAndComputeB(S0, r, sigma0, kappa, theta, delta, rho, T, N, K, Type, M, Cap, Floor, ResetPeriod)

% This function is used to find the best C variable and compute b which is used in Control Variate technique
% 
% For C variable, we compare between payoff of Asian and Euro option  to find which one has 
% the highest correlation with the payoff of Cliquet option
% 
% To compute b:
% b =  b = sum((X - Xbar) .* (C - Cbar)) / sum((C - Cbar).^2);

    X = nan(M, 1);
	A = nan(M, 1);
    E = nan(M, 1);

    % Simulate stock price using heston model and compute the price of Cliquet, Asian and Euro option
	for i=1:M
		[S, ~, Shat, ~] = HestonmodelAnti(S0, r, sigma0, kappa, theta, delta, rho, T, N);
  		X(i, 1) = computeCliquetPrice(S, Shat, N, Type, Cap, Floor, ResetPeriod, r, T);
		A(i,1) = computeAsianPrice(S,Shat,N,Type,K, r, T);
        E(i, 1) = computeEuroPrice(S,Shat,N,Type,K, r, T);
    end

    % Find correlation between (Cliquet, Asian) and (Cliquet, Euro)
    corrA = corrcoef(X,A);
    corrE = corrcoef(X,E);
    Xbar = mean(X);
    % Choose the option that has the highest correlation to compute the b
    if corrA(1, 2) > corrE(1, 2)
        CType = 'A';
        Abar = mean(A);
        b = sum((X - Xbar) .* (A - Abar)) / sum((A-Abar).^2);
    else
        CType = 'E';
        Ebar = mean(E);
        b = sum((X - Xbar) .* (E - Ebar)) / sum((E-Ebar).^2);
    end
end