function [ret] = compute_Rand_error( truth, watershed )

	% remove crust
	watershed = watershed(2:end-1,2:end-1,2:end-1);

	% adjust the size of the ground truth segmentation
	[cropped] = adjust_border_effect( truth, watershed );

	% compute rand error
	ret.segA = cropped;
	ret.segB = watershed;
	[result] = SNEMI3D_metrics( ret.segA, ret.segB );
	ret.err  = result.re;
	ret.prec = result.prec;
	ret.rec  = result.rec;

end