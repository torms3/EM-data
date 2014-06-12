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
		[truth] = adjust_border_effect( data.label, mprob );
		[prob_err] = compute_pixel_error( prob, truth );
		plot_threshold_optimization( prob_err );
		[mprob_err] = compute_pixel_error( mprob, truth );
		plot_threshold_optimization( mprob_err );

		ret.prob_err = prob_err;
		ret.mprob_err = mprob_err;
	end

end