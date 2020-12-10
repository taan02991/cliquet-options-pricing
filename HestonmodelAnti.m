function [S, sigma, Shat, sigmahat] = HestonmodelAnti(S0, r, sigma0, kappa, theta, delta, rho, T, N)

dt = T/N;
S=nan(N+1,1);
sigma=nan(N+1,1);
Shat=nan(N+1,1);
sigmahat=nan(N+1,1);

S(1) = S0;
sigma(1)=sigma0;
Shat(1) = S0;
sigmahat(1)=sigma0;

for n=1:N
    eps12=mvnrnd([0 0],[1 rho; rho 1]);
    eps1=eps12(1);
    eps2=eps12(2);
    S(n+1)=S(n)*exp((r - 0.5*sigma(n)^2)*dt + sigma(n)*sqrt(dt)*eps1);
    sigma2=sigma(n)^2 + kappa*(theta - sigma(n)^2)*dt ...
                      + delta*sigma(n)*sqrt(dt)*eps2;
    sigma(n+1)=sqrt(max(sigma2,1e-6));
    
    Shat(n+1)=Shat(n)*exp((r - 0.5*sigmahat(n)^2)*dt + sigmahat(n)*sqrt(dt)*(-eps1));
    sigmahat2=sigmahat(n)^2 + kappa*(theta - sigmahat(n)^2)*dt ...
                      + delta*sigmahat(n)*sqrt(dt)*(-eps2);
    sigmahat(n+1)=sqrt(max(sigmahat2,1e-6));
end
end