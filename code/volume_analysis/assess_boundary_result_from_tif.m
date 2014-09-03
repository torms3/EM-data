function [ret] = assess_boundary_result_from_tif( fname, data )

	ret.stack = loadtiff(fname);
	[ret.stack] = scaledata(double(ret.stack),0,1);
	[ret.truth] = adjust_border_effect(data.label,ret.stack);
	[ret.err] = compute_pixel_error(ret.stack,ret.truth);
	plot_threshold_optimization(ret.err);

end