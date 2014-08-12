function [ret] = assess_boundary_result_script( fname, data, apply_exp )

	if ~exist('apply_exp','var')
		apply_exp = false;
	end

	[out] = import_multivolume( fname );

	outIdx = 2;
	filtrad = 5;
	% outIdx = 1;
	% filtrad = 2;
	% apply_exp = true;
	[prob,mprob] = generate_prob_map( out, outIdx, filtrad, apply_exp );

	ret.out = out;
	ret.prob = prob;
	ret.mprob = mprob;

	if exist('data','var')
		[err] = assess_probability_map_script( prob, data, mprob );
		ret.prob_err  = err.prob_err;
		ret.mprob_err = err.mprob_err;
	end

end