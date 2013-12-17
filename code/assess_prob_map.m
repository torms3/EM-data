function [] = assess_prob_map( prob, label, fmax )

	assert( isequal(size(prob),size(label)) );
	if( ~exist('fmax','var') )
		fmax = false;
	end

	% compute pixel error
	if( fmax )
		[err] = compute_pixel_error_maximal_Fscore( prob, label );
	else
		[err] = compute_pixel_error( prob, label );
	end

	% plot precision-recall curve
	plot_affinity_result( err );

	% plot threshold optimization
	plot_threshold_optimization( err );

end