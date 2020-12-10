function [price] = computeEuroPrice(S, Shat, N, Type, K, r, T)
    ST= S(end);
    ShatT = Shat(end);
    if strcmp(Type, 'C')
    		payoff = (max(ST-K, 0) + max(ShatT-K, 0)) / 2;
    	elseif strcmp(Type, 'P')
    		payoff= (max(K-ST, 0) + max(ShatT-K, 0)) / 2;
    	else
    		error('"type" must be either ''C'' or ''P''')
    	end
    	price = payoff * exp(-r*T);
end
