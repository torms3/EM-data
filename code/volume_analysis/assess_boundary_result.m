function [ret] = assess_boundary_result( fname, data, filtrad )

	if ~exist('filtrad','var')
		filtrad = [];
	end
	
	[out] = import_multivolume( fname );

	outIdx = 2;
	[prob,mprob] = generate_prob_map( out, outIdx, filtrad );

	ret.out = out;
	ret.prob = prob;
	ret.mprob = mprob;

	if exist('data','var')
		[err] = assess_probability_map_script( prob, data, mprob );
		ret.prob_err  = err.prob_err;
		ret.mprob_err = err.mprob_err;
	end

end