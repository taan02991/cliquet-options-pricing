function [price]=computeAsianPrice(S,Shat,N,Type,K,r,T)

% This function compute the Asian option price for given stock price
% by using Antithetic technique

    % find mean of S from S1 to SN
	ST = mean(S(2:end)); 
	ShatT = mean(Shat(2:end));
    
    % calculate payoff using antithetic
	if strcmp(Type, 'C')
		payoff = (max(ST-K, 0) + max(ShatT-K, 0)) / 2;
	elseif strcmp(Type, 'P')
		payoff = (max(K-ST, 0) + max(K-ShatT, 0)) / 2;
	else
		error('"type" must be either ''C'' or ''P''')
    end
    
    % calculate price by discounting payoff
	price=payoff * exp(-sum(r(1:N))*T/N);
end
