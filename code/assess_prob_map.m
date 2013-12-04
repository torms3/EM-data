function [] = assess_prob_map( prob, label )

	assert( isequal(size(prob),size(label)) );

	% compute pixel error
	[err] = compute_pixel_error( prob, label );

	% plot precision-recall curve
	% plot_affinity_result( err );

	% plot threshold optimization
	plot_threshold_optimization( err );

end