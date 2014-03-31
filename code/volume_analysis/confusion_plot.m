function confusion_plot( bmap, truth, thresh )

	%% Declare global variables
	%
	global z cmap
	images = bmap;
	h = figure;

	%% Color map
	%
	cmap = [0 0 0; 1 1 1; 0 0 1; 1 0 0];

	%% Figure
	%
	% h = figure;

	%% Extract image stack metadata
	%	and display the first image
	%	
	[~,~,nImages] = size(images);
	z = 1;
	img = double(images(:,:,z) > thresh);
	bMap = 	images(:,:,z) < thresh;
	FP = bMap & logical(truth(:,:,z));
	nFP = nnz(FP);
	img(FP) = 2;
	FN = ~bMap & ~logical(truth(:,:,z));	
	img(FN) = 3;
	nFN = nnz(FN);
	colormap(cmap);
	image(img+1);
	daspect( [1 1 1] );
	title( sprintf('z = %d, FP=%d, FN=%d, ERR=%d',z,nFP,nFN,nFP+nFN) );
	

	%% Set KeyPressFcn
	%
	set( h, 'KeyPressFcn', @(obj,evt) moveZ( evt.Key, images, truth, thresh ) );

end


function moveZ( key, images, truth, thresh )

	% global images nImages h z
	global z cmap
	[~,~,nImages] = size(images);

	switch key
	case 'uparrow'
		z = rem(z - 1,nImages);
		if( z == 0 )
			z = nImages;
		end
	case 'downarrow'
		z = rem(z + 1,nImages);
		if( z == 0 )
			z = nImages;
		end
	end

	img = double(images(:,:,z) > thresh);
	bMap = 	images(:,:,z) < thresh;
	FP = bMap & logical(truth(:,:,z));
	img(FP) = 2;
	nFP = nnz(FP);
	FN = ~bMap & ~logical(truth(:,:,z));	
	img(FN) = 3;
	nFN = nnz(FN);
	colormap(cmap);
	image(img+1);
	daspect([1 1 1]);
	title( sprintf('z = %d, FP=%d, FN=%d, ERR=%d',z,nFP,nFN,nFP+nFN) );

end