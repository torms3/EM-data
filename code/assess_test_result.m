function [ret] = assess_test_result( fname, segIdx )

	% load raw data
	fprintf('Now loading e2006_e2198_kisuk.mat...\n');
	load('~/Workbench/seung-lab/EM-data/data/e2006_e2198_kisuk.mat');
	fprintf('Done!\n\n');

	% import forward image
	[img] = import_forward_image( fname );

	% original affinity graph
	[G] = generate_affinity_graph( seg{segIdx}{:} );

	% mask
	msk = mask{segIdx}{:};
	msk = msk(1:end-1,1:end-1,1:end-1);

	% compute error
	[ret] = compute_affinity_error( img, G, msk );

	% plot precision-recall curve
	plot_affinity_result( ret );

	% plot output
	interactive_plot4_test( im{segIdx}, img{1}, img{2}, img{3}, 'gray' );

end