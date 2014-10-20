function [ret] = assess_probability_map_script( prob, data, mprob )

	[truth] = adjust_border_effect( data.label, mprob );
	[prob_err] = compute_pixel_error( prob, truth );
	% plot_threshold_optimization( prob_err );
	plot_error( prob_err, 'Pixel error' );
	[mprob_err] = compute_pixel_error( mprob, truth );
	% plot_threshold_optimization( mprob_err );
	plot_error( mprob_err, 'Pixel error' );

	ret.prob_err = prob_err;
	ret.mprob_err = mprob_err;

end