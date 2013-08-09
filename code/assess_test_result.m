function [err,segm,chann] = assess_test_result( fname, segIdx )

	%% Options
	%
	showOutputImages = false;


	% load raw data
	fprintf('Now loading e2006_e2198_kisuk.mat...\n');
	load('~/Workbench/seung-lab/EM-data/data/e2006_e2198_kisuk.mat');
	fprintf('Done!\n\n');

	% import forward image
	fprintf('Now importing forward image...\n');
	[img] = import_forward_image( fname, segIdx );
	segm = cat(4,img{1},img{2},img{3});

	% original affinity graph
	fprintf('Now generating affinity graph...\n');
	[G] = generate_affinity_graph( seg{segIdx}{:} );

	% mask
	fprintf('Now generating mask...\n');
	msk = mask{segIdx}{:};
	% msk = msk(1:end-1,1:end-1,1:end-1);
	msk = msk(2:end,2:end,2:end);


	%% Adjusting size difference between forward image and ground truth
	% 
	fprintf('Now adjusting size difference...\n');
	szDiff = size(msk,1) - size(img{1},1);
	hSzDiff = floor(szDiff/2);
	G.x   = G.x(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff);
	G.y   = G.y(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff);
	G.z   = G.z(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff);
	msk   = msk(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff);
	
	% channel
	chann = im{segIdx};
	chann = chann(2:end,2:end,2:end);
	chann = chann(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff);


	%% Compute error
	%
	tic
	[err] = compute_affinity_error( img, G, msk );
	toc


	%% Plot precision-recall curve
	% 
	plot_affinity_result( err );


	%% Plot output
	%
	if( showOutputImages )
		interactive_plot4_test( im{segIdx}, img{1}, img{2}, img{3}, 'gray' );
	end

end