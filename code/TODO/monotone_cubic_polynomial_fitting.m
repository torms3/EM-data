function [ret] = monotone_cubic_polynomial_fitting( prob, truth )

	%% Argument validity check
	assert(~(isempty(prob)|isempty(truth)));
	assert(isequal(size(prob),size(truth)));

	%%
	[x,ix] = sort(prob(:));
	y = truth(:);
	y = y(ix);

	%%	
	bin = 0.005;
	nbins = 1/bin;
	yi = zeros(nbins,1);
	idx = 1;
	for i=1:nbins		
		interval = ((x >= (bin*(i-1))) & (x <= bin*i));
		yi(i) = mean(y(interval));
	end
	xi = bin:bin:1;

	%%
	pp = pchip(xi,yi);

	%%
	ret.xi = xi;
	ret.yi = yi;
	ret.pp = pp;

end