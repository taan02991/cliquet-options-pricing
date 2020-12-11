function [price] = CliquetControlVariate(S, N, Type, K, Cap, Floor, ResetPeriod, r, T, b, CType)
% CType => 'A' for Asian, 'E' for Euro

if strcmp(CType,'A')
    C = computeAsianPrice(S,S,N,Type,K,r,T);
elseif strcmp(CType,'E')
    C = computeEuroPrice(S,S,N,Type,K,r,T);
else
    error('"type" must be either ''A'' or ''E''')
end
X = computeCliquetPrice(S, S, N, Type, Cap, Floor, ResetPeriod, r, T);
price = X - b*(C-mean(C));

end