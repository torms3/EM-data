function [ret] = assess_boundary_result_script( fname, data )

	[out] = import_multivolume( fname );

	outIdx = 2;
	filtrad = 4;
	appply_exp = false;
	[prob,mprob] = generate_prob_map( out, outIdx, filtrad, appply_exp );

	[truth] = adjust_border_effect( data.label, mprob );
	[prob_err] = compute_pixel_error( prob, truth );
	plot_threshold_optimization( prob_err );
	[mprob_err] = compute_pixel_error( mprob, truth );
	plot_threshold_optimization( mprob_err );

	ret.out = out;
	ret.prob = prob;
	ret.prob_err = prob_err;
	ret.mprob = mprob;
	ret.mprob_err = mprob_err;

end