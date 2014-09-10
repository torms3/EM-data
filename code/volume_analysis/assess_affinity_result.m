function [ret] = assess_affinity_result( fname, data )

	load_from_tif = true;

	[ret] = prepare_affinity_result( fname, data, load_from_tif );
	[ret.err] = compute_pixel_error( ret.prob, ret.truth );
	plot_threshold_optimization( ret.err );

	plot_affinity_result( ret.err );
	plot_affinity_histogram( ret.prob );

end