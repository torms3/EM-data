[ret] = prepare_affinity_result( fname, data );
[err] = compute_pixel_error( ret.prob, ret.truth );
plot_threshold_optimization( err );
% plot_affinity_result( err );
% plot_affinity_histogram( ret.prob );