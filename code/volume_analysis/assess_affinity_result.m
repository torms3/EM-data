function [ret] = assess_affinity_result( fname, data, filtrad, crop_volume )

	if ~exist('filtrad','var')
		filtrad = 0;
	end
	if ~exist('crop_volume','var')
		crop_volume = [];
	end
	each_affin = true;

	[ret] = prepare_affinity_result( fname, data, filtrad, crop_volume );

	if each_affin
		for i = 1:size(ret.prob,4)
			[ret.err{i}] = compute_pixel_error( ret.prob(:,:,:,i), ret.truth(:,:,:,i) );
			plot_threshold_optimization( ret.err{i} );
		end
	else
		[ret.err] = compute_pixel_error( ret.prob, ret.truth );
		plot_threshold_optimization( ret.err );
	end

	% plot_affinity_result( ret.err );
	plot_affinity_histogram( ret.prob );

end