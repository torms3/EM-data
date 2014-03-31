function [ret] = import_weight( fname, wsz )

	if ~exist('wsz','var')
		wsz = [5 5 3 16 16];	% temp
	end

	fw = fopen(fname,'r');
	
	nWeights = prod(wsz);
	ret = zeros(nWeights,1);
	ret = fread(fw,nWeights,'double');
	ret = reshape(ret,wsz);

	fclose(fw);

end