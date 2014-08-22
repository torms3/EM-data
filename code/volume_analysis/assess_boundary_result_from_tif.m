function [ret] = assess_boundary_result_from_tif( fname, data )

	stack = loadtiff( fname );
	[truth] = adjust_border_effect( data.label, stack );
	[ret] = compute_pixel_error( stack, truth );
	plot_threshold_optimization( ret );

end