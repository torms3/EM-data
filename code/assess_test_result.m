function [err,segm,chann] = assess_test_result( fname, segIdx )

	%% Options
	%
	showError = true;
	showOutputImages = false;
	showGroundAffinity = false;
	symm_affin = true;


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
	if( symm_affin )
		G.x = G.x(1:end-1,1:end-1,1:end-1);
		G.y = G.y(1:end-1,1:end-1,1:end-1);
		G.z = G.z(1:end-1,1:end-1,1:end-1);
	end

	% mask
	fprintf('Now generating mask...\n');
	msk = mask{segIdx}{:};
	
	msk = msk(2:end,2:end,2:end);
	% [kisuklee: symmetric affinity]
	if( symm_affin )
		msk = msk(1:end-1,1:end-1,1:end-1);
	end


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

	%% Error
	%
	if( showError )
		% compute error
		tic
		[err] = compute_affinity_error( img, G, msk );
		toc
		% plot precision-recall curve
		plot_affinity_result( err );
	else
		err = [];
	end


	%% Plot output
	%
	if( showOutputImages )
		interactive_plot4_test( chann, img{1}, img{2}, img{3}, 'gray' );
	end
	if( showGroundAffinity )
		interactive_plot4_test( chann, G.x, G.y, G.z, 'gray' );
	end

end