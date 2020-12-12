function [price] = computeCliquetPrice(S, Shat, N, Type, Cap, Floor, ResetPeriod, r, T)

% This function compute the Cliquet option with locally cap and globally floor price for given stock price
% by using Antithetic technique

    % q and qhat is accumulated payoff in percentage
    q = 0;
	qhat = 0;
    
	if strcmp(Type, 'C')
		Type=1;
	elseif strcmp(Type, 'P')
		Type=-1;
	else
		error('"type" must be either ''C'' or ''P''');
    end
    
    % Accumulate payoff(in percentage) from the first reset period to the
    % last reset period
	for n=ResetPeriod+1:ResetPeriod:N+1
 		q  = q + max(0, min(Cap,Type*(S(n) - S(n-ResetPeriod)) / S(n-ResetPeriod)));
        qhat = qhat + max(0, min(Cap,Type*(Shat(n) - Shat(n-ResetPeriod)) / Shat(n-ResetPeriod)));
    end
    % payoff = Notional * max(q, Floor)
    % Notional is the stock price when the contract is issued
  	payoff = S(1) * ((max(q, Floor)+max(qhat,Floor))/2);
	price = payoff * exp(-sum(r(1:N))*T/N);
end
