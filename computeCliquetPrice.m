function [price] = computeCliquetPrice(S, Shat, N, Type, Cap, Floor, ResetPeriod, r, T)
	q = 0;
	qhat = 0;
	if strcmp(Type, 'C')
		Type=1;
	elseif strcmp(Type, 'P')
		Type=-1;
	else
		error('"type" must be either ''C'' or ''P''');
	end

	for n=ResetPeriod+1:ResetPeriod:N+1
		q  = q + max(0, min(Cap,Type*(S(n) - S(n-ResetPeriod)) / S(n-ResetPeriod)));
        qhat = qhat + max(0, min(Cap,Type*(Shat(n) - Shat(n-ResetPeriod)) / Shat(n-ResetPeriod)));
	end
	payoff = S(1) * ((max(q, Floor)+max(qhat,Floor))/2);
	price = payoff * exp(-r*T);
end
