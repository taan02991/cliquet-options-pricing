function r=CIRModel(r0,b,rbar,omega,T,N)

% This function simulates the interest paths
% of CIR model:
% 
% r(t+1) = r(t) + b*(rbar - r(t))*dt + omega*sqrt(r(t))*dW(t)

dt=T/N;
r=nan(N+1,1);
r(1)=r0;

for t=1:N
    eps=randn(1);
    r(t+1) = r(t) + b*(rbar - r(t))*dt + omega*sqrt(max(r(t),1e-6))*sqrt(dt)*eps;
end

end